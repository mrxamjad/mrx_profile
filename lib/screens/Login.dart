import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/AdminPage.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailController, passController;
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
                    cursorColor: xcolorGreenAccent,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: xcolorGreenAccent,
                      ),
                      label: Text("Email"),
                      hintText: "Email",
                      prefixIconColor: xcolorGreenAccent,
                      labelStyle: TextStyle(color: xcolorGreenAccent),
                      hintStyle: TextStyle(color: xcolorGreenAccent),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: xcolorGreenAccent, width: 3)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: xcolorPink, width: 3)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    cursorColor: xcolorGreenAccent,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.password_outlined,
                            color: xcolorGreenAccent),
                        label: Text("Password"),
                        hintText: "Password",
                        prefixIconColor: xcolorGreenAccent,
                        labelStyle: TextStyle(color: xcolorGreenAccent),
                        hintStyle: TextStyle(color: xcolorGreenAccent),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: xcolorGreenAccent, width: 3)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: xcolorPink, width: 3))),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2,
                              color: xcolorGreenAccent,
                            )),
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            loginWithEmail();
                            // context.nextPage(AdminPage());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.login_rounded,
                                color: xcoloryellow,
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
