import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: Constants.mainFont,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: Constants.titleFont,
          fontFamily: Constants.mainFont,
          color: Colors.black87,
        ),
      ),
    );
  }
}
