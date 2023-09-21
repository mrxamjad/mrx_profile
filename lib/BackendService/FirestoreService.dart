import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  // method for getting the data profile data
  static Future<Map<String, dynamic>?> readProfile() async {
    final docUser =
        FirebaseFirestore.instance.collection("profileData").doc("1");
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return snapshot.data()!;
    }
  }

  // Upload  Profile Image to firebase
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

  //Read Coding skill data from firebase -- method
  static Stream<List<Map<String, dynamic>>> readCodingSkill() {
    return FirebaseFirestore.instance
        .collection('coding_skill')
        .snapshots()
        .map((snaps) => snaps.docs.map((e) => (e.data())).toList());
  }
  //Add Coding Skill data to firebase--Method

  static Future addCodingSkill(String skill, String level, String index) async {
    FirebaseFirestore.instance.collection('coding_skill').doc('$index').set(
        {'skill': skill, 'level': level, 'index': index}).catchError((error) {
      debugPrint("Error in adding coding skill: $error");
    }).then((value) {
      debugPrint("Codin Skill added");
    });
  }

  //Read Other Cer data from firebase -- method
  static Stream<List<Map<String, dynamic>>> readOtherCertification() {
    return FirebaseFirestore.instance
        .collection('other_certification')
        .snapshots()
        .map((snaps) => snaps.docs.map((e) => (e.data())).toList());
  }
  //Add Coding Skill data to firebase--Method

  static Future addOtherCertification(String skill, String index) async {
    FirebaseFirestore.instance
        .collection('other_certification')
        .doc('$index')
        .set({'title': skill, 'index': index}).catchError((error) {
      debugPrint("Error in adding coding skill: $error");
    }).then((value) {
      debugPrint("Codin Skill added");
    });
  }

  // Updload PDF ti firebaseStorage
  static Future uploadPdfToFirestore(
      String? fileName,
      File file,
      String fireStorageRefName,
      String fireCollName,
      String fireDocName,
      String fireUpdateField) async {
    String? downloadURL = "";
    final reference = FirebaseStorage.instance
        .ref("$fireStorageRefName")
        .child("resume.pdf");
    final uploadTask = reference.putFile(file);
    debugPrint("Firestore upaloding started");
    await uploadTask
        .whenComplete(() => debugPrint("Pdf: $fileName Uploaded to FireStore"));
    downloadURL = await reference.getDownloadURL();

    debugPrint("Download Link: $downloadURL");
    await uploadLinkToFirestore(
        downloadURL, fireCollName, fireDocName, fireUpdateField);
  }

  static Future uploadLinkToFirestore(String link, String fireCollName,
      String fireDocName, String fireUpdateField) async {
    debugPrint("Resume Data is bein updated");
    await FirebaseFirestore.instance
        .collection("$fireCollName")
        .doc('$fireDocName')
        .update({'$fireUpdateField': link}).then((value) => () {
              debugPrint("Resume Data Successfully Updated Under Then");
            });
    debugPrint("Resume Data Successfully Updated");
  }

  // CERTIFICATE FIRESTORE SERVICES

// GET ALL CERTIFICATE DATA
  static Stream<List<Map<String, dynamic>>> getCertificateData() {
    return FirebaseFirestore.instance
        .collection('certificate')
        .snapshots()
        .map((snaps) => snaps.docs.map((e) => (e.data())).toList());
  }

  // GET COMMENT DATA
  static Stream<List<Map<String, dynamic>>> getCommentData() {
    return FirebaseFirestore.instance
        .collection('comments')
        .snapshots()
        .map((snaps) => snaps.docs.map((e) => (e.data())).toList());
  }

  //Get Skill Data

  static Stream<List<Map<String, dynamic>>> getRegularSkillData() {
    return FirebaseFirestore.instance
        .collection('regular_skill')
        .snapshots()
        .map((snaps) => snaps.docs.map((e) => (e.data())).toList());
  }

  //Add regular skill data

  static Future addRegularSkill(
      String skill, String level, String index) async {
    FirebaseFirestore.instance.collection('regular_skill').doc('$index').set(
        {'skill': skill, 'level': level, 'index': index}).catchError((error) {
      debugPrint("Error in adding coding skill: $error");
    }).then((value) {
      debugPrint("Codin Skill added");
    });
  }
}

//GET RESUME LINK
//Get the resume data from Firebase
 Future getResumeData() async {
  List<Map<String, dynamic>> list = [];

  final results = await FirebaseFirestore.instance.collection("resume").get();
  list = results.docs.map((e) => e.data()).toList();
  String link = list[0]['link'];
  debugPrint("PDF link: $link");

  return list;
}
