// Code for profile section

// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/Widget/button.dart';
import 'package:mrx_profile/Widget/style.dart';
import 'package:velocity_x/velocity_x.dart';

Stack ProfileSection(BuildContext context) {
  return Stack(children: [
    // CustomDrawer(context),
    SizedBox(
      width: context.screenWidth,
      height: context.screenHeight < 550
          ? 110
          : context.screenSize.width < 600
              ? context.percentWidth * 30
              : context.percentWidth * 20,
      child: Lottie.network(
          fit: BoxFit.cover,
          'https://assets10.lottiefiles.com/packages/lf20_CR23KK4W5R.json'),
    ),
    // Container(
    //   margin: const EdgeInsets.only(left: 20),
    //   child: Image.asset(
    //     "assets/images/background.png",
    //     height: context.screenHeight < 550 ? 165 : context.percentHeight * 30,
    //     width: context.percentWidth * 100,
    //   ),
    // ),

    Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: context.percentWidth * 50,
        alignment: Alignment.center,
        padding:
            const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
        margin: const EdgeInsets.only(top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Amjad Ali",
                style: xTextStyle(bold: true, fontSize: 22),
              ),
            ),
            Text(
              "Hello I'm Amjad, A Flutter Developer and Application developer I have various skill like web development and Java devolopment",
              textAlign: TextAlign.center,
              style: xTextStyle(bold: true, fontSize: 12),
            ),
            SizedBox(
                width: 150,
                child: xDesigButton(
                    buttonName: "Download CV", icon: Icons.download)),
          ],
        ),
      ),
    ),
    Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            left: 80,
            right: context.screenHeight > 550 ? context.screenWidth * .08 : 0),
        child: ClipRect(
          child: Image.asset(
            "assets/images/profile.png",
            height: context.screenHeight < 550
                ? 220
                : context.screenSize.width < 1000
                    ? context.percentHeight * 40
                    : context.percentWidth * 20,
          ),
        ),
      ),
    )
  ]);
}
