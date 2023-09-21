import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:mrx_profile/Widget/style.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateComment extends StatefulWidget {
  final name, post, comment;
  UpdateComment(
      {super.key,
      required this.name,
      required this.post,
      required this.comment});

  @override
  State<UpdateComment> createState() => _UpdateCommentState();
}

class _UpdateCommentState extends State<UpdateComment> {
  @override
  int counter =0;
  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode potisionNOde = FocusNode();
  FocusNode commentNode = FocusNode();

  @override
  void initState() {
    super.initState();
    counter=widget.comment.length;

    nameController.text = widget.name;
    positionController.text = widget.post;
    commentController.text = widget.comment;
  }

  @override
  void dispose() {
    // TODO: implement dispose

    nameController.clear();
    positionController.clear();
    commentController.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double desktopHeight = context.percentHeight * 35;
    double mobileHeight = context.percentHeight * 30;

    return Stack(
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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  height: context.screenHeight < 550.0
                      ? 190.0
                      : context.screenWidth < 500.0
                          ? mobileHeight - 10
                          : desktopHeight - 10,
                  child: Card(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                              bottomRight: Radius.circular(40)),
                          gradient:
                              LinearGradient(colors: [xcolorGreen, xcolorSky])),
                      padding: const EdgeInsets.all(20),
                      width: 400,
                      height: context.screenHeight < 550
                          ? 160
                          : context.screenWidth < 500
                              ? mobileHeight - 15
                              : desktopHeight - 15,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                    'assets/images/profile.png',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  child: Column(
                                    children: [
                                      // Text(
                                      //   name,
                                      //   style:
                                      //       xTextStyle(color: Colors.black, bold: true),
                                      // ),
                                      SizedBox(
                                        width: 200,
                                        child: EditableText(
                                          controller: nameController,
                                          cursorColor: Colors.blue,
                                          // Customize cursor color

                                          backgroundCursorColor: Colors
                                              .grey, // Customize cursor color when not focused
                                          style: xTextStyle(
                                              color: Colors.black,
                                              bold:
                                                  true), // Customize text style

                                          focusNode: nameNode,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: EditableText(
                                          controller: positionController,
                                          cursorColor: Colors.blue,
                                          // Customize cursor color

                                          backgroundCursorColor: Colors
                                              .grey, // Customize cursor color when not focused
                                          style: xTextStyle(
                                              color: Colors.black,
                                              bold:
                                                  false), // Customize text style

                                          focusNode: potisionNOde,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topRight,
                                children: [
                                  Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    shadowColor: Colors.black,
                                    borderOnForeground: true,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                        child: EditableText(
                                          controller: commentController,
                                          cursorColor: Colors.blue,

                                          maxLines: 5,
                                          onChanged: (value){
                                            setState(() {
                                              counter=value.length;
                                              if(counter>=210){
                                                commentController.text=commentController.text.substring(0,210);
                                                context.showToast(msg: "Max 210 char is allowed!", position: VxToastPosition.top);
                                              }


                                            });
                                          },


                                          // Customize cursor color

                                          backgroundCursorColor: Colors
                                              .grey, // Customize cursor color when not focused
                                          style: xTextStyle(
                                              fontSize: 14,
                                              italic: true,
                                              color: xcolorTeal),

                                          focusNode: commentNode,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                      top: -5,

                                      child: Container(
                                        height: 10,
                                        width: 40,
                                        child: Text("${counter.toString()}/210", style: TextStyle( fontSize: 8, color: Colors.white),),))
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(xcolorPink)),
                onPressed: () async {
                  if(!nameController.text.isEmptyOrNull){

                    final SharedPreferences sp= await SharedPreferences.getInstance();
                    bool admin= sp.getBool('admin')??false;
                    if(admin) {
                      var comment=commentController.text.substring(0,210);
                      FirebaseFirestore.instance
                          .collection("comments")
                          .doc("${widget.name}")
                          .update({

                        "position": positionController.text,
                        "comment": comment
                      })
                          .then((value) =>
                          context.showToast(msg: "Successfully updated"))
                          .onError((error, stackTrace) =>
                          context.showToast(msg: "Got an Error!!"));
                      context.pop();
                    }
                    else{
                      context.showToast(msg: "Sorry, You are a Guest", bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                    }
                  }

                  else{
                    context.showToast(msg: "Please write your feedback", position: VxToastPosition.top);
                  }
                },
                child: Text("Update"))
          ],
        )),
      ],
    );
  }
}
