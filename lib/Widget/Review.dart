// Skill Sections
import 'package:flutter/material.dart';
import 'package:mrx_profile/Controller/ClassData.dart';
import 'package:mrx_profile/Widget/style.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

ClassData classData = ClassData();

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
            itemCount: classData.reviewsList.length,
            autoPlay: true,
            autoPlayAnimationDuration: 2.seconds,
            itemBuilder: (context, index) => reviewCard(
                context,
                classData.reviewsList[index]['name'],
                classData.reviewsList[index]['post'],
                classData.reviewsList[index]['caption']),
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
                                fontSize: 14, italic: true, color: xcolorTeal),
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
