import 'package:flutter/material.dart';
import 'package:mrx_profile/constants/xcolor.dart';

AppBar customAppBar(String title){
  return AppBar(

    centerTitle: true,
    // brightness: Brightness.dark,
    title:Text(title),
    backgroundColor: Colors.transparent,
    elevation: 0,

    titleSpacing:6 ,
    excludeHeaderSemantics:true,
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
          ,
          color:
          // xcolorPink
          Color.fromARGB(255, 186, 224, 231)
      ),
    ),


  );
}