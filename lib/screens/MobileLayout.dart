import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/Widget/CertificateView.dart';
import 'package:mrx_profile/Widget/CodingSkills.dart';
import 'package:mrx_profile/Widget/HireMe.dart';
import 'package:mrx_profile/Widget/ProfileSection.dart';
import 'package:mrx_profile/Widget/Comments.dart';
import 'package:mrx_profile/Widget/SpotlightSection.dart';
import 'package:mrx_profile/Widget/socialSection.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Widget/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  late PDFViewController pdfViewController;
  FixedExtentScrollController _scrollController=FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: CustomDrawer(context: context),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 186, 224, 231),
          elevation: 0,
        ),
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
              height: context.screenHeight.toDouble(),
              width: context.screenWidth.toDouble(),
              child: Lottie.network(
                  fit: BoxFit.cover,
                  "https://assets10.lottiefiles.com/packages/lf20_ugIuhrl2vw.json"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProfileSection(context),
                    SkillSection(
                      context: context,
                    ),
                    CodingSection(context),

                    CertificationSection(context: context),
                    TestomonialRevies(
                      // context: context, scrollController: _scrollController,
                    ),
                    // HireMeSection(context),

                    SocialNewtwork(context),

                    // Profile Section
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
