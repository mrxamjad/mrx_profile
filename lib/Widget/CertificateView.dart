



import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/Controller/ClassData.dart';
import 'package:mrx_profile/Widget/HeadingTitle.dart';
import 'package:mrx_profile/Widget/drawer.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:ui' as ui;

ClassData classData = ClassData();

// Certificate  Section
Padding CertificationSection({
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: HeadingTitle(
            title:
                "Achievement and Certification that prove consistancy and dedication",
          ),
        ),
        Container(
          height: context.screenHeight < 550
              ? 240
              : context.screenWidth >= 500
                  ? 400
                  : 300,
          width: context.screenWidth * .98,
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
          child: CertificateView(context),
        ),
      ],
    ),
  );
}

// Certificate View

Padding CertificateView(BuildContext context) {
  var certificateData;
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: StreamBuilder(
      stream: FirestoreService.getCertificateData(),
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          certificateData = snapshot.data;

          return VxSwiper.builder(
            viewportFraction: 1.0,
            autoPlay: true,
            aspectRatio: 1 / 1,
            reverse: true,
            autoPlayCurve: Curves.easeIn,
            autoPlayInterval: 2.seconds,
            itemCount: certificateData!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {

              // Code for Image display
              // ui.platformViewRegistry.registerViewFactory(
              //   certificateData[index]['url'],
              //       (int _) => ImageElement()..src = certificateData[index]['url'],
              // );
              return Container(
                height: context.screenHeight < 550
                    ? 150
                    : context.screenWidth >= 500
                        ? 350
                        : 300,
                width: context.screenWidth >= 500
                    ? context.percentWidth * 70
                    : context.percentWidth * 95,
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Card(
                          elevation: 10,
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)),
                          child: Container(
                              height: context.screenHeight < 550
                                  ? 180
                                  : context.screenWidth >= 500
                                      ? 350
                                      : 300,
                              width: context.screenWidth >= 500
                                  ? context.percentWidth * 70
                                  : context.percentWidth * 95,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: xcolorGreenAccent, width: 2),
                                  borderRadius: BorderRadius.circular(60)),
                              child:
                              // HtmlElementView(
                              //   viewType: certificateData[index]["url"],
                              // )
                              // Image(
                              //   image: FirebaseImageProvider(
                              //       FirebaseUrl("gs://bucket_f233/logo.jpg")
                              //   ),
                              // ),r
                          // )),
                              Image.network(
                                // classData.certificateList[index]
                                //     ['certificate'],
                                certificateData[index]["url"],
                                fit: BoxFit.cover,
                                height: 190,
                                width: 350,
                                scale: 9.0,
                              )

                              // Image.network(
                              //   certificateData[index]["url"],
                              //   fit: BoxFit.cover,
                              //   height: 190,
                              //   width: 350,
                              //   scale: 9.0,
                              //   errorBuilder: (context, error, stackTrace) => Text("No Image"),
                              //   loadingBuilder: (context, child, loadingProgress) => Center(child: CircularProgressIndicator(color: xcolorGreenAccent,))
                              //   ,)
                ),
                      ),
                    ),
                    Container(
                      height: 35,
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: xcolorGreenAccent, width: 1),
                          borderRadius: BorderRadius.circular(60)),
                      child: Text(
                        certificateData[index]["title"],
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
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    ),
  );
}
