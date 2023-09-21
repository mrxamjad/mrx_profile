// Code for profile section

// ignore: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/Widget/button.dart';
import 'package:mrx_profile/Widget/style.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/ResumeEdit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../BackendService/UrlToFile.dart';
import '../screens/ResumePdfView.dart';

var profileImage = "";

Stack ProfileSection(BuildContext context) {
  String _name = "", _desc = "", bannerImage = "";
  return Stack(
    clipBehavior: Clip.none,
      children: [
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


    Align(
        alignment: Alignment.centerLeft,
        child: FutureBuilder<Map<String, dynamic>?>(
            future: FirestoreService.readProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var profile = snapshot.data;
                print("DATA IS: ${profile}");
                _name = profile!['name'];
                //   _address = profile['adress'];
                _desc = profile['description'];

                bannerImage = profile['banner_image'];
                profileImage = profile['profile_image'];
              }
              if (snapshot.hasError) {
                print("We got some error on this project");
              }
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      width: context.percentWidth * 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          top: 50, left: 10, right: 10, bottom: 10),
                      margin: const EdgeInsets.only(top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(
                            _desc,
                            textAlign: TextAlign.center,
                            style: xTextStyle(bold: true, fontSize: 12),
                          ),
                          SizedBox(
                              width: 150,
                              child: InkWell(
                                child: xDesigButton(
                                    buttonName: "Download CV",
                                    icon: Icons.download,),

                                onTap: () async {

                                 var resumeData = await getResumeData();
                                  link = resumeData[0]['link'];
                                  debugPrint("PDF Link: $link]");


                                  debugPrint(link + ": $link");
                                  if (!link.isEmpty) {


                                    String url = link;
                                    String filename = url.split('/').last;

                                    final dir =
                                        await getApplicationDocumentsDirectory();
                                    String path = dir.path + "/" + filename;

                                    await dio.download(url, path,
                                        onReceiveProgress: (count, total) {

                                    }, deleteOnError: true).then((value) => context
                                        .showToast(msg: "Downloaded: $path"));

                                  } else {
                                    context.showToast(msg: "Resume not found for download");
                                  }
                                },
                              )),SizedBox(
                              width: 150,
                              child: InkWell(

                                child: xDesigButton(
                                    buttonName: "View CV",
                                    icon: Icons.view_agenda),
                                onTap: () async {
                                  debugPrint("PDF Link: $link");
                                  List data=await getResumeData();
                                  String pdfLink = data[0]['link'];

                                  // bool loadPDF=true;
                                  if (!pdfLink.isEmpty) {

                                    PDFDocument? pdf = await UrlToFile.UrlToPdf(pdfLink);


                                    context.nextPage(ResumePdfView(
                                      pdfDocument: pdf,
                                    ));



                                  } else {
                                    context.showToast(msg: "PDF link is not found");
                                  }
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CircleAvatar(
                            radius:MediaQuery.of(context).size.width<=550?
                            MediaQuery.of(context).size.width/4.5:MediaQuery.of(context).size.width/8,
                            backgroundColor: xcolorPink,
                            child: Container(
                              margin: EdgeInsets.only(top: 3,bottom: 3,left: 3,right: 3),
                              child: CircleAvatar(
                                radius:MediaQuery.of(context).size.width<=550?
                                ( MediaQuery.of(context).size.width/4.5)-3:(MediaQuery.of(context).size.width/8)-3,
                                onBackgroundImageError: (exception, stackTrace) =>
                                    CircularProgressIndicator(
                                      color: xcolorPink,
                                    ),
                                backgroundImage: NetworkImage(
                                  profileImage,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin:const EdgeInsets.only(top: 10),
                          child: Text(
                            _name,
                            style: xTextStyle(bold: true, fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            })),
    // Align(
    //   alignment: Alignment.centerRight,
    //   ,
    // )
  ]);
}


