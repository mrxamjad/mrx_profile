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
import 'package:mrx_profile/Widget/customAppBar.dart';
import 'package:mrx_profile/Widget/updateSingleTextAlert.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:mrx_profile/screens/ResumeEdit.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        FirebaseStorage.instance.ref().child(filename).child(updateField);
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
      extendBodyBehindAppBar: true,
      appBar: customAppBar("Profile"),
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
            SingleChildScrollView(
              child: Container(
                child: Column(children: [
                  SizedBox(
                    height: 50,
                  ),
                  FutureBuilder<Map<String, dynamic>?>(
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


                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: context.screenWidth>700?context.screenWidth*0.2:0),
                            child: Column(
                              children: [
                                SizedBox(height: 50,),
                                Row(children: [
                                  Expanded(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20)),
                                      elevation: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            colors: [xcolorGrad1, xcolorGrad2],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin:
                                              const EdgeInsets.only(top: 20),
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 28, vertical: 3),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                  color: xcolorGreenAccent),
                                              child: Text("Profile"),
                                            ),
                                            Container(
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                    BorderRadius.circular(100)),
                                                height: 200,
                                                width: 200,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(3.0),
                                                  child: CircleAvatar(
                                                    backgroundColor: xcolorPink,
                                                    child: CircleAvatar(
                                                      radius: 88,
                                                      backgroundColor: xcolorPink,
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
                                                    ),
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 150,
                                              child: ElevatedButton.icon(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStatePropertyAll<
                                                          Color?>(xcolorPink)),
                                                  onPressed: () async {


                                                    ImageChooserBottomSheet(
                                                        context,"profile_image");
                                                  },
                                                  icon: const Icon(
                                                      Icons.add_a_photo_outlined),
                                                  label:
                                                  const Text("Select Image")),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            colors: [xcolorGrad1, xcolorGrad2],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin:
                                              const EdgeInsets.only(top: 20),
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 28, vertical: 3),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                  color: xcolorGreenAccent),
                                              child: Text("Banner"),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                  BorderRadius.circular(100)),
                                              height: 200,
                                              width: 200,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    3.0),
                                                child: CircleAvatar(
                                                  backgroundColor: xcolorPink,
                                                  child: CircleAvatar(
                                                    radius: 88,
                                                    foregroundImage: image2 ==
                                                        null &&
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
                                              ),
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: ElevatedButton.icon(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStatePropertyAll<
                                                          Color?>(xcolorPink)),
                                                  onPressed: () async {
                                                    ImageChooserBottomSheet(
                                                        context,"banner_image");
                                                  },
                                                  icon: const Icon(
                                                      Icons.add_a_photo_outlined),
                                                  label:
                                                  const Text("Select Image")),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
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
                            ),
                          );
                        }
                        else{
                          return Center(child: CircularProgressIndicator( color: xcolorPinkDisc,));
                        }
                      })
                ]),
              ),
            ),
          ],
        ));
  }

  Future<dynamic> ImageChooserBottomSheet(BuildContext context,String FieldName) async{
    XFile? image;
    bool isLoading=false;

    return
      showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: context.screenWidth>600?context.screenWidth*0.2:0),
          child: StatefulBuilder(builder: (context, setState) =>isLoading?SizedBox(
            height: 200,


              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    height: 180,
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          CircularProgressIndicator( color: xcolorPink, strokeWidth: 8, ),
                          SizedBox(height: 10,),
                          Text("Uploading..", style: TextStyle(fontWeight: FontWeight.bold, color: xcolorPink, fontSize: 20),)
                        ],
                      )),
                ),
              )):
            SizedBox(
            height: 200,
            child: InkWell(
              onTap: () async {
                image = await picker.pickImage(source: ImageSource.camera);
                context.showToast(msg: "Selected Camara Image: ${image!.name.toString()}");
                setState(() {
                  //update UI
                });
                // context.pop();


              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(border: Border()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(child: Center(child: Text(image?.name??"No Image Selected",)),),
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
                        image =
                            await picker.pickImage(source: ImageSource.gallery);
                        context.showToast(msg: "Selected Camara Image: ${image!.name.toString()}");
                        setState(() {
                          //update UI
                        });
                        // context.pop();
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
                    SizedBox(
                      width: 150,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll<
                                  Color?>(xcolorPink)),
                          onPressed: () async {
                            try {
                              final SharedPreferences sp= await SharedPreferences.getInstance();
                              bool admin=sp.getBool('admin')??false;

                              if(admin) {
                                if(image!=null) {
                                  isLoading=true;
                                  setState((){});

                                 // isLoading?showDialog(context: context, builder: (context) => StatefulBuilder(builder: (context, setState) => CircularProgressIndicator(),) ,):null;
                                  await _uploadImage(
                                      "profile",
                                      image,
                                      FieldName);

                                  context.showToast( msg: 'Successfully uploaded', bgColor: Colors.green, position: VxToastPosition.center);
                                  isLoading=false;
                                  setState((){});
                                  context.pop();




                                }
                                else{
                                  context.showToast(msg: "Please select an Image", position: VxToastPosition.top);
                                }

                              }
                              else{
                                context.showToast(msg: "Sorry, you are in Guest Mode!",bgColor: Colors.red, textColor: Colors.white, position: VxToastPosition.top);
                              }
                            } catch (error) {
                              print(
                                  "error in uploading $error");
                            }
                          },
                          icon: const Icon(
                              Icons.upload_outlined),
                          label: const Text("Upload")),
                    ),
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
