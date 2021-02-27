import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/constants/Dictionary.dart';
import 'package:truthordare/constants/FontsFamily.dart';

class BuildTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final validation;
  final TextInputType textInputType;
  final TextStyle textStyle;
  final bool isEdit;
  final int maxLines;
  final bool qrIcon;
  final TextCapitalization textCapitalization;
  bool obsecureText;
  final String descriptionText;
  final double roundedBorder;

  /// @params
  /// * [title] type String must not be null.
  /// * [hintText] type String must not be null.
  /// * [controller] type from class TextEditingController must not be null.
  /// * [validation] type from class Validation.
  /// * [textInputType] type from class TextInputType.
  /// * [textStyle] type from class TextStyle.
  /// * [isEdit] type bool.
  BuildTextField(
      {Key key,
      this.title,
      this.hintText,
      this.controller,
      this.validation,
      this.textInputType,
      this.textStyle,
      this.isEdit,
      this.maxLines,
      this.qrIcon = false,
      this.textCapitalization = TextCapitalization.characters,
      this.obsecureText = false,
      this.descriptionText,
      this.roundedBorder})
      : super(key: key);

  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              widget.title.isEmpty
                  ? Container()
                  : Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w700,
                        fontFamily: FontsFamily.roboto,
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  maxLines: widget.maxLines != null ? widget.maxLines : 1,
                  style: widget.isEdit
                      ? TextStyle(
                          color: Colors.black,
                          fontFamily: FontsFamily.roboto,
                          fontSize: 13)
                      : TextStyle(
                          color: Color(0xffBDBDBD),
                          fontFamily: FontsFamily.roboto,
                          fontSize: 13),
                  enabled: widget.isEdit,
                  validator: widget.validation,
                  textCapitalization: widget.textCapitalization,
                  obscureText: widget.obsecureText,
                  controller: widget.controller,
                  decoration: InputDecoration(
                      suffixIcon: widget.title == Dictionary.password
                          ? IconButton(
                              icon: (Icon(
                                widget.obsecureText
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: Colors.grey,
                                size: 20,
                              )),
                              onPressed: () {
                                setState(() {
                                  widget.obsecureText = !widget.obsecureText;
                                });
                              })
                          : null,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: FontsFamily.roboto,
                          fontSize: 13),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.roundedBorder),
                          borderSide:
                              BorderSide(color: Colors.grey[600], width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.roundedBorder),
                          borderSide:
                              BorderSide(color: Colors.grey[600], width: 1)),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.roundedBorder),
                          borderSide:
                              BorderSide(color: Colors.grey[600], width: 1))),
                  keyboardType: widget.textInputType != null
                      ? widget.textInputType
                      : TextInputType.text,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              widget.qrIcon
                  ? Container(
                      height: 60,
                      width: 60,
                      child: RaisedButton(
                        elevation: 0,
                        color: Colors.white,
                        shape: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(widget.roundedBorder),
                            borderSide: BorderSide(
                                color: Color(0xffE0E0E0), width: 1.5)),
                        onPressed: () async {
                          var barcode = await BarcodeScanner.scan();
                          if (barcode.rawContent != '') {
                            setState(() {
                              widget.controller.text = barcode.rawContent;
                            });
                          }
                        },
                        child: Icon(
                          FontAwesomeIcons.qrcode,
                          color: ColorBase.green,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          widget.descriptionText != null
              ? SizedBox(
                  height: 10,
                )
              : Container(),
          widget.descriptionText != null
              ? Text(
                  widget.descriptionText,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                    fontFamily: FontsFamily.roboto,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
