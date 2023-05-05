// Code for Coding Section
import 'package:flutter/material.dart';
import 'package:mrx_profile/Widget/skillProgress.dart';
import 'package:mrx_profile/Widget/style.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

Padding CodingSection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
    child: Container(
        height: context.percentHeight * 26,
        width: context.percentWidth * 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: xcoloryellow, width: 3)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Text(
                "Coding Skills",
                style: xTextStyle(bold: true),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkillProgressCircular(
                    percent: 100,
                    skillName: "Flutter",
                    color: xcoloryellow,
                  ),
                  SkillProgressCircular(
                      percent: 75, skillName: "Dart", color: xcolorGreenAccent),
                  SkillProgressCircular(
                    percent: 50,
                    skillName: "Java",
                    color: Colors.teal,
                  ),
                  SkillProgressCircular(
                      innerFontSize: 14,
                      percent: 25,
                      skillName: "Web Development",
                      color: Colors.red[400]!)
                ],
              ),
            )
          ],
        )),
  );
}
