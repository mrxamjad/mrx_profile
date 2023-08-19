import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrx_profile/constants/xcolor.dart';
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
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: xcolorGreenAccent),
            borderRadius: BorderRadius.circular(30)),
        child: InkWell(
          onDoubleTap: () {
            showEditingDialog(context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10, top: 3),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: xcolorGreenAccent, fontWeight: FontWeight.bold),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Center(
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        showEditingDialog(context);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: xcolorPink,
                      ))
                ],
              ),
            ],
          ),
        ));
  }

  Future<dynamic> showEditingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          var _controller = TextEditingController(text: description);
          return AlertDialog(
            content: TextFormField(
              controller: _controller,
            ),
            title: Text("Update $title"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("profileData")
                        .doc('1')
                        .update({'$updateKay': _controller.text});

                    context.pop();
                  },
                  child: Text("Update")),
              ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text("Cancle")),
            ],
          );
        });
  }
}
