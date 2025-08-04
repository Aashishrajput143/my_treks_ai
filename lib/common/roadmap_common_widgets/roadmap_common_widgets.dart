import 'package:flutter/material.dart';

import '../../resources/font.dart';

//roadmap buttons

Widget commonRoadMapTileButton(
  Color backgroundColor,
  Color color,
  VoidCallback? onChanged, {
  Color borderColor = Colors.transparent,
  bool minimumSize = false,
  bool bold = false,
  double fontSize = 16,
  String hint = '',
  double radius = 12,
}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      elevation: 15,
      minimumSize: const Size(0, 33),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        hint,
        style: TextStyle(fontSize: fontSize, fontFamily: bold ? appFonts.NunitoBold : appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
      ),
    ),
  );
}

//roadmap ends
