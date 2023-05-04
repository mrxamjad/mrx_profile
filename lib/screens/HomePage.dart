import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:mrx_profile/Widget/button.dart';
import 'package:mrx_profile/Widget/skillProgress.dart';
import 'package:mrx_profile/Widget/style.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:velocity_x/velocity_x.dart';

import '../Widget/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  late PDFViewController pdfViewController;

// list of Achivement
  List<Map<String, dynamic>> achievments = [
    {
      "title": "10+ Project",
      "desc":
          "Done project in multiple thesis based and used multiple third prty library"
    },
    {
      "title": "20+ Skills",
      "desc":
          "Having Skills in multiple language and stack and handson varios technology"
    },
    {
      "title": "15+ Repos",
      "desc": "Multiple public repo for public and for helping them"
    },
    {
      "title": "1+ Exp",
      "desc":
          "Experiance in multi domain project and their Excellance UI and UX"
    },
    {
      "title": "3+ Months",
      "desc":
          "worked in Regami solutions with excellence engineers and shared the experiance with them"
    },
    {
      "title": "50+ Clints",
      "desc":
          "Worked with 50+ clints and delivered their project with great experiance"
    }
  ];

  List<Map<String, dynamic>> reviewsList = [
    {
      'name': "Amjad",
      'post': 'Engineer',
      'caption':
          "Hi I'm Amjad , I'm using their service and I found very intresting in it they delivered my project very timely"
    },
    {
      'name': "Md Saif",
      'post': 'Web Deweloper',
      'caption':
          "Hi I'm saif , I'm using their service and I found very intresting in it they delivered my project very timely"
    },
    {
      'name': "Zibran",
      'post': 'Electrical Engineer',
      'caption':
          "Hi I'm zibran , I'm using their service and I found very intresting in it they delivered my project very timely"
    },
    {
      'name': "Sahil",
      'post': 'Data Scientist',
      'caption':
          "Hi I'm Sahil, I'm using their service and I found very intresting in it they delivered my project very timely"
    },
    {
      'name': "Irshad",
      'post': 'Mobile App Developer',
      'caption':
          "Hi I'm Irshad , I'm using their service and I found very intresting in it they delivered my project very timely"
    },
    {
      'name': "Afroz Ansari",
      'post': 'Java Developer',
      'caption':
          "Hi I'm Afroz Ansari , I'm using their service and I found very intresting in it they delivered my project very timely"
    },
  ];

  List<Map<String, dynamic>> certificateList = [
    {
      "title": "Android Native Development certification by INFOSYS",
      "certificate":
          "assets/images/certificate/android_development_infosys.png",
    },
    {
      "title": "Core Java certification by INFOSYS",
      "certificate": "assets/images/certificate/core_java_infosys.png",
    },
    {
      "title": "CSS Intro Certification by Great Learning",
      "certificate":
          "assets/images/certificate/css_intro_certificate_greatleaning.png"
    },
    {
      "title": "CSS Intermediat Certification by Great Learning",
      "certificate":
          "assets/images/certificate/css_intermediat_certificate_greatleaning.png"
    },
    {
      "title": "CSS Properies Certification by Great Learning",
      "certificate":
          "assets/images/certificate/css_perpoties_certificate_greatleaning.png"
    },
    {
      "title": "Time Managment certification by Harverd University",
      "certificate": "assets/images/certificate/time_management_harvard.png"
    },
    {
      "title": "HTML HandsOn Certification by GreatLearning",
      "certificate": "assets/images/certificate/time_management_harvard.png"
    },
    {
      "title": "Cyber Security Certification by Govt India",
      "certificate": "assets/images/certificate/cyber_security.png"
    },
    {
      "title": "JavaScript intro Certification by GreatLearning",
      "certificate":
          "assets/images/certificate/javasript_intro_certificate_greatLearning.png"
    },
    {
      "title": "Solar Energy by Energy Swaraj",
      "certificate": "assets/images/certificate/energy_swaraj.png"
    },
    {
      "title": "OOPS intro Certification by GreatLearning",
      "certificate":
          "assets/images/certificate/oops_intro_certificate_greatlearnig.png"
    },
    {
      "title": "ISEA Certificate by Govt India",
      "certificate": "assets/images/certificate/isea_digital_certificate.png"
    },
    {
      "title": "OOPS  Certification by GreatLearning",
      "certificate": "assets/images/certificate/oops_greatlearning.png"
    },
    {
      "title": "Infosys Platform certification by INFOSYS",
      "certificate":
          "assets/images/certificate/overview_of_infosys_springboard.png"
    },
  ];

  //Redirect the user to user profile

  Future<void> goToWebPage(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: CustomDrawer(context),
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        // ),
        body: Stack(
          children: [
            Lottie.network(
                fit: BoxFit.cover,
                "https://assets10.lottiefiles.com/packages/lf20_ugIuhrl2vw.json"),
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
            Padding(
              padding: const EdgeInsets.only(top: 60),
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
                      context: context,
                    ),
                    Container(
                      width: 300,
                      child: Stack(
                        children: [
                          Lottie.network(
                              fit: BoxFit.cover,
                              'https://assets10.lottiefiles.com/packages/lf20_CR23KK4W5R.json'),
                          const Text(
                              "Hire Me for Java, web Development and also for flutter developer"),
                          Wrap(
                            children: [
                              VxSwiper.builder(
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Stack(
                                      children: [
                                        Container()
                                        // Lottie.network()
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SocialLinkWidget(
                                  icon: FontAwesomeIcons.github,
                                  onTap: () async {
                                    print("printed");
                                    await goToWebPage("https://flutter.dev");
                                    print("printed");
                                  },
                                ),
                                SocialLinkWidget(
                                  icon: FontAwesomeIcons.linkedinIn,
                                  onTap: () async {
                                    await goToWebPage("https://flutter.dev");
                                  },
                                ),
                                SocialLinkWidget(
                                  icon: FontAwesomeIcons.instagram,
                                  onTap: () async {
                                    await goToWebPage("https://flutter.dev");
                                  },
                                ),
                                SocialLinkWidget(
                                  icon: FontAwesomeIcons.facebook,
                                  onTap: () async {
                                    await goToWebPage("https://flutter.dev");
                                  },
                                ),
                                SocialLinkWidget(
                                  icon: FontAwesomeIcons.googlePlus,
                                  onTap: () async {
                                    await goToWebPage("https://flutter.dev");
                                  },
                                ),
                                SocialLinkWidget(
                                  icon: FontAwesomeIcons.telegram,
                                  onTap: () async {
                                    await goToWebPage("https://flutter.dev");
                                  },
                                ),
                                SocialLinkWidget(
                                  icon: FontAwesomeIcons.whatsapp,
                                  onTap: () async {
                                    await goToWebPage("https://flutter.dev");
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

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

  Card SocialLinkWidget({String? title, icon = Icons.abc, required onTap()}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
              // border: Border.all(color: xcolorGreenAccent, width: 2),
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              boxShadow: const []),
          child: Column(
            children: [
              IconButton(
                  onPressed: (() {}),
                  icon: FaIcon(
                    icon,
                    size: 35,
                  )),
              if (title != null) Text(title)
            ],
          ),
        ),
      ),
    );
  }

// Code for Coding Section
  Padding CodingSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
      child: Container(
          height: context.percentHeight * 26,
          width: context.percentWidth * 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: xcoloryellow, width: 3)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "Coding Skills",
                  style: xTextStyle(bold: true),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SkillProgressCircular(
                      percent: 100,
                      skillName: "Flutter",
                      color: xcoloryellow,
                    ),
                    SkillProgressCircular(
                        percent: 75,
                        skillName: "Dart",
                        color: xcolorGreenAccent),
                    SkillProgressCircular(
                      percent: 50,
                      skillName: "Java",
                      color: Colors.teal,
                    ),
                    SkillProgressCircular(
                        innerFontSize: 14,
                        percent: 25,
                        skillName: "Web Development",
                        color: Colors.red[400]!)
                  ],
                ),
              )
            ],
          )),
    );
  }

// Skill Sections
  Padding SkillSection({
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        height: context.percentHeight * 32,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 210, 21, 243),
                Color.fromARGB(255, 9, 137, 249)
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),

            // backgroundBlendMode: BlendMode.colorBurn,
            color: Colors.black12,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: achievments.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => AchivementItem(
                context: context,
                headText: achievments[index]['title'],
                descriptionText: achievments[index]['desc'],
                gradientPrimary: xcolorPink,
                gradiantSecondry: xcolorRed),
          ),
        ),
      ),
    );
  }

  // Skill Sections
  Padding TestomonialRevies({
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        height: context.percentHeight * 30,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 210, 21, 243),
                Color.fromARGB(255, 9, 137, 249)
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),

            // backgroundBlendMode: BlendMode.colorBurn,
            color: Colors.black12,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80), topRight: Radius.circular(20))),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: VxSwiper.builder(
              itemCount: reviewsList.length,
              autoPlay: true,
              autoPlayAnimationDuration: 2.seconds,
              itemBuilder: (context, index) => reviewCard(
                  context,
                  reviewsList[index]['name'],
                  reviewsList[index]['post'],
                  reviewsList[index]['caption']),
            )
            //  ListView.builder(
            //     itemCount: reviewsList.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) => reviewCard(
            //           context,
            //           reviewsList[index]['name'],
            //           reviewsList[index]['post'],
            //           reviewsList[index]['caption'],
            //         )),
            ),
      ),
    );
  }

  Padding reviewCard(
      BuildContext context, String name, String post, String caption) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          height: context.percentHeight * 27,
          child: Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  gradient: LinearGradient(colors: [xcolorGreen, xcolorSky])),
              padding: const EdgeInsets.all(20),
              width: context.percentWidth * 80,
              height: context.percentHeight * 20,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            'assets/images/profile.png',
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Column(
                            children: [
                              Text(
                                name,
                                style:
                                    xTextStyle(color: Colors.black, bold: true),
                              ),
                              Text(post)
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        shadowColor: Colors.black,
                        borderOnForeground: true,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              caption,
                              style: xTextStyle(
                                  fontSize: 14,
                                  italic: true,
                                  color: xcolorTeal),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  //Design for Each style and customizable

  SizedBox AchivementItem({
    required BuildContext context,
    double size = 130,
    double elevation = 10,
    required headText,
    required descriptionText,
    double headTextSize = 16,
    Color headTextColor = Colors.white,
    double descTextSize = 12,
    Color descTextColor = const Color.fromARGB(255, 63, 35, 177),
    Color gradientPrimary = Colors.tealAccent,
    Color gradiantSecondry = Colors.pinkAccent,
  }) {
    return SizedBox(
      width: size,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 0),
        child: Card(
          elevation: elevation,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          surfaceTintColor: Colors.amber,
          child: Container(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [gradientPrimary, gradiantSecondry],
                    begin: Alignment.bottomRight,
                    end: Alignment.topCenter)),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 12, right: 0),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 63, 35, 177),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30))),
                    child: Text(
                      headText,
                      style: xTextStyle(
                          bold: true,
                          color: Colors.white,
                          fontSize: headTextSize),
                    )),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Text(
                    descriptionText,
                    style: xTextStyle(
                        italic: true,
                        fontSize: descTextSize,
                        bold: true,
                        color: descTextColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Code for profile section

  // ignore: non_constant_identifier_names
  Stack ProfileSection(BuildContext context) {
    return Stack(children: [
      // CustomDrawer(context),
      Container(
        width: 300,
        child: Lottie.network(
            fit: BoxFit.cover,
            'https://assets10.lottiefiles.com/packages/lf20_CR23KK4W5R.json'),
      ),
      Container(
        margin: const EdgeInsets.only(left: 20),
        child: Image.asset(
          "assets/images/background.png",
          height: context.percentHeight * 30,
        ),
      ),

      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: context.percentWidth * 50,
          alignment: Alignment.center,
          padding:
              const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
          margin: const EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Amjad Ali",
                style: xTextStyle(bold: true, fontSize: 22),
              ),
              Text(
                "Hello I'm Amjad, A Flutter Developer and Application developer I have various skill like web development and Java devolopment",
                textAlign: TextAlign.center,
                style: xTextStyle(bold: true, fontSize: 12),
              ),
              SizedBox(
                  width: 150,
                  child: xDesigButton(
                      buttonName: "Download CV", icon: Icons.download))
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 80),
              child: ClipRect(
                child: Image.asset(
                  "assets/images/profile.png",
                  height: context.percentHeight * 30,
                ),
              ),
            )
          ],
        ),
      )
    ]);
  }

  Padding CertificationSection({
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height: context.percentHeight * 42,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 210, 21, 243),
                Color.fromARGB(255, 9, 137, 249)
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),

            // backgroundBlendMode: BlendMode.colorBurn,
            color: Colors.black12,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80),
                topRight: Radius.circular(80),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: CertificateView(),
      ),
    );
  }

  Padding CertificateView() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: VxSwiper.builder(
          viewportFraction: 1.0,
          autoPlay: true,
          height: 300,
          reverse: true,
          autoPlayCurve: Curves.easeIn,
          autoPlayInterval: 2.seconds,
          itemCount: certificateList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                        elevation: 10,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: xcolorGreenAccent, width: 2),
                                borderRadius: BorderRadius.circular(60)),
                            child: Image.asset(
                              certificateList[index]['certificate'],
                              fit: BoxFit.fitHeight,
                            ))),
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: xcolorGreenAccent, width: 1),
                          borderRadius: BorderRadius.circular(60)),
                      child: Text(
                        certificateList[index]['title'],
                        maxLines: 1,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              overflow: TextOverflow.fade,
                              fontSize: 12,
                              color: Colors.black,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
