import 'package:flutter/material.dart';
import 'package:vroar/resources/colors.dart';

class AppGradients {
  static const LinearGradient loginGradient = LinearGradient(
    colors: [
      Color(0xFFFFD503),
      Color(0xFFFFD503),
      Color(0xFFFFD503),
      Color(0xFFFFD503),
      Color(0xFFFFFFFF),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient commonGradient = LinearGradient(
    colors: [
      const Color(0xD8FBAB98).withOpacity(0.2),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static LinearGradient roleGradient= LinearGradient(
    colors: [
      const Color(0xD8FBAB98).withOpacity(0.3),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static LinearGradient customGradient= LinearGradient(
    colors: [
      const Color(0xD8FABFB2).withOpacity(0.3),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static LinearGradient tabGradient= LinearGradient(
    colors: [
      appColors.contentAccent,
      appColors.contentAccentLinearColor3,
      appColors.contentAccentLinearColor2,
      appColors.contentAccentLinearColor1,
      appColors.contentAccentLinearColor05,
      appColors.contentAccentLinearColor,

    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
      tileMode: TileMode.clamp
  );
}
