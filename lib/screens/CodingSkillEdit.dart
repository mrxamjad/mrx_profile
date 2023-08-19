import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CodingSkillEdit extends StatefulWidget {
  const CodingSkillEdit({super.key});

  @override
  State<CodingSkillEdit> createState() => _CodingSkillEditState();
}

class _CodingSkillEditState extends State<CodingSkillEdit> {
  var _skillController = TextEditingController();
  String dropdownValue = "Not Selected";
  String indexValue = 'Not Selected';
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
            codingSkillAlertDialog(context, "", "", "");
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
          stream: FirestoreService.readCodingSkill(),
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
                                  Text("Skill: ${codingData[index]['skill']}"),
                                  Text("Level: ${codingData[index]['level']}"),
                                  Text("Level: ${codingData[index]['index']}"),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  debugPrint(
                                      "Skill Data: ${codingData[index]['skill']} Level: ${codingData[index]['level']} Skill Index: ${codingData[index]['index']}");
                                  codingSkillAlertDialog(
                                      context,
                                      codingData[index]['skill'],
                                      codingData[index]['level'],
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
      ]),
    );
  }

  Future<dynamic> codingSkillAlertDialog(
      BuildContext context, String? skill, String? level, String? index) {
    if (skill != "" && level != "" && index != "") {
      indexValue = index!;
      dropdownValue = level!;
      _skillController.text = skill!;
    } else {
      indexValue = '20';

      dropdownValue = 'Beginner';
      _skillController.text = "";
    }
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Container(
                  child: Row(
                    children: [
                      Expanded(child: Center(child: Text("Add Coding Skill"))),
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
                              borderSide: BorderSide(
                                  color: xcolorGreenAccent, width: 3)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: xcolorGreenAccent, width: 3))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Center(child: Text("Skill Level")),
                        ),
                        // Step 1.
// String dropdownValue = 'Dog';
// Step 2.
                        DropdownButton<String>(
                          // Step 3.
                          value: dropdownValue,
                          // Step 4.
                          items: <String>[
                            'Expert',
                            'Advance',
                            'Medium',
                            'Beginner'
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
                              dropdownValue = newValue!;
                            });
                          },
                        ),
                      ],
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
                        FirestoreService.addCodingSkill(
                            _skillController.text, dropdownValue, indexValue);

                        _skillController.clear();
                        context.pop();
                        dropdownValue = "beginner";
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
            },
          );
        });
  }
}
