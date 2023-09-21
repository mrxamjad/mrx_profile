
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:mrx_profile/BackendService/FilePickerServices.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/BackendService/UrlToFile.dart';
import 'package:mrx_profile/Widget/CommanButton.dart';
import 'package:mrx_profile/Widget/customAppBar.dart';
import 'package:mrx_profile/screens/ResumePdfView.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/xcolor.dart';

class ResumeEdit extends StatefulWidget {
  const ResumeEdit({super.key});

  @override
  State<ResumeEdit> createState() => _ResumeEditState();
}

String link = '';
bool loadPDF=false;
double? _progress;
bool showProgress = false;
Dio dio = Dio();
List<Map<String, dynamic>> resumeData = [];

class _ResumeEditState extends State<ResumeEdit> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      asyncMethod();
    });
  }

  asyncMethod() async {
    resumeData = await getResumeData();
    link = resumeData[0]['link'];
    debugPrint("PDF Link: $link]");
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar("Resume"),

      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 200, 140, 210),
                Color.fromARGB(255, 173, 206, 234)
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
        SizedBox(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Lottie.network(
              fit: BoxFit.cover,
              "https://assets10.lottiefiles.com/packages/lf20_ugIuhrl2vw.json"),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: context.screenWidth>700?context.screenWidth*0.2:0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 8, right: 8),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50)),
                    ),
                    elevation: 5,
                    child: Container(

                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      alignment: Alignment.center,

                      // margin: const EdgeInsets.all(20),
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [xcolorGrad1, xcolorGrad2],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50)),
                        // border: Border.all(color: xcolorGreenAccent, width: 3)
                      ),
                      // color: Colors.white,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 5,
                              color: xcolorPink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: CommanButton(
                                name: "Donwload CV",
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                func: (() async {
                                  debugPrint(link + ": $link");

                                  if (!link.isEmpty) {
                                    setState(() {
                                      showProgress = true;
                                    });

                                    String url = link;
                                    String filename = url.split('/').last;

                                    final dir =
                                        await getApplicationDocumentsDirectory();
                                    String path = dir.path + "/" + filename;

                                    await dio.download(url, path,
                                        onReceiveProgress: (count, total) {
                                      setState(() {
                                        _progress = count / total;
                                      });
                                    }, deleteOnError: true).then((value) =>
                                        context.showToast(msg: "Downloaded: $path"));
                                    setState(() {
                                      showProgress = false;
                                    });
                                  } else {
                                    context.showToast(msg: "Wrong Image Link");
                                  }
                                }),
                              ),
                            ),
                            showProgress
                                ? Container(
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    child: LinearProgressIndicator(
                                      backgroundColor: xcolorPink,
                                      valueColor:
                                          AlwaysStoppedAnimation(xcolorGreenAccent),
                                      color: xcolorPink,
                                      value: _progress,
                                      minHeight: 10,
                                    ),
                                  )
                                : SizedBox(),
                            Card(
                              elevation: 5,
                              color: xcolorPink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: CommanButton(
                                name: "Upload CV",
                                func: () {
                                  pdfChooserBottomSheet(context);
                                },
                                icon: const Icon(
                                  Icons.upload,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Card(
                              elevation: 5,
                              color: xcolorPink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: loadPDF?CircularProgressIndicator(color: Colors.white,):CommanButton(
                                name: "View CV",
                                icon: Icon(
                                  Icons.preview,
                                  color: Colors.white,
                                ),
                                func: () async {
                                  debugPrint("PDF Link: $link");
                                  bool loadPDF=true;
                                  if (!link.isEmpty) {

                                    PDFDocument? pdf = await UrlToFile.UrlToPdf(link);

                                    // ignore: use_build_context_synchronously



                                    setState(() {
                                      loadPDF=false;

                                    });
                                    // context.pop();
                                    context.nextPage(ResumePdfView(
                                      pdfDocument: pdf,
                                    ));



                                  } else {
                                    context.showToast(msg: "PDF link is not found");
                                  }
                                },
                              ),
                            ),

                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

// Method to show modal sheet
  Future<dynamic> pdfChooserBottomSheet(BuildContext context) {
    // String _selectedPdf = "";
    // File? file;
    // String downloadURL = "";
    // bool showProcess = false;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return PickPdfBottomSheet();
        });
  }
}

// Stateful class to pdf picker bottom sheet

class PickPdfBottomSheet extends StatefulWidget {
  const PickPdfBottomSheet({super.key});

  @override
  State<PickPdfBottomSheet> createState() => _PickPdfBottomSheetState();
}

class _PickPdfBottomSheetState extends State<PickPdfBottomSheet> {
  String _selectedPdf = "";
  File? file;
  String downloadURL = "";
  bool showProcess = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      height: 200,
      child: Container(
        margin:  EdgeInsets.symmetric(horizontal: context.screenWidth>600?context.screenWidth*0.2:0),
        decoration: const BoxDecoration(border: Border()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text("Selected PDF: $_selectedPdf"),
            ),
            InkWell(
              onTap: () async {
                file = await FilePickerServices.pickPdf(file, _selectedPdf);
                if (file != null) {
                  _selectedPdf = file!.path.split('/').last;
                  setState(() {});
                }
                // ignore: use_build_context_synchronously
                context.showToast(msg: "Picked Filename: $_selectedPdf");
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                height: 50,
                width: 250,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: xcolorGreenAccent, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_rounded,
                      color: Colors.pink,
                      size: 30,
                    ),
                    Text(
                      "Select PDF From File",
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final SharedPreferences sp= await SharedPreferences.getInstance();
                bool admin= sp.getBool('admin')??false;
                if(admin) {
                  if (file != null && !_selectedPdf.isEmpty) {
                    setState(() {
                      showProcess = true;
                    });
                    await FirestoreService.uploadPdfToFirestore(
                        _selectedPdf, file!, "resume", "resume", "1", "link");
                    // ignore: use_build_context_synchronously
                    context.showToast(msg: "PDF successfully uploaded");
                    context.pop();
                    setState(() {
                      showProcess = false;
                    });
                  } else {
                    context.showToast(
                        msg: "File or Selected File name is NULL");
                  }
                }
                else{
                  context.showToast(msg: "Sorry, you are in Guest Mode!",bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                }
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                height: 50,
                width: 250,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: xcolorGreenAccent, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.upload,
                      color: Colors.pink,
                      size: 30,
                    ),
                    Text(
                      "Upload CV",
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: showProcess
                  ? CircularProgressIndicator(
                      color: xcolorGreenAccent,
                    )
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
