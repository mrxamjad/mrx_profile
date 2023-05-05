import 'package:flutter/material.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

Padding skillProgress(
    {required BuildContext context,
    required String skillName,
    required int perscent,
    double width = 100}) {
  String centerText = "";
  if (perscent <= 25) {
    centerText = "Beginner";
  } else if (perscent <= 50) {
    centerText = "InterMediat";
  } else if (perscent <= 75) {
    centerText = "Advance";
  } else {
    centerText = "Expert";
  }
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 8),
          child: Text(
            skillName,
            style: const TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        LinearPercentIndicator(
          width: width,
          animation: true,
          lineHeight: 10.0,
          animationDuration: 2000,
          percent: perscent / 100,
          center: Text(
            centerText,
            style: TextStyle(fontSize: 8),
          ),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: xcolorGreenAccent,
        ),
      ],
    ),
  );
}

Padding SkillProgressCircular(
    {required int percent,
    required String skillName,
    double size = 50,
    double width = 13,
    Color color = Colors.purple,
    double innerFontSize = 14,
    double outerFontSize = 17,
    Color innerFontColors = Colors.white,
    Color outerFontColor = Colors.white}) {
  String centerText = "";
  if (percent <= 25) {
    centerText = "Beginner";
  } else if (percent <= 50) {
    centerText = "Medium";
  } else if (percent <= 75) {
    centerText = "Advance";
  } else {
    centerText = "Expert";
  }
  return Padding(
    padding: const EdgeInsets.all(5),
    child: CircularPercentIndicator(
      radius: size,
      lineWidth: width,
      animation: true,
      percent: percent / 100,
      center: Text(
        centerText,
        style: TextStyle(
            color: innerFontColors,
            fontWeight: FontWeight.bold,
            fontSize: innerFontSize),
      ),
      footer: Text(
        skillName,
        style: TextStyle(
            color: outerFontColor,
            fontWeight: FontWeight.bold,
            fontSize: outerFontSize),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: color,
    ),
  );
}
