// Skill Sections
import 'package:flutter/material.dart';
import 'package:mrx_profile/Controller/ClassData.dart';
import 'package:mrx_profile/Widget/AchivementItem.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

ClassData classData = ClassData();

Padding SkillSection({
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 0),
    child: Container(
      height: context.percentHeight * 32,
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
  );
}
