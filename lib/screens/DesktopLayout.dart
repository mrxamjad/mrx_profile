import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/Widget/CertificateView.dart';
import 'package:mrx_profile/Widget/CodingSkills.dart';
import 'package:mrx_profile/Widget/HireMe.dart';
import 'package:mrx_profile/Widget/ProfileSection.dart';
import 'package:mrx_profile/Widget/Comments.dart';
import 'package:mrx_profile/Widget/SpotlightSection.dart';
import 'package:mrx_profile/Widget/drawer.dart';
import 'package:mrx_profile/Widget/socialSection.dart';
import 'package:velocity_x/velocity_x.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override

  // FixedExtentScrollController _scrollController=FixedExtentScrollController();


  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if(_scrollController.hasClients) {
    //     double minScrollExtent1 = _scrollController.position.minScrollExtent;
    //     double maxScrollExtent1 = _scrollController.position.maxScrollExtent;
    //
    //     animateToMaxMin(
    //         maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 25,
    //         _scrollController);
    //   }
    // });

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final element=_scrollController.selectedItem+1;
    //   Timer.periodic(Duration(seconds: 3), (timer) {
    //
    //     _scrollController.animateToItem(element, duration: Duration(seconds: 1), curve: Curves.easeInOut);
    //   });
    //
    // });

  }

  //Animate to
  // animateToMaxMin(double max,double min, double direction,int second, ScrollController scrollController){
  //   scrollController.animateTo(direction, duration: Duration(seconds: second), curve: Curves.linear).then((value) {
  //     direction=direction==max?min:max;
  //     animateToMaxMin(max, min, direction, second, scrollController);
  //   });
  // }
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CustomDrawer(context: context, width: screenWidth * .25),
                          // Expanded(
                          //   child: TestomonialRevies(
                          //     context: context,
                          //   ),
                          // )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileSection(context),
                                // SkillSection(
                                //   context: context,
                                // ),
                                // CodingSection(context),
                                //
                                // CertificationSection(context: context),

                                // Profile Section
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     // Expanded(child: HireMeSection(context)),
                  //     Expanded(
                  //       child: TestomonialRevies(
                  //         // context: context,scrollController: _scrollController
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SocialNewtwork(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
