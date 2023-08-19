import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/Widget/CertificateView.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

class CertificateEdit extends StatefulWidget {
  const CertificateEdit({super.key});

  @override
  State<CertificateEdit> createState() => _CertificateEditState();
}

class _CertificateEditState extends State<CertificateEdit> {
  @override
  Future _uploadCertificate(String filename, var file, String updateField,
      String title, String index) async {
    UploadTask uploadTask;
    final ref =
        FirebaseStorage.instance.ref().child(filename).child("/" + file.name);
    uploadTask = ref.putFile(File(file.path));
    await uploadTask.whenComplete(() => {});
    String imageURL = await ref.getDownloadURL();
    debugPrint("This the image url: $imageURL");

    final docUser = FirebaseFirestore.instance.collection("certificate").doc();
    await docUser
        .update({"image_url": imageURL, "title": title, "index": index});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: xcolorGreenAccent,
        backgroundColor: xcolorPink,
        child: Icon(
          Icons.upload,
          size: 35,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  XFile? image;
                  return AlertDialog(
                    title: Text("Upload Certificate"),
                    content: Container(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(hintText: "Title"),
                          ),
                          Stack(
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    image = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    setState(() {});
                                    VxToast.show(context,
                                        msg: "Se;ected Image: ${image!.name}");
                                  },
                                  child: Text("Select Certificate")),
                            ],
                          ),
                          image == null
                              ? Container(
                                  height: 200,
                                  width: 200,
                                  color: Colors.red,
                                )
                              : Image.file(
                                  File(image!.path),
                                  height: 200,
                                  width: 200,
                                )
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Upload"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text("Cancel"))
                    ],
                  );
                });
              });
        },
      ),
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
        ListView.builder(
            itemCount: classData.certificateList.length,
            itemBuilder: (context, index) => Stack(
                  alignment: Alignment.center,
                  children: [
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
                      child: Container(
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
                            Card(
                                elevation: 10,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60)),
                                child: Container(
                                    // height: context.screenHeight < 550
                                    //     ? 180
                                    //     : context.screenWidth >= 500
                                    //         ? 350
                                    //         : 300,
                                    // width: context.screenWidth >= 500
                                    //     ? context.percentWidth * 70
                                    //     : context.percentWidth * 95,
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 20,
                                        bottom: 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: xcolorGreenAccent, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(60)),
                                    child: Image.asset(
                                      classData.certificateList[index]
                                          ['certificate'],
                                      fit: BoxFit.cover,
                                      height: 190,
                                      width: 350,
                                      scale: 9.0,
                                    ))),
                            Container(
                              height: 35,
                              margin: const EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: xcolorGreenAccent, width: 1),
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
                    ),
                    const Positioned(
                        top: 0,
                        right: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        )),
                  ],
                ))
      ]),
    );
  }
}
