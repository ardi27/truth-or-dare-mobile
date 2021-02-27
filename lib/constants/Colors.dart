import 'dart:ui' show Color;

class ColorBase {
  static final kPrimaryColor=Color(0xFF232fa2);
  static final kSecondaryColor=Color(0xFFf9c203);
  static final blue = Color(0xFF00AADE);
  static final green = Color(0xFF009D57);
  static final green800 = Color(0xFF008444);
  static final green900 = Color(0xFF006430);
  static final grey = Color(0xFFFAFAFA);
  static final pink = Color(0xFFD71149);
  static final bubbleChatBlue = Color(0xFFD5E9F4);
  static final darkRed = Color(0xFFD23C3C);
  static final announcementBackgroundColor = Color(0xFFFFF3CC);
  static final lightGrey = Color(0xffE3E7ED);
  static final strongBlue = Color(0xff1565C0);
  static final green2 = Color(0xff27AE60);
  static final yellow700 = Color(0xffFFA600);
  static final menuBorderColor = Color(0xFFE0E0E0);
  static final disableText = Color(0xffBDBDBD);

  static final gradientBlue = [Color(0xFF00AADE), Color(0xFF0669B1)];
  static final gradientBlueToPurple = [Color(0xFF005C97), Color(0xFF363795)];
  static final gradientBlueOpacity = [
    Color(0xFF00AADE),
    Color(0xFF0669B1).withOpacity(0.8)
  ];
  static final gradientBlackOpacity = [
    Color(0xFF000000).withOpacity(0.1),
    Color(0xFF000000).withOpacity(0.7)
  ];

  static final yellow = Color(0xfffdcc3b);
  static final orange = Color(0xffe8b638);

  static final healthStatusColors =
      '{"healthy": "009d57","odp": "fff45a","pdp": "ffc831","confirmed": "ff0000"}';
}
