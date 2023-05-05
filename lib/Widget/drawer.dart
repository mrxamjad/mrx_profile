import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mrx_profile/Widget/skillProgress.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

// Drawer for app bar to show profile
Container CustomDrawer({required BuildContext context, double width = 250}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [xcolorPink, xcolorSky],
            end: Alignment.topLeft,
            begin: Alignment.bottomRight)),
    child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      ProfileImage(context),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
                // border: Border.all(width: 1, color: Colors.red[400]!)
                ),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Skills",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
          Column(
            children: [
              skillProgress(
                  context: context,
                  skillName: "Dart",
                  perscent: 100,
                  width: width * 0.8),
              skillProgress(
                  context: context,
                  skillName: "Java",
                  perscent: 75,
                  width: width * 0.8),
              skillProgress(
                  context: context,
                  skillName: "MongoDB",
                  perscent: 50,
                  width: width * 0.8),
              skillProgress(
                  context: context,
                  skillName: "Web Development",
                  perscent: 25,
                  width: width * 0.8),
            ],
          )
        ],
      ),
      Column(children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Other Certification",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        otherCertification(context, "Flutter certification by google"),
        otherCertification(context, "Java by NPTEL IIT Bombay"),
        otherCertification(context, "JAVA by spoken tutorial"),
        otherCertification(context, "Java Development by Spring board"),
        otherCertification(context, "Full stack web development by infosys"),
      ]),
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 2,
                color: xcolorGreenAccent,
              )),
          margin: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Downlod CV",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.download,
                  color: xcoloryellow,
                )
              ],
            ),
          ))
    ]),
  );
}

Row otherCertification(BuildContext context, String text) {
  return Row(
    children: [
      Container(
        child: const Icon(
          Icons.check_rounded,
          color: Colors.yellow,
        ),
      ),
      Container(
        padding: EdgeInsets.all(3),
        width: context.percentHeight * 20,
        child: Text(
          text,
          maxLines: 2,
          softWrap: true,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}

// design for profile
Container ProfileImage(BuildContext context) {
  return Container(
      color: Colors.black12,

      // height: context.screenHeight * .30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 65,
              left: 20,
              right: 20,
            ),
            child: CircleAvatar(
              radius: context.percentWidth * 15,
              backgroundImage: const NetworkImage(
                'https://picsum.photos/seed/picsum/100',
              ),
            ),
          ),
          Container(
            width: context.percentWidth * 100,
            child: const Text(
              "Amjad Ali",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Flutter Developer",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                color: Colors.white,
              )),
          const Text("Founder: \nMrX Developer",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.normal,
                color: Colors.white,
              )),
          const SizedBox(
            height: 20,
          )
        ],
      ));
}
