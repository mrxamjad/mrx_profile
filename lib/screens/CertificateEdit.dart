import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/Widget/customAppBar.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/AddCertificate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import 'CertificateUpdate.dart';

class CertificateEdit extends StatefulWidget {
  const CertificateEdit({super.key});

  @override
  State<CertificateEdit> createState() => _CertificateEditState();
}

class _CertificateEditState extends State<CertificateEdit> {
  @override
  var certificateData;
  bool admin = false;
  void checkAdmin() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    admin = sp.getBool('admin') ?? false;
    print(admin);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAdmin();
  }

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
      extendBodyBehindAppBar: true,
      appBar: customAppBar("Certificate"),
      floatingActionButton: FloatingActionButton(
        foregroundColor: xcolorGreenAccent,
        backgroundColor: xcolorPink,
        child: const Icon(
          Icons.add_a_photo_outlined,
          size: 35,
        ),
        onPressed: () {
          context.nextPage(const AddCertificate());
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
              stream: FirestoreService.getCertificateData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  certificateData = snapshot.data;
                  // print("Data from Firebase" + certificateData);
                  return ListView.builder(
                      itemCount: certificateData!.length,
                      itemBuilder: (context, index) => Container(
                        margin:EdgeInsets.symmetric(horizontal: context.screenWidth>700?context.screenWidth*0.2:0),

                        child: Stack(
                              clipBehavior: Clip.none,
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
                                                borderRadius:
                                                    BorderRadius.circular(60)),
                                            child: Container(

                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 20,
                                                    bottom: 20),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: xcolorGreenAccent,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(60)),
                                                child: Image.network(
                                                  // classData.certificateList[index]
                                                  //     ['certificate'],
                                                  certificateData[index]["url"],
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
                                                  color: xcolorGreenAccent,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                          child: Text(
                                            certificateData[index]['title'],
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
                                Positioned(
                                    top: -12,
                                    right: context.screenWidth>700?context.screenWidth*0.1:20,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    margin: EdgeInsets.symmetric(horizontal: context.screenWidth>600?context.screenWidth*0.2:0),
                                                    child: Dialog(
                                                        elevation: 5,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    30)),
                                                        child: Stack(
                                                            alignment:
                                                                Alignment.topCenter,
                                                            clipBehavior: Clip.none,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 60),
                                                                height: 150,
                                                                child: Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Delete Skill',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold),
                                                                    ),
                                                                    const SizedBox(
                                                                        height: 10),
                                                                    const Text(
                                                                        "Are you sure want to delete?"),
                                                                    Expanded(
                                                                        child:
                                                                            SizedBox()),
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(
                                                                                    5.0),
                                                                            child:
                                                                                ElevatedButton(
                                                                              style: const ButtonStyle(
                                                                                  backgroundColor:
                                                                                      MaterialStatePropertyAll<Color?>(Colors.green)),
                                                                              onPressed: () => Navigator.pop(
                                                                                  context,
                                                                                  'Cancel'),
                                                                              child: const Text(
                                                                                  'Cancel'),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(
                                                                                    5.0),
                                                                            child: ElevatedButton(
                                                                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color?>(Colors.red)),
                                                                                onPressed: () async {
                                                                                  if (admin) {
                                                                                    FirebaseStorage.instance.ref("certificate").child(certificateData[index]['index'].toString()).delete();
                                                                                   FirebaseFirestore.instance.collection("certificate").doc(certificateData[index]['index'].toString()).delete();

                                                                                    Navigator.pop(context);
                                                                                  } else {
                                                                                    context.showToast(msg: "Sorry, you are in Guest Mode!", bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                                                                                  }
                                                                                },
                                                                                child: const Text(
                                                                                  "Delete",
                                                                                  style:
                                                                                      TextStyle(color: Colors.white),
                                                                                )),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const Positioned(
                                                                  top: -50,
                                                                  child: CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors.white,
                                                                    radius: 55,
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors.red,
                                                                      radius: 50,
                                                                      child: Icon(
                                                                          Icons
                                                                              .delete,
                                                                          size: 70,
                                                                          color: Colors
                                                                              .white),
                                                                    ),
                                                                  ))
                                                            ])),
                                                  );
                                                });
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.red,
                                              child: Icon(
                                                Icons.delete,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context.nextPage(UpdateCertificate(
                                              url: certificateData[index]['url'],
                                              title: certificateData[index]
                                                  ['title'],
                                              index: certificateData[index]
                                                  ['index'],
                                            ));


                                          },
                                          child: const CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                      ));
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
      ]),
    );
  }
}
