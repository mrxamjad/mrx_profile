import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class SingleTextEditAlert extends StatelessWidget {
  const SingleTextEditAlert({
    Key? key,
    required String title,
    required String description,
    required String updateKey,
  })  : title = title,
        description = description,
        updateKay = updateKey,
        super(key: key);

  final String title;
  final String description;
  final String updateKay;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            // border: Border.all(width: 1, color: xcolorGreenAccent),
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [xcolorGrad1, xcolorGrad2],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: InkWell(
            onDoubleTap: () {
              showEditingDialog(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, top: 3, ),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Color.fromARGB(255, 161, 0, 140),
                          fontWeight: FontWeight.bold),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Center(
                      child: Text(
                          description,
                          style: TextStyle(fontSize: 14, color: xcolorTeal),
                      ),
                    ),
                        )),
                    IconButton(
                      onPressed: () {
                        showEditingDialog(context);
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.edit,
                          color: xcolorPink,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future<dynamic> showEditingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          var controller = TextEditingController(text: description);
          return Container(
              margin: EdgeInsets.symmetric(horizontal: context.screenWidth>600?context.screenWidth*0.2:0),
            child: Dialog(
              elevation: 5,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),
                child: Stack(
                  alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
              Container(margin: const EdgeInsets.only( top: 60),
                padding: const EdgeInsets.only( left: 10, right: 10, bottom: 10),
                height: 200,
                child: Column(
                  children: [
                    Text("Update $title", style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold),),
                    SizedBox( height: 10,),
                    TextFormField(
                      controller: controller,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: xcolorGreenAccent), borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: xcolorPink), borderRadius: BorderRadius.circular(20)),
                            // label: Text("Title"),
                            labelStyle: TextStyle(color: xcolorPink),
                            labelText: "$title"),
                    ), Expanded(child: SizedBox( )),
                    Row(
                      children: [

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color?> (Colors.red)
                                ),
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
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color?> (Colors.green)
                                ),
                                onPressed: () async {
                                  final SharedPreferences sp= await SharedPreferences.getInstance();
                                  bool admin=sp.getBool("admin")??false;
                                  if(admin) {
                                    if (!controller.text.isEmptyOrNull) {
                                      FirebaseFirestore.instance
                                          .collection("profileData")
                                          .doc('1')
                                          .update({updateKay: controller.text});

                                      context.pop();
                                    }
                                    else {
                                      context.showToast(msg: "Invalid Input!",
                                          bgColor: Colors.red,
                                          textColor: Colors.white);
                                    }
                                  }
                                  else{
                                    context.showToast(msg: "Sorry, you are in Guest Mode!",bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                                  }
                                },
                                child: const Text("Update")),
                          ),
                        ),
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
                          backgroundColor: Colors.green,
                          radius: 50,
                          child: Icon(Icons.upload, size: 70, color: Colors.white),
                        ),
                      ))
            ])),
          );
        });
  }
}
