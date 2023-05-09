// Skill Sections
import 'package:flutter/material.dart';
import 'package:mrx_profile/Controller/ClassData.dart';
import 'package:mrx_profile/Widget/AchivementItem.dart';
import 'package:mrx_profile/Widget/HeadingTitle.dart';
import 'package:mrx_profile/Widget/drawer.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

ClassData classData = ClassData();

Padding SkillSection({
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 0),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child:
              HeadingTitle(title: "Skills that always make me more accurate"),
        ),
        Container(
          alignment: Alignment.center,
          height: context.screenHeight < 550
              ? 220
              : context.screenWidth >= 500
                  ? context.percentHeight * 40
                  : context.percentHeight * 32,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 210, 21, 243),
                  Color.fromARGB(255, 9, 137, 249)
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),

              // backgroundBlendMode: BlendMode.colorBurn,
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: classData.achievments.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => AchivementItem(
                  context: context,
                  headText: classData.achievments[index]['title'],
                  descriptionText: classData.achievments[index]['desc'],
                  gradientPrimary: xcolorPink,
                  gradiantSecondry: xcolorRed),
            ),
          ),
        ),
      ],
    ),
  );
}
