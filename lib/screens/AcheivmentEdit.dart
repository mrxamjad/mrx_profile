import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/Widget/customAppBar.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class OtherCertificationEdit extends StatefulWidget {
  const OtherCertificationEdit({super.key});

  @override
  State<OtherCertificationEdit> createState() => _OtherCertificationEditState();
}

class _OtherCertificationEditState extends State<OtherCertificationEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar("Achievements"),
        floatingActionButton: FloatingActionButton(
            backgroundColor: xcolorPink,
            child: Icon(
              Icons.add,
              size: 30,
              color: xcolorGreenAccent,
            ),
            onPressed: () {
              OtherCertificationAlertDialog(context, "", "", add: true);
            }),
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
          StreamBuilder(
            stream: FirestoreService.readOtherCertification(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final codingData = snapshot.data;
                // codingData!.sort();
                return ListView.builder(
                  itemCount: codingData!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: context.screenWidth>700?context.screenWidth*0.2:0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [xcolorGrad1, xcolorGrad2],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 15, bottom: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Skill: ",
                                              style: TextStyle(
                                                  color: xcolorPinkDisc,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${codingData[index]['title']}",
                                                style: const TextStyle(
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          children: [
                                            Text("Level: ",
                                                style: TextStyle(
                                                    color: xcolorPinkDisc,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                            Text(
                                              "${codingData[index]['index']}",
                                              style: const TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      debugPrint(
                                          "Skill Data: ${codingData[index]['title']} Level: ${codingData[index]['level']} Skill Index: ${codingData[index]['index']}");
                                      OtherCertificationAlertDialog(
                                          context,
                                          codingData[index]['title'],
                                          codingData[index]['index'],
                                          add: false);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 18,
                                        child: Icon(
                                          Icons.edit_note,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()  {
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(horizontal: context.screenWidth>600?context.screenWidth*0.2:0),
                                              child: Dialog(
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                                  child: Stack(
                                                      alignment:
                                                      Alignment.topCenter,
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(10),
                                                          margin:
                                                          const EdgeInsets
                                                              .only(
                                                              top: 60),
                                                          height: 150,
                                                          child: Column(
                                                            children: [
                                                              const Text(
                                                                'Delete Skill',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    22,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              const Text(
                                                                  "Are you sure want to delete?"),
                                                              Expanded(
                                                                  child:
                                                                  SizedBox()),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(
                                                                          5.0),
                                                                      child:
                                                                      ElevatedButton(
                                                                        style: const ButtonStyle(
                                                                            backgroundColor:
                                                                            MaterialStatePropertyAll<Color?>(Colors.green)),
                                                                        onPressed: () => Navigator.pop(
                                                                            context,
                                                                            'Cancel'),
                                                                        child: const Text(
                                                                            'Cancel'),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(
                                                                          5.0),
                                                                      child: ElevatedButton(
                                                                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color?>(Colors.red)),
                                                                          onPressed: () async {
                                                                            SharedPreferences sp= await SharedPreferences.getInstance();
                                                                            bool admin=sp.getBool('admin')??false;
                                                                            if (admin) {
                                                                              final docUser = FirebaseFirestore.instance.collection("other_certification").doc(codingData[index]['index'].toString()).delete();

                                                                              Navigator.pop(context);
                                                                            } else {
                                                                              context.showToast(msg: "Sorry, you are in Guest Mode!", bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                                                                            }
                                                                          },
                                                                          child: const Text(
                                                                            "Delete",
                                                                            style:
                                                                            TextStyle(color: Colors.white),
                                                                          )),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const Positioned(
                                                            top: -50,
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                              Colors.white,
                                                              radius: 55,
                                                              child:
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                Colors.red,
                                                                radius: 50,
                                                                child: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 70,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ))
                                                      ])),
                                            );
                                          });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 18,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return CircularPercentIndicator(radius: 20);
              }
            },
          )
        ]));
  }

  Future<dynamic> OtherCertificationAlertDialog(
      BuildContext context, String? title, String? index,
      {bool add = true}) {
    String indexValue;
    String skill;
    final _skillController = TextEditingController();

    if (title != "" && index != "") {
      indexValue = index!;

      _skillController.text = title!;
    } else {
      indexValue = '20';

      _skillController.text = "";
    }
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: context.screenWidth>600?context.screenWidth*0.2:0),
              child: Dialog(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 280,
                          margin: const EdgeInsets.only(top: 50),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                add ? "Add Certification" : "Update Certificate",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _skillController,
                                maxLength: 100,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: xcolorGreenAccent),
                                        borderRadius: BorderRadius.circular(20)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: xcolorPink),
                                        borderRadius: BorderRadius.circular(20)),
                                    // label: Text("Title"),
                                    labelStyle: TextStyle(color: xcolorPink),
                                    labelText: "Skill Name"),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: xcolorPink),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child:
                                          Center(child: Text("Index Position")),
                                    ),
                                    // Step 1.
// String dropdownValue = 'Dog';
// Step 2.
                                    DropdownButton<String>(
                                      // Step 3.
                                      value: indexValue,
                                      // Step 4.
                                      items: <String>[
                                        '1',
                                        '2',
                                        '3',
                                        '4',
                                        '5',
                                        '6',
                                        '7',
                                        '8',
                                        '9',
                                        '10',
                                        '13',
                                        '14',
                                        '16',
                                        '17',
                                        '18',
                                        '19',
                                        '20'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        );
                                      }).toList(),
                                      // Step 5.
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          indexValue = newValue!;
                                          debugPrint(
                                              "New value is ${indexValue}");
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color?>(Colors.red)),
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: const Text("Cancle")),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final SharedPreferences sp =
                                              await SharedPreferences
                                                  .getInstance();
                                          bool admin =
                                              sp.getBool('admin') ?? false;
                                          if (admin) {
                                            if (!_skillController
                                                .text.isEmptyOrNull) {
                                              FirestoreService
                                                  .addOtherCertification(
                                                      _skillController.text,
                                                      indexValue);

                                              _skillController.clear();
                                              context.pop();

                                              indexValue = '20';
                                            } else {
                                              context.showToast(
                                                  msg:
                                                      "Invalid Skill Name, Please check!",
                                                  bgColor: Colors.red,
                                                  textColor: Colors.white,
                                                  position: VxToastPosition.top);
                                            }
                                          } else {
                                            context.showToast(
                                                msg: "Sorry, You are a Guest",
                                                bgColor: Colors.red,
                                                textColor: Colors.white,
                                                position: VxToastPosition.top);
                                          }
                                        },
                                        child: Text(
                                            add ? "Add Skill" : "Update Skill"),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color?>(
                                                    add
                                                        ? xcolorPink
                                                        : Colors.green)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            top: -50,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 55,
                              child: CircleAvatar(
                                backgroundColor: add ? xcolorPink : Colors.green,
                                radius: 50,
                                child: Icon(add ? Icons.add : Icons.upload,
                                    size: 70, color: Colors.white),
                              ),
                            ))
                      ])),
            );
          });
        });
  }
}
