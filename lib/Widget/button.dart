import 'package:flutter/material.dart';
import 'package:mrx_profile/constants/xcolor.dart';

Row xElevatedButton(String buttonName, IconData? icon) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        buttonName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      if (icon != null)
        Icon(
          icon,
          color: xcoloryellow,
        )
    ],
  );
}

Container xDesigButton(
    {String? buttonName,
    IconData? icon,
    Color borderColor = Colors.greenAccent,
    Color textColor = Colors.white,
    double borderRadius = 20,
    double borderWidth = 2,
    bool iconBefore = false}) {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            width: borderWidth,
            color: borderColor,
          )),
      margin: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null && iconBefore)
            Icon(
              icon,
              color: xcoloryellow,
            ),
          Text(
            buttonName ?? "Button",
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          if (icon != null && !iconBefore)
            SizedBox( width: 5,),
            Icon(
              icon,
              color: xcolorPink,
            )
        ],
      ));
}
