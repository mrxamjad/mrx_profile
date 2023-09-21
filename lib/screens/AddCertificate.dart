
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class AddCertificate extends StatefulWidget {
  const AddCertificate({super.key});

  @override
  State<AddCertificate> createState() => _AddCertificateState();
}

class _AddCertificateState extends State<AddCertificate> {
  @override
  File? imageFile;
  bool uploadImage = false, titleEdit = false;
  FocusNode _titleNode = new FocusNode();
  FocusNode _indexNode = new FocusNode();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _indexController = TextEditingController();

  void dispose() {
    // TODO: implement dispose
    _titleController.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                            : 500,
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
                              ? 300
                              : context.screenWidth >= 500
                                  ? 450
                                  : 400,
                          width: context.screenWidth >= 500
                              ? context.percentWidth * 70
                              : context.percentWidth * 95,
                          // color: Colors.amber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 250,
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
                                          ? const SizedBox(
                                              width: 180,
                                              height: 100,
                                              child: Center(
                                                child: Text(
                                                    "No Certificate Selected"),
                                              ))
                                          :
     //                                  Image.memory (
     // imageFile!.readAsBytes();,
     //                                    fit: BoxFit.cover,
     //                                  ),
                                      // Image(
                                      //   image: FileImage(
                                      //       File(imageFile!.path),
                                      //       scale: 4
                                      //   ),
                                      // )
                                      Image.file(
                                              imageFile!,
                                              fit: BoxFit.cover,
                                              height: 180,
                                              width: 350,
                                            ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Enter title of certificate"),
                                    Container(
                                      height: 35,
                                      margin: const EdgeInsets.only(
                                        top: 5,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: xcolorGreenAccent,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                      child: SizedBox(
                                        // height: 50,
                                        width: 200,
                                        child: EditableText(
                                          controller: _titleController,
                                          cursorColor: Colors.blue,
                                          // Customize cursor color

                                          backgroundCursorColor: Colors
                                              .grey, // Customize cursor color when not focused
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                overflow: TextOverflow.fade,
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic),
                                          ), // Customize text style
                                          cursorWidth:
                                              2.0, // Customize cursor width
                                          maxLines:
                                              null, // Allow multiple lines of input
                                          onChanged: (text) {
                                            // Do something with the updated text
                                            print('Updated text: $text');
                                          },
                                          onSubmitted: (text) {
                                            // Handle when the user submits the text input (e.g., pressing Enter)
                                            print('Submitted text: $text');
                                          },
                                          focusNode: _titleNode,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Text("Enter title of Serial No"),
                                    Container(
                                      height: 35,
                                      margin: const EdgeInsets.only(
                                        top: 5,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: xcolorGreenAccent,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(60)),
                                      child: SizedBox(
                                        // height: 50,
                                        width: 100,
                                        child: EditableText(
                                          keyboardType: TextInputType.number,
                                          controller: _indexController,
                                          cursorColor: Colors.blue,
                                          // Customize cursor color

                                          backgroundCursorColor: Colors
                                              .grey, // Customize cursor color when not focused
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                overflow: TextOverflow.fade,
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic),
                                          ), // Customize text style
                                          cursorWidth:
                                              2.0, // Customize cursor width
                                          maxLines:
                                              null, // Allow multiple lines of input
                                          onChanged: (text) {
                                            // Do something with the updated text
                                            print('Updated text: $text');
                                          },
                                          onSubmitted: (text) {
                                            // Handle when the user submits the text input (e.g., pressing Enter)
                                            print('Submitted text: $text');
                                          },
                                          focusNode: _indexNode,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                print(pickedFile!.path);

                                if (pickedFile.path != null) {
                                  setState(() {
                                    imageFile = File(pickedFile.path);
                                    uploadImage = true;
                                  });
                                }
                              },
                              child:  CircleAvatar(
                                backgroundColor: xcolorPink,
                                child: Icon(
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
                      backgroundColor: MaterialStatePropertyAll<Color?>(xcolorPink)
                    ),
                      onPressed: () async {
                        setState(() {
                          // titleEdit = false;
                        });
                        if (imageFile == null ||
                            _indexController.text.isEmpty) {
                          context.showToast(
                              msg:
                                  "Please select a certificate and Give Index");
                        } else {
                          final SharedPreferences sp= await SharedPreferences.getInstance();
                          bool admin=sp.getBool('admin')??false;
                          if(admin){
                          UploadTask uploadTask;
                          final ref = FirebaseStorage.instance
                              .ref()
                              .child("certificate")
                              .child("/" + _indexController.text.toString());
                          uploadTask = ref.putFile(File(imageFile!.path));
                          await uploadTask.whenComplete(() => {});
                          String imageURL = await ref.getDownloadURL();
                          debugPrint("This the image url: $imageURL");
                          print(_indexController.text);

                          int index =
                              int.parse(_indexController.text.toString());

                          final docUser = FirebaseFirestore.instance
                              .collection("certificate")
                              .doc(index.toString());
                          await docUser.set({
                            "url": imageURL,
                            "title": _titleController.text,
                            "index": index,
                          });
                          //
                          print("Data Upadted to firebase database");

                          // ignore: use_build_context_synchronously
                          context.showToast(
                              msg: "Certificate Successfully added",
                              position: VxToastPosition.top);
                          imageFile = null;
                          // ignore: use_build_context_synchronously
                          context.pop();}
                          else{
                            context.showToast(msg: "Sorry, You are in Guest Mode!", bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                          }
                        }
                      },
                      child: const Text("Add Certificate"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
