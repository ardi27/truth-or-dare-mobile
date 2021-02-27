import 'package:flutter/material.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/constants/FontsFamily.dart';

class CustomAppBar {
  static AppBar defaultAppBar(
      {Widget leading,
      @required String title,
      List<Widget> actions,
      PreferredSizeWidget bottom,
      double padding}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      leading: leading,
      title: Padding(
        padding: EdgeInsets.only(left: padding ?? 0.0),
        child: setTitleAppBar(title),
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  static AppBar searchAppBar(
      BuildContext context, TextEditingController textController) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: Wrap(children: [
          Container(
              width: 25.0,
              height: 30.0,
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: 20.0,
              )),
          Container(
            width: MediaQuery.of(context).size.width - 100,
            height: 30.0,
            child: TextField(
                controller: textController,
                autofocus: true,
                maxLines: 1,
                minLines: 1,
                maxLength: 255,
                style: TextStyle(color: Colors.black, fontSize: 15.0),
                decoration: InputDecoration(
                    hintText: 'Ketikkan kata kunci ...',
                    counterText: "",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(5.0))),
          ),
        ]),
      ),
      titleSpacing: 0.0,
    );
  }

  static AppBar bottomSearchAppBar(
      {@required TextEditingController searchController,
      @required String title,
      String hintText,
      ValueChanged<String> onChanged,
      ValueChanged<String> onSubmitted,
      BuildContext context,
      bool customBackButton = false}) {
    return AppBar(
        elevation: 0,
        titleSpacing: customBackButton ? 0 : 15.0,
        leading: customBackButton
            ? Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              )
            : null,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: buildSearchField(
              searchController, hintText, onChanged, onSubmitted),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: CustomAppBar.setTitleAppBar(title),
        ));
  }

  static Text setTitleAppBar(String title) {
    return Text(title,
        style: TextStyle(
            fontFamily: FontsFamily.roboto,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black),
        maxLines: 1,
        overflow: TextOverflow.ellipsis);
  }

  static Widget buildSearchField(
      TextEditingController searchController,
      String hintText,
      ValueChanged<String> onChanged,
      ValueChanged<String> onSubmitted) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
      height: 40.0,
      decoration: BoxDecoration(
          color: ColorBase.grey,
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey[400]),
          borderRadius: BorderRadius.circular(6.0)),
      child: TextField(
          controller: searchController,
          autofocus: false,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey[600],
                size: 35,
              ),
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Color(0xff828282), fontSize: 12, height: 2.2),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0)),
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontFamily: FontsFamily.roboto),
          onChanged: onChanged,
          onSubmitted: onSubmitted),
    );
  }
}
