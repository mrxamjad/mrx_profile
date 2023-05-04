import 'package:flutter/material.dart';

TextStyle xTextStyle(
    {double fontSize = 16,
    bool bold = false,
    bool italic = false,
    Color color = Colors.white}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal);
}
