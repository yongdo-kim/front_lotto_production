import 'package:flutter/material.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';

class ColorTheme {
  /*
  노란색 : 1-10번
  파란색 : 11-20번
  빨간색 : 21-30번
  회색 : 31-40번
  초록색 : 41-45번
  */

  //#68C5EF
  static Color cYellow = Color(0xFFFBC300);
  static Color cBlue = Color(0xFF6AC8F2);
  static Color cRed = Color(0xFFFF7171);
  static Color cGrey = Color(0xFFAAAAAA);
  static Color cGreen = Color(0xFFB0D940);
}

ThemeData buildColorTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    // App Bar title Theme]
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    // App Bar Theme
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
          headline6: FontTheme.cR20Regular.apply(color: Colors.black)),
      centerTitle: true,
      elevation: 1,
      color: Color(0xFFE7B5C1),
      iconTheme: IconThemeData(
        color: Color(0xFF000035).withOpacity(0.5),
      ),
    ),
  );
}
