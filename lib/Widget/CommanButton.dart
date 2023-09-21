import 'package:flutter/material.dart';
import 'package:mrx_profile/constants/xcolor.dart';

class CommanButton extends StatelessWidget {
  String? name;
  Icon? icon;
  void Function()? func;
  CommanButton({
    this.name,
    this.icon,
    this.func,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // border: Border.all(
            //   width: 2,
            //   color: xcolorGreenAccent,
            // )
        ),
        margin: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: func,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? SizedBox(),
              SizedBox(width: 10,),
              Text(
                name ?? "",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),

            ],
          ),
        ));
  }
}
