import 'dart:math';

import 'package:flutter/material.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';


Padding skillProgress(
    {required BuildContext context,
    required String skillName,
    required int perscent,
    double width = 100}) {
  String centerText = "";
  if (perscent <= 25) {
    centerText = "Beginner";
  } else if (perscent <= 50) {
    centerText = "Intermediate";
  } else if (perscent <= 75) {
    centerText = "Advance";
  } else {
    centerText = "Expert";
  }
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 35, top: 8),
          child: Text(
            skillName,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Center(
            child: LinearPercentIndicator(
              width: width,
              animation: true,
              barRadius: Radius.circular(20),
              lineHeight: 10.0,
              animationDuration: 2000,
              percent: perscent / 100,
              center: Text(
                centerText,
                style: TextStyle(fontSize: 8),
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.primaries[
              Random().nextInt(Colors.primaries.length)],
            ),
          ),
        ),
      ],
    ),
  );
}

Padding SkillProgressCircular(
    {required int percent,
    required String skillName,
    double size = 40,
    double width = 10,
    Color color = Colors.purple,
    double innerFontSize = 12,
    double outerFontSize = 15,
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
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    child: Center(
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
        footer: SizedBox(
          width: size*2.5,
          child: Expanded(
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                softWrap: true,


                skillName,
                style: TextStyle(
                    color: outerFontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: outerFontSize),
              ),
            ),
          ),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: color,
      ),
    ),
  );
}
