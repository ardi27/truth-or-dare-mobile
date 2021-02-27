import 'package:flutter/material.dart';
import 'package:truthordare/constants/FontsFamily.dart';

class EmptyData extends StatelessWidget {
  final String message, desc;
  final bool center;
  final EdgeInsetsGeometry margin;
  final String image;

  /// * [message] type String must not be null.
  /// * [desc] type String.
  /// * [margin] type from class EdgeInsetsGeometry.
  /// * [center] type bool default value is true.
  /// * [image] type String must not be null if [isFlare] is false.
  EmptyData(
      {Key key,
      this.message,
      this.desc,
      this.center = true,
      this.margin,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (center) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              child: Image.asset(image),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(message,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontsFamily.roboto,
                    color: Colors.grey[800],
                    fontSize: 15)),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Text(desc == null ? '' : desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: FontsFamily.roboto,
                      fontSize: 12,
                      color: Colors.grey[600])),
            )
          ],
        ),
      );
    } else {
      return Container(
        alignment: Alignment.topCenter,
        margin: margin,
        child: Column(
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              child: Image.asset(image),
            ),
            Text(message,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontsFamily.lato,
                    fontSize: 14)),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(desc ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: FontsFamily.lato, fontSize: 12)),
            )
          ],
        ),
      );
    }
  }
}
