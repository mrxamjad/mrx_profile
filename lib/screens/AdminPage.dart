import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/Widget/customAppBar.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/CertificateEdit.dart';
import 'package:mrx_profile/screens/CodingSkillEdit.dart';
import 'package:mrx_profile/screens/ProfileEdit.dart';
import 'package:mrx_profile/screens/ResponsiveLayout.dart';
import 'package:mrx_profile/screens/ResumeEdit.dart';
import 'package:mrx_profile/screens/SpotlightEdit.dart';
import 'package:mrx_profile/screens/SkillEdit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../BackendService/SharePref.dart';
import 'CommentEdit.dart';
import 'AcheivmentEdit.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool admin=false;
  var data;
  double width=0;
  bool desktop=false;




  TextEditingController? _nameController, _addressCotroller, _mobileController;


  void checkAdmin() async {
    final SharedPreferences sp= await SharedPreferences.getInstance();
    admin= sp.getBool('admin')??false;
    print("Admin Page: Check Admin:$admin");
  }

  @override
  void initState() {
    // TODO: implement initState


    print("Admin Page: Check Admin2:$admin");
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
     width=MediaQuery.of(context).size.width;
    if(width>600){
      desktop=true;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          context.nextPage(ResponsiveLayout());
          return false;

        },
        child: Scaffold(

          extendBodyBehindAppBar: true,
          appBar: customAppBar("Admin Control"),
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
              Align(
                alignment: Alignment.center,
                child: Container(

                    margin: const EdgeInsets.only(top: 100, left: 10, right: 10),
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                        // color: Colors.white70,
                        borderRadius: BorderRadius.circular(50)),
                    child: GridView.count(

                      crossAxisCount: context.screenWidth>600?4:3,
                      children: [
                        InkWell(
                          onTap: (() {
                            context.nextPage(const SkillPage());
                          }),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: SizedBox(
                                  height: 100 ,
                                  width: 100 ,
                                  child: Card(
                                    color: xcolorPink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icon/star-min.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Text(
                                          "Spots",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            context.nextPage(const ProfileEditPage());
                          }),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Card(
                                    color: xcolorPink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icon/profile.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        const Text(
                                          "Profile",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            context.nextPage(const ResumeEdit());
                          }),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Card(
                                    color: xcolorPink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icon/cv-min.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Text(
                                          "Resume",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            context.nextPage(const CertificateEdit());
                          }),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Card(
                                    color: xcolorPink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icon/certificate-min.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Text(
                                          "Certificate",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            context.nextPage(const OtherCertificationEdit());
                          }),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Card(
                                    color: xcolorPink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icon/other-certificate-min.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        const Text(
                                          "Achievment",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            context.nextPage(const CodingSkillEdit());
                          }),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Card(
                                    color: xcolorPink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icon/coding-skill-min.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        const Text(
                                          "Coding",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            context.nextPage(const SkillEdit());
                          }),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Card(
                                    color: xcolorPink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icon/skill-min.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Text(
                                          "Skills",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            context.nextPage(const CommentEdit());
                          }),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Card(
                                    color: xcolorPink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    elevation: 10,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/icon/comment-min.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Text(
                                          "Comment",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              // Positioned(
              //   top: 60,
              //   right: 40,
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: Container(
              //       padding: const EdgeInsets.all(5),
              //       decoration: BoxDecoration(
              //         color: Colors.red,
              //         borderRadius: BorderRadius.circular(30)
              //
              //       ),
              //
              //       child: Text(admin?"Admin":"Guest", style: TextStyle( color: Colors.white),),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell AdminAction(
      {String name = "Button",
      Color color = Colors.amber,
      void Function()? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Card(
          color: color,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 100,
            width: 200,
            // color: color,
            child: Center(
              child: Text(name),
            ),
          )),
    );
  }
}
