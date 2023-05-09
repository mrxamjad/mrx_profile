// Hire me Section

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/Widget/CertificateView.dart';
import 'package:mrx_profile/Widget/HeadingTitle.dart';
import 'package:mrx_profile/Widget/drawer.dart';
import 'package:mrx_profile/Widget/style.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

Container HireMeSection(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: HeadingTitle(title: "Our Projects"),
        ),
        Container(
            height: context.screenHeight < 550
                ? 230
                : context.screenWidth >= 500
                    ? 400
                    : 300,
            child: CertificateView(context))
      ],
    ),
  );
}
