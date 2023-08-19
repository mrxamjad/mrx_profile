import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/CertificateEdit.dart';
import 'package:mrx_profile/screens/CodingSkillEdit.dart';
import 'package:mrx_profile/screens/ProfileEdit.dart';
import 'package:mrx_profile/screens/ResumeEdit.dart';
import 'package:mrx_profile/screens/Skills.dart';
import 'package:velocity_x/velocity_x.dart';

import 'OtherCertiicationEdit.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var data;
  TextEditingController? _nameController, _addressCotroller, _mobileController;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            Container(
                margin: const EdgeInsets.only(top: 100, left: 10, right: 10),
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(50)),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    InkWell(
                      onTap: () {
                        context.nextPage(const SkillPage());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: xcolorGreenAccent, width: 3)),
                        child: const Center(
                          child: Text(
                            "Skills",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.nextPage(const ProfileEditPage());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: xcolorGreenAccent, width: 3)),
                        child: const Center(
                          child: Text(
                            "Profile",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.nextPage(const CodingSkillEdit());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: xcolorGreenAccent, width: 3)),
                        child: const Center(
                          child: Text(
                            "Coding Skill",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.nextPage(const OtherCertificationEdit());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: xcolorGreenAccent, width: 3)),
                        child: const Center(
                          child: Text(
                            "Other Certification",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.nextPage(const ResumeEdit());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: xcolorGreenAccent, width: 3)),
                        child: const Center(
                          child: Text(
                            "Resume",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.nextPage(const CertificateEdit());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: xcolorGreenAccent, width: 3)),
                        child: const Center(
                          child: Text(
                            "Certificate",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
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
