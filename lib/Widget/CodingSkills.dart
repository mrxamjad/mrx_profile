// Code for Coding Section

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/Widget/HeadingTitle.dart';
import 'package:mrx_profile/Widget/drawer.dart';
import 'package:mrx_profile/Widget/skillProgress.dart';
import 'package:mrx_profile/Widget/style.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

int getPercent(String level) {
  if (level == "Expert") {
    return 100;
  } else if (level == "Advance") {
    return 75;
  } else if (level == "InterMediat") {
    return 50;
  } else {
    return 25;
  }
}

Padding CodingSection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: HeadingTitle(title: "Excellence In Programing & Coding"),
        ),
        Container(
            height: context.screenHeight < 550
                ? 180
                : context.screenWidth >= 500
                    ? context.percentHeight * 34
                    : context.percentHeight * 30,
            width: context.percentWidth * 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: xcoloryellow, width: 3)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 15),
                  child: Text(
                    "Coding Skills",
                    style: xTextStyle(bold: true),
                  ),
                ),
                Expanded(
                  child: Container(
                    // width: 200,
                    height: 220,
                    child: StreamBuilder(
                      stream: FirestoreService.readCodingSkill(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final codingData = snapshot.data;
                          // codingData!.sort();
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: codingData!.length,
                            itemBuilder: (context, index) {
                              return SkillProgressCircular(
                                percent: getPercent(codingData[index]['level']),
                                skillName: codingData[index]['skill'],
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return CircularPercentIndicator(radius: 20);
                        }
                      },
                    ),
                  ),
                )
              ],
            )),
      ],
    ),
  );
}
