// Skill Sections
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/Controller/ClassData.dart';
import 'package:mrx_profile/Widget/HeadingTitle.dart';
import 'package:mrx_profile/Widget/style.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/CreateComment.dart';
import 'package:velocity_x/velocity_x.dart';

ClassData classData = ClassData();

class TestomonialRevies extends StatefulWidget {
  // required BuildContext context, required FixedExtentScrollController scrollController

  const TestomonialRevies({Key? key}) : super(key: key);

  @override
  State<TestomonialRevies> createState() => _TestomonialReviesState();
}

class _TestomonialReviesState extends State<TestomonialRevies> {
  FixedExtentScrollController scrollController= FixedExtentScrollController();
  int currentPosition=0;
   int totalComment=0;
  bool reverse=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(Duration(seconds: 2), (timer) {

        if(currentPosition==totalComment-1){

          currentPosition-=1;
          reverse=true;

          scrollController.jumpToItem(currentPosition);

        }else if(currentPosition==0){

          currentPosition+=1;
          reverse=false;
          scrollController.jumpToItem(currentPosition);


        }
        else{


          reverse?scrollController.jumpToItem(--currentPosition):scrollController.jumpToItem(++currentPosition);
        }

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    double desktopHeight = context.percentHeight * 55;
    double mobileHeight = context.percentHeight * 37;
    return  Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child:
            HeadingTitle(title: "People that always been our fist priority"),
          ),
          Container(
            height: context.screenHeight < 550.0
                ? mobileHeight
                : context.screenWidth < 500.0
                ? mobileHeight
                : desktopHeight,
            // width: context.screenWidth,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder(
                      stream: FirestoreService.getCommentData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var commentData = snapshot.data!;
                          totalComment=commentData.length;

                          return RotatedBox(
                            quarterTurns: -1,
                            child: Expanded(
                              child: ListWheelScrollView.useDelegate(

                                  itemExtent: 350,
                                  diameterRatio: 3.8,
                                  offAxisFraction: 1,


                                  controller:scrollController ,
                                  onSelectedItemChanged: (value) {
                                    currentPosition=value;

                                  },

                                  childDelegate: ListWheelChildBuilderDelegate( childCount: commentData.length,builder: (context,index)=>
                                      RotatedBox(
                                        quarterTurns: 1,
                                        child: reviewCard(
                                            context,
                                            commentData[index]['name'],
                                            commentData[index]['position'],
                                            commentData[index]['comment']),
                                      ),



                                  ) ),
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        context.nextPage(CreateComment());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: xcolorPink,
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), topRight: Radius.circular(30), bottomLeft: Radius.circular(70),topLeft: Radius.circular(5) ))
                      ),

                      icon: Icon(Icons.edit),
                      label: Text(
                        "Write you Feedback",
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );;
  }
}



Padding reviewCard(
    BuildContext context, String name, String post, String caption) {

  double desktopHeight = 350;
  double mobileHeight = context.percentHeight * 30;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: SizedBox(
        height: context.screenHeight < 550.0
            ? 190.0
            : context.screenWidth < 500.0
                ? mobileHeight - 10
                : desktopHeight - 10,
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
                gradient: LinearGradient(colors: [xcolorGrad2,xcolorGrad1,])),
            padding: const EdgeInsets.all(20),
            width: 400,
            height: context.screenHeight < 550
                ? 160
                : context.screenWidth < 500
                    ? mobileHeight - 15
                    : desktopHeight - 15,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.primaries[
                        Random().nextInt(Colors.primaries.length)],
                        child: Text(name.substring(0,1).toUpperCase(), style: TextStyle( fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),),

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
                        padding: const EdgeInsets.only(top: 3, left: 8, right: 3, bottom: 3),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Text(
                              caption,
                              style: xTextStyle(
                                  fontSize: 14, italic: true, color: xcolorTeal),
                            ),
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
