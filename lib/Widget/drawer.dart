import 'package:flutter/material.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/Widget/HeadingTitle.dart';
import 'package:mrx_profile/Widget/skillProgress.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/Login.dart';
import 'package:mrx_profile/screens/ResumeEdit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import 'CommanButton.dart';

// Drawer for app bar to show profile
Container CustomDrawer({required BuildContext context, double width = 250}) {
  return Container(
    width: width,

    // height: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [xcolorPink, xcolorSky],
            end: Alignment.topLeft,
            begin: Alignment.bottomRight)),
    child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileImage(context),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23)
                        // border: Border.all(width: 1, color: Colors.red[400]!)
                        ),
                    child: HeadingTitle(title: "Skills")),
                Column(
                  children: [
                    skillProgress(
                        context: context,
                        skillName: "Dart",
                        perscent: 100,
                        width: width * 0.8),
                    skillProgress(
                        context: context,
                        skillName: "Java",
                        perscent: 75,
                        width: width * 0.8),
                    skillProgress(
                        context: context,
                        skillName: "MongoDB",
                        perscent: 50,
                        width: width * 0.8),
                    skillProgress(
                        context: context,
                        skillName: "Web Development",
                        perscent: 25,
                        width: width * 0.8),
                  ],
                )
              ],
            ),
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              HeadingTitle(title: "Other Certification"),
              Container(
                alignment: Alignment.topLeft,
                height: 200,
                child: StreamBuilder(
                  stream: FirestoreService.readOtherCertification(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final codingData = snapshot.data;
                      // codingData!.sort();
                      return ListView.builder(
                        itemCount: codingData!.length,
                        itemBuilder: (context, index) {
                          return otherCertification(
                              context, codingData[index]['title']);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularPercentIndicator(radius: 20);
                    }
                  },
                ),
              )
            ]),
            InkWell(
              child: CommanButton(
                icon: Icon(Icons.download),
                name: "Download CV",
              ),
              onTap: () async {
                debugPrint(link + ": $link");

                if (!link.isEmpty) {
                  // setState(() {
                  //   showProgress = true;
                  // });

                  String url = link;
                  String filename = url.split('/').last;

                  final dir = await getApplicationDocumentsDirectory();
                  String path = dir.path + "/" + filename;

                  await dio.download(url, path,
                      onReceiveProgress: (count, total) {
                    // setState(() {
                    //   _progress = count / total;
                    // });
                  }, deleteOnError: true).then(
                      (value) => context.showToast(msg: "Downloaded: $path"));
                  // setState(() {
                  //   showProgress = false;
                  // });
                } else {
                  context.showToast(msg: "Wrong Image Link");
                }
              },
            ),
            // Expanded(child: SizedBox())
          ]),
    ),
  );
}

Row otherCertification(BuildContext context, String text) {
  return Row(
    children: [
      Container(
        child: const Icon(
          Icons.check_rounded,
          color: Colors.yellow,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(3),
        width: context.percentHeight * 20,
        child: Text(
          text,
          maxLines: 2,
          softWrap: true,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}

// design for profile
Container ProfileImage(BuildContext context) {
  return Container(
    child: FutureBuilder<Map<String, dynamic>?>(
        future: FirestoreService.readProfile(),
        builder: (context, snapshot) {
          String _name = "", _position = "", _bannerImage = "", _founder = "";
          if (snapshot.hasData) {
            var profile = snapshot.data;
            print("DATA IS: ${profile}");
            _name = profile!['name'];
            //   _address = profile['adress'];
            // _desc = profile['description'];
            //   _email = profile['email'];
            //   _facebook = profile['facebook'];
            _founder = profile['founder'];
            //   _github = profile['github'];
            //   _insta = profile['instagram'];
            //   _mobile = profile['mobile'];
            _position = profile['position'];
            //   _youTube = profile['youtube'];
            _bannerImage = profile['banner_image'];
            // _profileImage = profile['profile_image'];
          }
          if (snapshot.hasError) {
            print("We got some error on this project");
          }
          return Container(
              color: Colors.black12,

              // height: context.screenHeight * .30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                          radius: context.percentWidth * 15 - 3,
                          backgroundImage: NetworkImage(
                            _bannerImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: context.percentWidth * 100,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: xcolorGreenAccent, width: 2)),
                    child: Text(
                      "$_name",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(_position,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      )),
                  Text("Founder: \n $_founder",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      )),
                  Align(
                    alignment: Alignment.centerRight,
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
                            context.nextPage(LoginScreen());
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
              ));
        }),
  );
}
