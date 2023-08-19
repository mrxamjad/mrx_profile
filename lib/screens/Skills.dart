import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/ModelClass/SkillsData.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

class SkillPage extends StatefulWidget {
  const SkillPage({super.key});

  @override
  State<SkillPage> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  var _titleController = TextEditingController();
  var _descController = TextEditingController();
  Stream<List<SkillsData>> readSkills() =>
      FirebaseFirestore.instance.collection("skills").snapshots().map((event) =>
          event.docs.map((e) => SkillsData.fromJson(e.data())).toList());
  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 100, left: 10, right: 10),
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(50)),
                child: ElevatedButton(
                  child: Text("Create Skill"),
                  onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        // _titleController.text =
                        //     skills[index].title;
                        // _descController.text =
                        //     skills[index].title;

                        return AlertDialog(
                          title: const Text('Create Skill'),
                          content: Container(
                            width: 400,
                            height: 200,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _titleController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: xcolorGreenAccent),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      // label: Text("Title"),
                                      labelText: "Skill Title"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _descController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: xcolorGreenAccent),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      // label: Text("Title"),
                                      labelText: "Skill Description"),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final docRef = FirebaseFirestore.instance
                                    .collection("skills")
                                    .doc();
                                await docRef.set({
                                  'id': docRef.id,
                                  'title': _titleController.text,
                                  'desc': _descController.text
                                });

                                _titleController.clear();
                                _descController.clear();

                                Navigator.pop(context, 'Create');
                              },
                              child: const Text('Create'),
                            ),
                          ],
                        );
                      }),
                )),
            Expanded(
              child: StreamBuilder(
                stream: readSkills(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final skills = snapshot.data;
                    return ListView.builder(
                      itemCount: skills!.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 223, 170, 212),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: xcolorGreenAccent, width: 2)),
                            child: InkWell(
                              onDoubleTap: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    _titleController.text = skills[index].title;
                                    _descController.text = skills[index].desc;
                                    // _titleController.text =
                                    //     skills[index].title;
                                    // _descController.text =
                                    //     skills[index].title;

                                    return AlertDialog(
                                      title: const Text('Update Skill'),
                                      content: Column(
                                        children: [
                                          TextFormField(
                                            // initialValue: skills[index].title,
                                            controller: _titleController,
                                          ),
                                          TextFormField(
                                            // initialValue: skills[index].desc,
                                            controller: _descController,
                                          )
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final docRef = FirebaseFirestore
                                                .instance
                                                .collection("skills")
                                                .doc(skills[index]
                                                    .id
                                                    .toString());
                                            await docRef.update({
                                              'id': skills[index].id,
                                              'title': _titleController.text,
                                              'desc': _descController.text
                                            });

                                            Navigator.pop(context, 'Update');
                                            _titleController.clear();
                                            _descController.clear();
                                          },
                                          child: const Text('Update'),
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection("skills")
                                                  .doc(skills[index].id)
                                                  .delete();

                                              Navigator.pop(context);
                                            },
                                            child: Text("Delete"))
                                      ],
                                    );
                                  }),
                              child: ListTile(
                                title: Text(skills[index].title),
                                subtitle: Text(skills[index].desc),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
