import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/BackendService/FirestoreService.dart';
import 'package:mrx_profile/Widget/ProfileSection.dart';
import 'package:mrx_profile/Widget/updateSingleTextAlert.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  var profile;
  var _name,
      _desc,
      _founder,
      _position,
      _mobile,
      _email,
      _address,
      _youTube,
      _insta,
      _facebook,
      _github;

  var defoultImage =
      "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80";
  XFile? image1, image2;
  var _profileImage, _bannerImage;

  //new method for selecting the image
  ImagePicker picker = ImagePicker();

  //upload image to firebase
  Future _uploadImage(String filename, var file, String updateField) async {
    UploadTask uploadTask;
    final ref =
        FirebaseStorage.instance.ref().child(filename).child("/" + file.name);
    uploadTask = ref.putFile(File(file.path));
    await uploadTask.whenComplete(() => {});
    String imageURL = await ref.getDownloadURL();
    debugPrint("This the image url: $imageURL");

    final docUser =
        FirebaseFirestore.instance.collection("profileData").doc("1");
    await docUser.update({"${updateField}": imageURL});
  }

  //get the profile data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            const SizedBox(
              height: 200,
            ),
            Column(
              children: [
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      ProfileSection(context),
                      Container(
                        height: 500,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: FutureBuilder<Map<String, dynamic>?>(
                              future: FirestoreService.readProfile(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  profile = snapshot.data;
                                  print("DATA IS: ${profile}");

                                  _name = profile!['name'];
                                  _address = profile['adress'];
                                  _desc = profile['description'];
                                  _email = profile['email'];
                                  _facebook = profile['facebook'];
                                  _founder = profile['founder'];
                                  _github = profile['github'];
                                  _insta = profile['instagram'];
                                  _mobile = profile['mobile'];
                                  _position = profile['position'];
                                  _youTube = profile['youtube'];
                                  _bannerImage = profile['banner_image'];
                                  _profileImage = profile['profile_image'];
                                }
                                if (snapshot.hasError) {
                                  print("We got some error on this project");
                                }
                                return Column(
                                  children: [
                                    Row(children: [
                                      Column(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.teal,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              height: 200,
                                              width: 200,
                                              child: CircleAvatar(
                                                backgroundImage: image1 ==
                                                            null &&
                                                        _profileImage == null
                                                    ? NetworkImage(
                                                        defoultImage,
                                                      )
                                                    : image1 != null
                                                        ? FileImage(File(
                                                                image1!.path))
                                                            as ImageProvider
                                                        : NetworkImage(
                                                            _profileImage,
                                                          ),
                                              )),
                                          ElevatedButton.icon(
                                              onPressed: () async {
                                                // image1 = await picker.pickImage(
                                                //     source: ImageSource.camera);
                                                // setState(() {
                                                //   //update UI
                                                // });

                                                ImageChooserBottomSheet(
                                                    context, image1);
                                              },
                                              icon: const Icon(
                                                  Icons.add_a_photo_outlined),
                                              label:
                                                  const Text("Select Image")),
                                          ElevatedButton.icon(
                                              onPressed: () async {
                                                try {
                                                  await _uploadImage("profile",
                                                      image1, "profile_image");
                                                } catch (error) {
                                                  print(
                                                      "error in uploading $error");
                                                }
                                              },
                                              icon: const Icon(
                                                  Icons.upload_outlined),
                                              label: const Text("Upload")),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.pink,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            height: 200,
                                            width: 200,
                                            child: CircleAvatar(
                                              foregroundImage: image2 == null &&
                                                      _profileImage == null
                                                  ? NetworkImage(
                                                      defoultImage,
                                                      scale: 1000,
                                                    )
                                                  : image2 != null
                                                      ? FileImage(File(
                                                              image2!.path))
                                                          as ImageProvider
                                                      : NetworkImage(
                                                          _bannerImage,
                                                        ),
                                            ),
                                          ),
                                          ElevatedButton.icon(
                                              onPressed: () async {
                                                ImageChooserBottomSheet(
                                                    context, image2);
                                              },
                                              icon: const Icon(
                                                  Icons.add_a_photo_outlined),
                                              label:
                                                  const Text("Select Image")),
                                          ElevatedButton.icon(
                                              onPressed: () async {
                                                await _uploadImage("profile",
                                                    image2, "banner_image");
                                              },
                                              icon: const Icon(
                                                  Icons.upload_outlined),
                                              label: const Text("Upload")),
                                        ],
                                      ),
                                    ]),

                                    /// Text Editing Field box for alertDialog
                                    SingleTextEditAlert(
                                      description: _name,
                                      title: "Full Name",
                                      updateKey: "name",
                                    ),
                                    SingleTextEditAlert(
                                      description: _desc,
                                      title: "Description",
                                      updateKey: "description",
                                    ),
                                    SingleTextEditAlert(
                                      description: _founder,
                                      title: "Founder of",
                                      updateKey: "founder",
                                    ),
                                    SingleTextEditAlert(
                                      description: _position,
                                      title: "Position",
                                      updateKey: "position",
                                    ),
                                    SingleTextEditAlert(
                                      description: _mobile,
                                      title: "Mobile No",
                                      updateKey: "mobile",
                                    ),
                                    SingleTextEditAlert(
                                      description: _email,
                                      title: "Email",
                                      updateKey: "email",
                                    ),
                                    SingleTextEditAlert(
                                      description: _address,
                                      title: "Address",
                                      updateKey: "adress",
                                    ),
                                    SingleTextEditAlert(
                                      description: _youTube,
                                      title: "YouTube",
                                      updateKey: "youtube",
                                    ),
                                    SingleTextEditAlert(
                                      description: _insta,
                                      title: "Instagram",
                                      updateKey: "instagram",
                                    ),
                                    SingleTextEditAlert(
                                      description: _facebook,
                                      title: "Facebook",
                                      updateKey: "facebook",
                                    ),
                                    SingleTextEditAlert(
                                      description: _github,
                                      title: "GitHub",
                                      updateKey: "github",
                                    ),
                                  ],
                                );
                              }),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Future<dynamic> ImageChooserBottomSheet(BuildContext context, var image) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: InkWell(
            onTap: () async {
              image = await picker.pickImage(source: ImageSource.camera);
              setState(() {
                //update UI
              });
              context.pop();
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(border: Border()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 250,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: xcolorGreenAccent, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera_enhance,
                          color: Colors.pink,
                          size: 30,
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // image =
                      //     await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        //update UI
                      });
                      context.pop();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 50,
                      width: 250,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: xcolorGreenAccent, width: 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_rounded,
                            color: Colors.pink,
                            size: 30,
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(
                                color: Colors.pink,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
