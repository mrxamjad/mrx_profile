import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrx_profile/Controller/ClassData.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

ClassData classData = ClassData();

// Certificate  Section
Padding CertificationSection({
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Container(
      height: context.percentHeight * 42,
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
              topLeft: Radius.circular(80),
              topRight: Radius.circular(80),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: CertificateView(),
    ),
  );
}

// Certificate View

Padding CertificateView() {
  return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: VxSwiper.builder(
        viewportFraction: 1.0,
        autoPlay: true,
        height: 300,
        reverse: true,
        autoPlayCurve: Curves.easeIn,
        autoPlayInterval: 2.seconds,
        itemCount: classData.certificateList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                      elevation: 10,
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: xcolorGreenAccent, width: 2),
                              borderRadius: BorderRadius.circular(60)),
                          child: Image.asset(
                            classData.certificateList[index]['certificate'],
                            fit: BoxFit.fitHeight,
                          ))),
                  Container(
                    height: 30,
                    margin: const EdgeInsets.only(top: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: xcolorGreenAccent, width: 1),
                        borderRadius: BorderRadius.circular(60)),
                    child: Text(
                      classData.certificateList[index]['title'],
                      maxLines: 1,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 12,
                            color: Colors.black,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ));
}
