
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/AdminPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../BackendService/SharePref.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController(), passController=TextEditingController();
  String email="",pass="";

  loginWithEmail() {
    VxToast.show(context, msg: "Clicked");
    context.nextPage(AdminPage());
    // User? currentUser;
    // FirebaseAuth.instance
    //     .signInWithEmailAndPassword(
    //         email: emailController!.text, password: passController!.text)
    //     .then((fAuth) {
    //   currentUser = fAuth.user;
    //   VxToast.show(context, msg: currentUser.toString());
    //   if (currentUser != null) {
    //     VxToast.show(context, msg: currentUser!.email.toString());

    //     context.nextPage(AdminPage());
    //   }
    //   // SnackBar(content: Text("Login Successfully"));
    // }).catchError((error) {
    //   print(error.toString());
    //   VxToast.show(context, msg: error.toString());
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Stack(children: [
        // if(  SharePref.checkAdmin())




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
          child: Container(
            margin: EdgeInsets.only(top: 200),
            height: 300,
            width: 400,
            child: Center(
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    style: TextStyle( color: Colors.white),
                    cursorColor: xcolorGreenAccent,
                    onChanged: (value) {
                      email=emailController.text;

                    },

                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: xcolorPinkDisc
                        ,
                      ),
                      label: Text("Email"),
                      hintText: "Email",
                      prefixIconColor: xcolorPinkDisc,
                      labelStyle: TextStyle(color: xcolorPinkDisc),
                      hintStyle: TextStyle(color: xcolorPinkDisc),

                     enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: xcolorPinkDisc, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: xcolorGreenAccent, width: 1)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    cursorColor: xcolorGreenAccent,
                    style: TextStyle( color: Colors.white),
                    obscureText: true,
                    obscuringCharacter:"*",
                    keyboardType: TextInputType.visiblePassword,
                    controller: passController,
                    onChanged: (value) {
                      pass=passController.text;

                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.password_outlined,
                            color: xcolorPinkDisc),
                        label: Text("Password"),
                        hintText: "Password",
                        prefixIconColor: xcolorGreenAccent,
                        labelStyle: TextStyle(color: xcolorPinkDisc),
                        hintStyle: TextStyle(color: xcolorPinkDisc),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: xcolorPinkDisc, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: xcolorGreenAccent, width: 1))),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await SharePref.setAdmin(true);

                        // loginWithEmail();
                      try {

                        if(email.isNotEmptyAndNotNull & pass.isNotEmptyAndNotNull) {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: email,
                              password: pass
                          );
                          context.showToast(msg: "Login Successfull", bgColor: Colors.green, position: VxToastPosition.center );
                          email=pass="";
                          emailController.clear();
                          passController.clear();

                          context.nextPage(AdminPage());
                        }else{
                          context.showToast(msg: "User or Password is empty!", bgColor: Colors.red, position: VxToastPosition.center );
                        }

                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {

                          context.showToast(msg: "No user found for that email.", bgColor: Colors.red, position: VxToastPosition.center );
                        } else if (e.code == 'wrong-password') {


                          context.showToast(msg: "Wrong password provided for that user.", bgColor: Colors.red, position: VxToastPosition.center );

                        }else{

                          context.showToast(msg: "Wrong username or password.", bgColor: Colors.red, position: VxToastPosition.top, textColor: Colors.white );

                        }
                      }


                      },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: xcolorPinkDisc,
                              )),
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(
                                "Login",
                                style: TextStyle(
                                    color: xcolorPinkDisc,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.login_rounded,
                                color: xcolorPinkDisc,
                              )
                            ],
                          ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: xcolorPinkDisc,
                            )),
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () async {
                            await SharePref.setAdmin(false);

                            context.nextPage(AdminPage());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(
                                "Guest User",
                                style: TextStyle(
                                    color: xcolorPinkDisc,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.person,
                                color: xcolorPinkDisc,
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
