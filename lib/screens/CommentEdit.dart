import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/Widget/Comments.dart';
import 'package:mrx_profile/Widget/customAppBar.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/CommentUpdate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class CommentEdit extends StatefulWidget {
  const CommentEdit({super.key});

  @override
  State<CommentEdit> createState() => _CommentEditState();
}

class _CommentEditState extends State<CommentEdit> {
  var commentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar("Comments"),
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
          child: StreamBuilder(
            stream: FirestoreService.getCommentData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                commentData = snapshot.data;
                return ListView.builder(
                  itemCount: commentData.length,
                  itemBuilder: (context, index) =>
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: context.screenWidth>700?context.screenWidth*0.2:0),
                        child: Stack(
                    children: [
                        reviewCard(
                            context,
                            commentData[index]['name'],
                            commentData[index]['position'],
                            commentData[index]['comment']),
                      Positioned(
                          top: 0,
                          right: context.screenWidth>700?context.screenWidth*0.1:20,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: ()  {
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
                                                      const EdgeInsets.all(
                                                          10),
                                                      margin:
                                                      const EdgeInsets.only(
                                                          top: 60),
                                                      height: 150,
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'Delete Comment',
                                                            style: TextStyle(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          const Text(
                                                              "Are you sure want to delete?"),
                                                          const Expanded(
                                                              child:
                                                              SizedBox()),
                                                          Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      5.0),
                                                                  child:
                                                                  ElevatedButton(
                                                                    style: const ButtonStyle(
                                                                        backgroundColor:
                                                                        MaterialStatePropertyAll<Color?>(Colors.green)),
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            'Cancel'),
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      5.0),
                                                                  child: ElevatedButton(
                                                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color?>(Colors.red)),
                                                                      onPressed: () async {
                                                                        SharedPreferences
                                                                        sp =
                                                                        await SharedPreferences.getInstance();
                                                                        bool
                                                                        admin =
                                                                            sp.getBool('admin') ??
                                                                                false;
                                                                        if (admin) {
                                                                          final docUser = FirebaseFirestore
                                                                              .instance
                                                                              .collection("comments")
                                                                              .doc(commentData[index]['name'].toString())
                                                                              .delete();

                                                                          Navigator.pop(
                                                                              context);
                                                                        } else {
                                                                          context.showToast(
                                                                              msg: "Sorry, you are in Guest Mode!",
                                                                              bgColor: Colors.red,
                                                                              textColor: Colors.white,
                                                                              position: VxToastPosition.top);
                                                                        }
                                                                      },
                                                                      child: const Text(
                                                                        "Delete",
                                                                        style: TextStyle(
                                                                            color:
                                                                            Colors.white),
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
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                            Colors.red,
                                                            radius: 50,
                                                            child: Icon(
                                                                Icons.delete,
                                                                size: 70,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ))
                                                  ])),
                                        );
                                      });
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 15,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3,),

                            ],
                          )),

                    ],
                  ),
                      ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        )
      ]),
    );
  }
}
