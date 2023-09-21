//Design for Each style and customizable

import 'package:flutter/material.dart';
import 'package:mrx_profile/Widget/style.dart';

SizedBox AchivementItem({
  required BuildContext context,
  double size = 170,
  double elevation = 10,
  required headText,
  required descriptionText,
  double headTextSize = 16,
  Color headTextColor = Colors.white,
  double descTextSize = 12,
  Color descTextColor = const Color.fromARGB(255, 63, 35, 177),
  Color gradientPrimary = Colors.tealAccent,
  Color gradiantSecondry = Colors.pinkAccent,
}) {
  return SizedBox(
    width: size,
    child: Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 0),
      child: Card(
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        surfaceTintColor: Colors.amber,
        child: Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [gradientPrimary, gradiantSecondry],
                  begin: Alignment.bottomRight,
                  end: Alignment.topCenter)),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 12, right: 0),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 63, 35, 177),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      headText,
                      style: xTextStyle(
                          bold: true,
                          color: Colors.white,
                          fontSize: headTextSize),
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(right: 8, bottom: 5),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))),
                child: Text(
                  descriptionText,
                  style: xTextStyle(
                      italic: true,
                      fontSize: descTextSize,
                      bold: true,
                      color: descTextColor),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
