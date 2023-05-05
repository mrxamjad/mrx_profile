import 'package:flutter/material.dart';
import 'package:mrx_profile/constants/xcolor.dart';

Container HeadingTitle(
    {required String title,
    Color? borderColor,
    Color? textColor,
    double fontSize = 16}) {
  return Container(
    margin: const EdgeInsets.all(20),
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor ?? xcolorGreenAccent, width: 2)),
    child: Center(
      child: Text(
        "$title",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: textColor ?? Colors.white),
      ),
    ),
  );
}
