import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/Widget/customAppBar.dart';
import 'package:mrx_profile/Widget/style.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateComment extends StatefulWidget {
  const CreateComment({super.key});

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  @override
  bool nameEdit = false, postEdit = false, commentEdit = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode potisionNOde = FocusNode();
  FocusNode commentNode = FocusNode();

  // @override
  // void initState() {
  //   super.initState();

  //   nameController.text = widget.name;
  //   positionController.text = widget.post;
  //   commentController.text = widget.comment;
  // }

  @override
  void dispose() {
    // TODO: implement dispose

    nameController.clear();
    positionController.clear();
    commentController.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double desktopHeight = context.percentHeight * 45;
    double mobileHeight = context.percentHeight * 35;
    return Scaffold(
      primary:true,

      extendBodyBehindAppBar: true,
      appBar: customAppBar("Your FeedBack"),

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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    height: context.screenHeight < 550.0
                        ? 220.0
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
                            gradient: LinearGradient(
                                colors: [xcolorGreen, xcolorSky])),
                        padding: const EdgeInsets.all(20),
                        width: 400,
                        height: context.screenHeight < 550
                            ? 200
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
                                   CircleAvatar(
                                    radius: 30,
                                    child: Text("N", style: TextStyle( fontSize: 34, fontWeight: FontWeight.bold),),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 12),
                                      // padding: const EdgeInsets.only( top: 30,),

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [

                                          SizedBox(
                                            height: 40,
                                            child: TextFormField(
                                              controller: nameController,
                                              cursorColor: Colors.blue,
                                              // maxLines: 1,
                                              // maxLength: 30,
                                              decoration: InputDecoration(


                                                hintText: "eg. Mr.David, A.R Rahman",
                                                  labelStyle:TextStyle( fontWeight: FontWeight.normal, fontSize: 14, color: xcolorPink),
                                                  labelText: "Name",hintStyle: TextStyle( fontWeight: FontWeight.normal, fontSize: 14, color: Colors.grey),

                                                
                                                enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: xcolorPink, width: 2), borderRadius: BorderRadius.circular(15)),
                                                  focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: xcolorPink, width: 2), borderRadius: BorderRadius.circular(15))


                                              ),
                                              // Customize cursor color

                                             // Customize cursor color when not focused
                                              style: xTextStyle(
                                                  color: Colors.black,
                                                  bold:
                                                      true), // Customize text style

                                              focusNode: nameNode,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            height:40 ,
                                            child: TextFormField(
                                              controller:
                                                  positionController,
                                              cursorColor:
                                                  Colors.blue,
                                              // maxLength: 30,

                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "eg. Business, Developer",
                                                labelText: "Position",
                                                  labelStyle:TextStyle( fontWeight: FontWeight.normal, fontSize: 14, color: xcolorPink),
                                                  hintStyle: TextStyle( fontWeight: FontWeight.normal, fontSize: 14, color: Colors.grey),
                                                  enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: xcolorPink, width: 2),borderRadius: BorderRadius.circular(15)),
                                                  focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: xcolorPink, width: 2),borderRadius: BorderRadius.circular(15))



                                              ),

                                              style: xTextStyle(
                                                  color: Colors.black,
                                                  bold:
                                                      false), // Customize text style

                                              focusNode: potisionNOde,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
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
                                        child:

                                        TextFormField(
                                                controller: commentController,
                                                cursorColor: Colors.blue,
                                                maxLength: 200,
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Write your feedback here....",
                                                    // labelText: "Write your feedback here...."

                                                ),
                                                maxLines: 4,
                                                // Customize cursor color

                                                // backgroundCursorColor: Colors
                                                //     .grey, // Customize cursor color when not focused
                                                style: xTextStyle(
                                                    fontSize: 14,
                                                    italic: true,
                                                    color: xcolorTeal),

                                                focusNode: commentNode,
                                              )

                                      ),
                                    ),
                                  ),
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
                    if (!nameController.text.isEmptyOrNull &&
                        !positionController.text.isEmptyOrNull &&
                        !commentController.text.isEmptyOrNull) {
                      print("Add BUtton get Clicked");
                      var name = nameController.text;
                      var position=positionController.text;
                      var comment=commentController.text;

                      if(name.length>15)
                       name = nameController.text.substring(0,15);
                      if(position.length>15)
                       position=positionController.text.substring(0,15);
                      if(comment.length>200)
                     comment=commentController.text.substring(0,200);
                      await FirebaseFirestore.instance
                          .collection("comments")
                          .doc("${name}")
                          .set({
                            "name": name,
                            "position": position,
                            "comment": comment,
                            "date": DateTime.now().toString()
                          })
                          .then((value) =>
                              context.showToast(msg: "Successfully updated"))
                          .onError((error, stackTrace) =>
                              context.showToast(msg: "Got an Error!!"));
                      context.pop();

                      print("Add BUtton get Clicked1");
                    } else {
                      print("Name: ${nameController.text}");
                      print("Position: ${positionController.text}");
                      print("Comment: ${commentController.text}");

                      context.showToast(
                          msg: "Please check!, Some field is empty..",
                          position: VxToastPosition.top);
                    }
                  },
                  child: Text("Post"))
            ],
          )),
        ],
      ),
    );
  }
}
