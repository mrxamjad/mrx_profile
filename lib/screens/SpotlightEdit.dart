
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/BackendService/SharePref.dart';
import 'package:mrx_profile/ModelClass/SkillsData.dart';
import 'package:mrx_profile/Widget/customAppBar.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class SkillPage extends StatefulWidget {
  const SkillPage({super.key});

  @override
  State<SkillPage> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {

  var _titleController = TextEditingController();
  var _descController = TextEditingController();
  var _skillAddController = TextEditingController();
  Stream<List<SkillsData>> readSkills() =>
      FirebaseFirestore.instance.collection("skills").snapshots().map((event) =>
          event.docs.map((e) => SkillsData.fromJson(e.data())).toList());
  bool admin=false;
  void checkAdmin() async {
    final SharedPreferences sp= await SharedPreferences.getInstance();
    admin= sp.getBool('admin')??false;
    print(admin);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAdmin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar("Spotlight"),
      floatingActionButton: FloatingActionButton(
        foregroundColor: xcolorGreenAccent,
        backgroundColor: xcolorPink,
        child: const Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                // _titleController.text =
                //     skills[index].title;
                // _descController.text =
                //     skills[index].title;

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: context.screenWidth>600?context.screenWidth*0.2:0),
                  child: Dialog(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        // side: BorderSide( color: xcolorPink),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          height: 300,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Container(
                                // padding: const EdgeInset.only( top:20),

                                child: const Text(
                                  'Create Skill',
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _titleController,
                                maxLength: 30,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: xcolorGreenAccent),
                                      borderRadius: BorderRadius.circular(20)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 1, color: xcolorPink),
                                      borderRadius: BorderRadius.circular(20)),
                                  // label: Text("Title"),
                                  labelText: "Skill Title",
                                  labelStyle: TextStyle(color: xcolorPink),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _descController,
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
                                    labelText: "Skill Description",
                                    labelStyle: TextStyle(color: xcolorPink)),
                              ),
                              Expanded(child: SizedBox()),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color?>(
                                                    Colors.red)),
                                        onPressed: () {
                                            Navigator.pop(context, 'Cancel');
                                            _skillAddController.clear();
                                            _descController.clear();
                                            _titleController.clear();
                                            },
                                        child: const Text('Cancel'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color?>(
                                                    Colors.green)),
                                        onPressed: () async {
                                          if(admin) {
                                            if (!_titleController
                                                .text.isEmptyOrNull ||
                                                !_descController
                                                    .text.isEmptyOrNull) {
                                              final docRef = FirebaseFirestore
                                                  .instance
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
                                            } else {
                                              context.showToast(
                                                  msg:
                                                  "Title or Description can't be empty",
                                                  bgColor: Colors.red,
                                                  textColor: Colors.white);
                                              _titleController.clear();
                                              _descController.clear();
                                            }
                                          }else{
                                            context.showToast(msg: "Sorry, you are in Guest Mode!",bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                                          }
                                        },
                                        child: const Text('Create'),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            top: -50,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 55,
                              child: CircleAvatar(
                                backgroundColor: xcolorPink,
                                radius: 50,
                                child: Icon(Icons.add,
                                    size: 70, color: Colors.white),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              });
        },
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
            height: context.screenHeight,
            width: context.screenWidth,
            child: Lottie.network(
                fit: BoxFit.cover,
                "https://assets10.lottiefiles.com/packages/lf20_ugIuhrl2vw.json"),
          ),
          Column(
            children: [
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
                              margin: EdgeInsets.symmetric(horizontal: context.screenWidth>700?context.screenWidth*0.2:0),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 173, 206, 234),
                                          Color.fromARGB(255, 200, 140, 210)
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      ),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only( top:18.0, left: 10, bottom: 18),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Title: ",
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              color:
                                                                  xcolorPinkDisc,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 250,
                                                          child: Text(


                                                            skills[index].title,


                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                   VxDivider( color: Colors.black, width: 3, ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Desc: ",
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible,
                                                          style: TextStyle(
                                                              color:
                                                                  xcolorPinkDisc,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 250,
                                                          child: Text(
                                                            skills[index].desc,

                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Container()
                                              ),
                                            )
                                          ],
                                        ),
                                        Positioned(
                                          top: -12,
                                          right: 20,
                                          child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  showDialog<String>(
                                                      context: context,
                                                      builder:
                                                          (BuildContext
                                                      context) {
                                                        _titleController
                                                            .text =
                                                            skills[index]
                                                                .title;
                                                        _descController
                                                            .text =
                                                            skills[index]
                                                                .desc;

                                                        return Container(
                                                          margin: EdgeInsets.symmetric(horizontal: context.screenWidth>600?context.screenWidth*0.2:0),
                                                          child: Dialog(
                                                              clipBehavior:
                                                              Clip.none,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      30)),
                                                              child: Stack(
                                                                  clipBehavior:
                                                                  Clip
                                                                      .none,
                                                                  alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                                  children: [
                                                                    Container(
                                                                      padding:
                                                                      const EdgeInsets.all(8),
                                                                      margin:
                                                                      const EdgeInsets.only(top: 60),
                                                                      height:
                                                                      300,
                                                                      child:
                                                                      Column(children: [
                                                                        const Text(
                                                                          'Update Skill',
                                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                                                                        ),
                                                                        SizedBox(
                                                                          height: 20,
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            TextFormField(
                                                                              // initialValue: skills[index].title,
                                                                                controller: _titleController,
                                                                                maxLength: 30,
                                                                                decoration: InputDecoration(
                                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: xcolorGreenAccent), borderRadius: BorderRadius.circular(20)),
                                                                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: xcolorPink), borderRadius: BorderRadius.circular(20)),
                                                                                    // label: Text("Title"),
                                                                                    labelStyle: TextStyle(color: xcolorPink),
                                                                                    labelText: "Title")),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            TextFormField(
                                                                              // initialValue: skills[index].desc,
                                                                                controller: _descController,
                                                                                maxLength: 100,
                                                                                decoration: InputDecoration(
                                                                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: xcolorGreenAccent), borderRadius: BorderRadius.circular(20)),
                                                                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: xcolorPink), borderRadius: BorderRadius.circular(20)),
                                                                                    // label: Text("Title"),
                                                                                    labelStyle: TextStyle(color: xcolorPink),
                                                                                    labelText: "Description"))
                                                                          ],
                                                                        ),
                                                                        const Expanded(child: SizedBox()),
                                                                        Row(
                                                                          children: <Widget>[
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(5.0),
                                                                                child: ElevatedButton(
                                                                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color?>(Colors.red)),
                                                                                  onPressed: () { Navigator.pop(context, 'Cancel');
                                                                                  _titleController
                                                                                      .clear();
                                                                                  _descController
                                                                                      .clear();},
                                                                                  child: const Text('Cancel'),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(5.0),
                                                                                child: ElevatedButton(
                                                                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color?>(Colors.green)),
                                                                                  onPressed: () async {
                                                                                   // SharedPreferences sp= await SharedPreferences.getInstance();
                                                                                   // admin=sp.getBool('admin')??false;

                                                                                   print("Admin $admin");


                                                                                   if(admin){
                                                                                     if (!_titleController.text.isEmptyOrNull && !_descController.text.isEmptyOrNull) {
                                                                                      final docRef = FirebaseFirestore
                                                                                          .instance
                                                                                          .collection(
                                                                                          "skills")
                                                                                          .doc(
                                                                                          skills[index]
                                                                                              .id
                                                                                              .toString());
                                                                                      await docRef
                                                                                          .update(
                                                                                          {
                                                                                            'id': skills[index]
                                                                                                .id,
                                                                                            'title': _titleController
                                                                                                .text,
                                                                                            'desc': _descController
                                                                                                .text
                                                                                          });

                                                                                      Navigator
                                                                                          .pop(
                                                                                          context,
                                                                                          'Update');
                                                                                      _titleController
                                                                                          .clear();
                                                                                      _descController
                                                                                          .clear();

                                                                                    } else {
                                                                                      context.showToast(msg: "Invalid title or description", bgColor: Colors.red, textColor: Colors.white,position: VxToastPosition.top);
                                                                                    }
                                                                                   }else{
                                                                                     context.showToast(msg: "Sorry, you are in Guest Mode!",bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                                                                                   }
                                                                                  },
                                                                                  child: const Text('Update'),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ]),
                                                                    ),
                                                                    const Positioned(
                                                                        top:
                                                                        -50,
                                                                        child:
                                                                        CircleAvatar(
                                                                          backgroundColor: Colors.white,
                                                                          radius: 55,
                                                                          child: CircleAvatar(
                                                                            backgroundColor: Colors.green,
                                                                            radius: 50,
                                                                            child: Icon(Icons.upload, size: 70, color: Colors.white),
                                                                          ),
                                                                        ))
                                                                  ])),
                                                        );
                                                      }),
                                              child: CircleAvatar(
                                                radius: 13,
                                                backgroundColor:
                                                Colors.white,
                                                child: Icon(
                                                  Icons.edit,
                                                  color: xcolorPink,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () =>
                                                  showDialog<String>(
                                                      context: context,
                                                      builder:
                                                          (BuildContext
                                                      context) {
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
                                                                  Alignment
                                                                      .topCenter,
                                                                  clipBehavior:
                                                                  Clip.none,
                                                                  children: [
                                                                    Container(
                                                                      padding:
                                                                      const EdgeInsets.all(10),
                                                                      margin:
                                                                      const EdgeInsets.only(top: 60),
                                                                      height:
                                                                      150,
                                                                      child:
                                                                      Column(
                                                                        children: [
                                                                          const Text(
                                                                            'Delete Skill',
                                                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                                                          ),
                                                                          const SizedBox(height: 10),
                                                                          const Text("Are you sure want to delete?"),
                                                                          Expanded(child: SizedBox()),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(5.0),
                                                                                  child: ElevatedButton(
                                                                                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color?>(Colors.green)),
                                                                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                                    child: const Text('Cancel'),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(5.0),
                                                                                  child: ElevatedButton(
                                                                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color?>(Colors.red)),
                                                                                      onPressed: () async {
                                                                                        if(admin) {
                                                                                          await FirebaseFirestore
                                                                                              .instance
                                                                                              .collection(
                                                                                              "skills")
                                                                                              .doc(
                                                                                              skills[index]
                                                                                                  .id)
                                                                                              .delete();

                                                                                          Navigator
                                                                                              .pop(
                                                                                              context);
                                                                                        }
                                                                                        else{
                                                                                          context.showToast(msg: "Sorry, you are in Guest Mode!",bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                                                                                        }
                                                                                      },
                                                                                      child: const Text(
                                                                                        "Delete",
                                                                                        style: TextStyle(color: Colors.white),
                                                                                      )),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const Positioned(
                                                                        top:
                                                                        -50,
                                                                        child:
                                                                        CircleAvatar(
                                                                          backgroundColor: Colors.white,
                                                                          radius: 55,
                                                                          child: CircleAvatar(
                                                                            backgroundColor: Colors.red,
                                                                            radius: 50,
                                                                            child: Icon(Icons.delete, size: 70, color: Colors.white),
                                                                          ),
                                                                        ))
                                                                  ])),
                                                        );
                                                      }),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                child: CircleAvatar(
                                                  radius: 13,
                                                  backgroundColor:
                                                  Colors.white,
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                    color: xcolorPink,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child:  SizedBox(
                        height: 100,
                          child: CircularProgressIndicator( color: xcolorPinkDisc,)));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
