import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
        floatingActionButton: FloatingActionButton(
            backgroundColor: xcolorPink,
            child: Icon(
              Icons.add,
              size: 30,
              color: xcolorGreenAccent,
            ),
            onPressed: () {
              OtherCertificationAlertDialog(context, "", "");
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
                    return SizedBox(
                      height: 80,
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Skill: ${codingData[index]['title']}"),
                                    Text(
                                        "Level: ${codingData[index]['index']}"),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    debugPrint(
                                        "Skill Data: ${codingData[index]['title']} Level: ${codingData[index]['level']} Skill Index: ${codingData[index]['index']}");
                                    OtherCertificationAlertDialog(
                                        context,
                                        codingData[index]['title'],
                                        codingData[index]['index']);
                                  },
                                  icon: Icon(Icons.edit_note))
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
      BuildContext context, String? title, String? index) {
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
            return AlertDialog(
              title: Container(
                child: Row(
                  children: [
                    Expanded(child: Center(child: Text("Add Certification"))),
                    IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(
                          Icons.cancel_sharp,
                          color: xcolorPink,
                          size: 30,
                        ))
                  ],
                ),
              ),
              content: Container(
                height: 300,
                width: 200,
                child: Column(children: [
                  TextFormField(
                    controller: _skillController,
                    decoration: InputDecoration(
                        label: Text("Skill Name"),
                        hintText: "Skill Title",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: xcolorGreenAccent, width: 3)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: xcolorGreenAccent, width: 3))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Center(child: Text("Index Position")),
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
                        ].map<DropdownMenuItem<String>>((String value) {
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
                            debugPrint("New value is ${indexValue}");
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirestoreService.addOtherCertification(
                          _skillController.text, indexValue);

                      _skillController.clear();
                      context.pop();

                      indexValue = '20';
                    },
                    child: Text("Add Skill"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color?>(xcolorPink)),
                  )
                ]),
              ),
            );
          });
        });
  }
}
