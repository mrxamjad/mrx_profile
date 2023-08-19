// Code for profile section

// ignore: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/Widget/button.dart';
import 'package:mrx_profile/Widget/style.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/ResumeEdit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:velocity_x/velocity_x.dart';

var profileImage = "";

Stack ProfileSection(BuildContext context) {
  String _name = "", _desc = "", bannerImage = "";
  return Stack(children: [
    // CustomDrawer(context),
    SizedBox(
      width: context.screenWidth,
      height: context.screenHeight < 550
          ? 110
          : context.screenSize.width < 600
              ? context.percentWidth * 30
              : context.percentWidth * 20,
      child: Lottie.network(
          fit: BoxFit.cover,
          'https://assets10.lottiefiles.com/packages/lf20_CR23KK4W5R.json'),
    ),
    // Container(
    //   margin: const EdgeInsets.only(left: 20),
    //   child: Image.asset(
    //     "assets/images/background.png",
    //     height: context.screenHeight < 550 ? 165 : context.percentHeight * 30,
    //     width: context.percentWidth * 100,
    //   ),
    // ),

    Align(
        alignment: Alignment.centerLeft,
        child: FutureBuilder<Map<String, dynamic>?>(
            future: FirestoreService.readProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var profile = snapshot.data;
                print("DATA IS: ${profile}");
                _name = profile!['name'];
                //   _address = profile['adress'];
                _desc = profile['description'];
                //   _email = profile['email'];
                //   _facebook = profile['facebook'];
                //   _founder = profile['founder'];
                //   _github = profile['github'];
                //   _insta = profile['instagram'];
                //   _mobile = profile['mobile'];
                //   _position = profile['position'];
                //   _youTube = profile['youtube'];
                bannerImage = profile['banner_image'];
                profileImage = profile['profile_image'];
              }
              if (snapshot.hasError) {
                print("We got some error on this project");
              }
              return Container(
                width: context.percentWidth * 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    top: 50, left: 10, right: 10, bottom: 10),
                margin: const EdgeInsets.only(top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        _name,
                        style: xTextStyle(bold: true, fontSize: 22),
                      ),
                    ),
                    Text(
                      _desc,
                      textAlign: TextAlign.center,
                      style: xTextStyle(bold: true, fontSize: 12),
                    ),
                    SizedBox(
                        width: 150,
                        child: InkWell(
                          onTap: () async {
                            print("button click");
                            await createSkills(title: "1", desc: "asdd");
                            print("button clicked");
                          },
                          child: InkWell(
                            child: xDesigButton(
                                buttonName: "Download CV",
                                icon: Icons.download),
                            onTap: () async {
                              print("Hello");
                              debugPrint(link + ": $link");
                              if (!link.isEmpty) {
                                // setState(() {
                                //   showProgress = true;
                                // });

                                String url = link;
                                String filename = url.split('/').last;

                                final dir =
                                    await getApplicationDocumentsDirectory();
                                String path = dir.path + "/" + filename;

                                await dio.download(url, path,
                                    onReceiveProgress: (count, total) {
                                  // setState(() {
                                  //   var _progress = count / total;
                                  // });
                                }, deleteOnError: true).then((value) => context
                                    .showToast(msg: "Downloaded: $path"));
                                // setState(() {
                                //   showProgress = false;
                                // });
                              } else {
                                context.showToast(msg: "Wrong Image Link");
                              }
                            },
                          ),
                        )),
                  ],
                ),
              );
            })),
    Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            left: 80,
            right: context.screenHeight > 550 ? context.screenWidth * .08 : 0),
        child: ClipRect(
          child: Container(
            padding: EdgeInsets.only(
              top: context.screenWidth < 500 ? 65 : 20,
              left: 20,
              right: 20,
            ),
            child: CircleAvatar(
              radius: context.percentWidth * 15,
              backgroundColor: xcolorPink,
              child: Container(
                margin: EdgeInsets.all(3),
                child: CircleAvatar(
                  radius: context.percentWidth * 25 - 3,
                  backgroundImage: NetworkImage(
                    profileImage,
                  ),
                ),
              ),
            ),
          ),

          //     Image.network(
          //   profileImage,
          //   height: context.screenHeight < 550
          //       ? 220
          //       : context.screenSize.width < 1000
          //           ? context.percentHeight * 40
          //           : context.percentWidth * 20,
          // ),
        ),
      ),
    )
  ]);
}

Future createSkills({required String title, required String desc}) async {
  final dataRef = FirebaseFirestore.instance.collection("test").doc();
  final json = {'title': title, 'desc': desc};

  await dataRef.set(json);
  print("Create data base executed");
}
