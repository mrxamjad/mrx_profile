import 'dart:math';

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

int getPercent(String level) {
  if (level == "Beginner") {
    return 25;
  } else if (level == "Medium") {
    return 50;
  } else if (level == "Advance") {
    return 75;
  } else {
    return 100;
  }
}

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImage(context),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23)
                        // border: Border.all(width: 1, color: Colors.red[400]!)
                        ),
                    child: HeadingTitle(title: "Skills")),
                SizedBox(

                  height: 200,
                  child: StreamBuilder(
                    stream: FirestoreService.getRegularSkillData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var skillData = snapshot.data!;
                        return ListView.builder(
                          itemCount: skillData.length,
                          itemBuilder: (context, index) => skillProgress(
                              context: context,
                              skillName: skillData[index]['skill'],
                              perscent: getPercent(skillData[index]['level']),
                              width: width * 0.8),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
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
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.amberAccent,width: 2)
                ),
                child: CommanButton(
                  icon: Icon(
                    Icons.download,
                    color: xcoloryellow,
                  ),
                  name: "Download CV",
                ),
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
       Padding(
         padding: const EdgeInsets.all(5.0),
         child: CircleAvatar(
           radius: 10,
          backgroundColor:Colors.white ,
          child: Icon(
            size: 15,
            Icons.star,
            color: Colors.primaries[
            Random().nextInt(Colors.primaries.length)],
          ),
      ),
       ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(3),
          // width: context.percentHeight * 20,
          child: Text(
            text,
            maxLines: 2,
            softWrap: true,
            style: const TextStyle(
              color: Colors.white,
            ),
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
          String _name = "", _position = "", _bannerImage = "", _founder = "", _email="", _address="";
          if (snapshot.hasData) {
            var profile = snapshot.data;
            print("DATA IS: ${profile}");
            _name = profile!['name'];
              _address = profile['adress'];
            // _desc = profile['description'];
              _email = profile['email'];
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: context.screenWidth > 600 ?context.percentWidth * 20:context.percentWidth * 60,
                    padding: EdgeInsets.only(
                      top: context.screenWidth < 600 ? 65 : 40,
                      left: 20,
                      right: 20,
                      bottom: 20
                    ),
                    child: CircleAvatar(
                      radius: context.percentWidth * 25,
                      backgroundColor: xcolorPink,
                      child: Container(
                        margin: EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: context.percentWidth * 25 - 3,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("--------: Founder :--------",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      Text("$_founder",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("----------: Email :----------",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          )),
                      Text("$_email",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Container(

                    margin: const EdgeInsets.all(5),
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white, width: 2)),
                    child: Column(children: [
                      Container(
                        
                        
                        child: Text("Adress",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(border: Border.all(color: xcolorPink ,width: 2), borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                      ),
                      Expanded(child: Text("$_address" ,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),))

                    ]),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        width: 150,
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
                                "Admin Control",
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
