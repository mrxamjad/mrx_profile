// Skill Sections

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mrx_profile/Controller/ClassData.dart';
import 'package:mrx_profile/ModelClass/SkillsData.dart';
import 'package:mrx_profile/Widget/AchivementItem.dart';
import 'package:mrx_profile/Widget/HeadingTitle.dart';
import 'package:mrx_profile/Widget/drawer.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

ClassData classData = ClassData();
Stream<List<SkillsData>> readSkills() => FirebaseFirestore.instance
    .collection("skills")
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((e) => SkillsData.fromJson(e.data())).toList());

Stream<List<SkillsData>> fetchUserData() =>
    FirebaseFirestore.instance.collection("skills").snapshots().map((event) =>
        event.docs.map((e) => SkillsData.fromJson(e.data())).toList());

Stream<List<Map<String, dynamic>>> getTestData() => FirebaseFirestore.instance
    .collection("skills")
    .snapshots()
    .map(((event) => event.docs.map((e) => e.data()).toList()));

// Read a single data  from the database

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
              child: StreamBuilder(
                stream: readSkills(),
                builder: (context, snapshot) {
                  // print(snapshot);
                  print(snapshot.data);
                  if (snapshot.hasError) {
                    Text("Error");
                  }
                  if (snapshot.hasData) {
                    final skills = snapshot.data!;

                    return ListView.builder(
                      itemCount: skills.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => AchivementItem(
                          context: context,
                          headText: skills[index].title,
                          descriptionText: skills[index].desc,
                          gradientPrimary: xcolorPink,
                          gradiantSecondry: xcolorRed),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )),
        ),
      ],
    ),
  );
}
