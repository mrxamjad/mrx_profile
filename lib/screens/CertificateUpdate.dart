
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/Widget/customAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Widget/CertificateView.dart';
import '../constants/xcolor.dart';

class UpdateCertificate extends StatefulWidget {
  final String url, title;
  final int index;
  UpdateCertificate(
      {Key? key, required this.url, required this.title, required this.index})
      : super(key: key);

  @override
  State<UpdateCertificate> createState() => _UpdateCertificateState();
}

class _UpdateCertificateState extends State<UpdateCertificate> {
  @override
  File? imageFile;
  bool uploadImage = false, titleEdit = false;
  FocusNode _titleNode = new FocusNode();
  TextEditingController _titleController = TextEditingController();

  void dispose() {
    // TODO: implement dispose
    _titleController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("URL: "+widget.url);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar("Certificate Update"),
      body: Stack(
        children: [
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
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
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
                    child: Stack(
                      children: [
                        Container(
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
                                  child: SingleChildScrollView(
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
                                              color: xcolorGreenAccent,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                      child: !uploadImage
                                          ? Image.network(
                                              widget.url,
                                              fit: BoxFit.cover,
                                              height: 190,
                                              width: 350,
                                              scale: 9.0,
                                            )
                                          : Container(
                                              child: Image.file(
                                              imageFile!,
                                              fit: BoxFit.cover,
                                              height: 190,
                                              width: 350,
                                            )),
                                    ),
                                  )),
                              SizedBox(
                                      // height: 50,
                                      // width: 200,
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: TextFormField(
                                          controller: _titleController,
                                          cursorColor: Colors.blue,
                                          // Customize cursor color
                                          maxLength: 40,
                                          showCursor: true,
                                          // onChanged: (value) {
                                          //   _titleController.text=value;
                                          // },
                                          decoration: InputDecoration(
                                            labelText: "Title",
                                            labelStyle: TextStyle( color: xcolorPinkDisc, fontSize: 16),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(width: 1,color:xcolorGreenAccent ),

                                                // Border.all(
                                                //     color: xcolorGreenAccent, width: 1),
                                                borderRadius:
                                                BorderRadius.circular(60)
                                              //
                                            ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 1,color:xcolorGreenAccent ),

                                                  // Border.all(
                                                  //     color: xcolorGreenAccent, width: 1),
                                                  borderRadius:
                                                  BorderRadius.circular(60)
                                                //
                                              )

                                              ,

                                          ),


                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                overflow: TextOverflow.fade,
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontStyle:
                                                    FontStyle.italic),
                                          ), // Customize text style

                                          focusNode: _titleNode,
                                        ),
                                      ),
                                    // ),
                                  ),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 0,
                            right: 20,
                            child: InkWell(
                              onTap: () async {
                                PickedFile? pickedFile =
                                    await ImagePicker().getImage(
                                  source: ImageSource.gallery,
                                  maxWidth: 1800,
                                  maxHeight: 1800,
                                );
                                if (pickedFile != null) {
                                  setState(() {
                                    imageFile = File(pickedFile.path);
                                    titleEdit = true;
                                  });
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: xcolorPink,
                                child: const Icon(
                                  Icons.upload,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(xcolorPink)),
                      onPressed: () async {
                        setState(() {
                          titleEdit = false;
                        });
                        final SharedPreferences sp=await SharedPreferences.getInstance();
                        bool admin=sp.getBool("admin")??false;

                        if(admin) {
                          if (imageFile == null) {
                            setState(() {
                              uploadImage = false;
                            });
                            final docUser = FirebaseFirestore.instance
                                .collection("certificate")
                                .doc(widget.index.toString());
                            await docUser.update({
                              "title": _titleController.text,
                            });
                            print("Data Upadted to firebase database");

                            context.showToast(msg: "Certificate data updated");
                          } else {
                            UploadTask uploadTask;
                            final ref = FirebaseStorage.instance
                                .ref()
                                .child("certificate")
                                .child("/" + widget.index.toString());
                            uploadTask = ref.putFile(File(imageFile!.path));
                            await uploadTask.whenComplete(() => {});
                            String imageURL = await ref.getDownloadURL();
                            debugPrint("This the image url: $imageURL");

                            final docUser = FirebaseFirestore.instance
                                .collection("certificate")
                                .doc(widget.index.toString());

                            await docUser.update({
                              "url": imageURL,
                              "title": _titleController.text,
                              "index": widget.index
                            });



                            context.showToast(msg: "Certificate data updated");

                          }
                        }
                        else{
                          context.showToast(msg: "Sorry, you are in Guest mode!", bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                        }
                      },
                      child: Text("Update"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
