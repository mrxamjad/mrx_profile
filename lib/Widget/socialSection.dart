import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mrx_profile/constants/xcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../SetUp/ProductionSetup.dart';

//Redirect the user to user profile

Future<void> goToWebPage(String urlString) async {
  final Uri _url = Uri.parse(urlString);
  await launchUrl(_url);
}

SizedBox SocialNewtwork(BuildContext context) {
  return SizedBox(
    child: Container(
      width: context.percentHeight * 100,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [

          !ProductionSetup.isProduction?Text(
              "Height: ${context.screenHeight}  Width: ${context.screenWidth}"):SizedBox(),
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: xcolorPink,width: 2)
            ),
            child: Center( child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text("Contact", style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold, color: xcolorPinkDisc),),
              SizedBox(width: 5,),
              Text("uS", style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold, color:  xcolorGreenAccent),),

            ],)

            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    final Uri phoneNumber = Uri.parse('tel:+917260004480');
                    await launchUrl(phoneNumber);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                        
                      ),
                      
                      child: Image.asset(
                        'assets/icon/phone-min.png',

                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final Uri url =
                        Uri.parse('https://www.linkedin.com/in/mrxamjad/');
                    await launchUrl(url);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icon/linkedin-min.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final Uri phoneNumber =
                        Uri.parse('https://wa.me/917260004480');
                    await launchUrl(phoneNumber);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icon/whatsapp-min.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse(
                        'https://instagram.com/mrx_amjad?utm_source=qr&igshid=MzNlNGNkZWQ4Mg%3D%3D');
                    await launchUrl(url);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icon/instagram-min.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final Uri url =
                        Uri.parse('https://www.facebook.com/mrxamjad');
                    await launchUrl(url);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icon/facebook-min.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final Uri phoneNumber = Uri.parse('https://gamil.com');
                    await launchUrl(phoneNumber);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icon/gmail-min.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final Uri phoneNumber = Uri.parse('https://t.me/mrxamjad');
                    await launchUrl(phoneNumber);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icon/telegram-min.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final Uri url =
                        Uri.parse('https://www.youtube.com/@mrx_coding');
                    await launchUrl(url);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icon/youtube-min.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final Uri url =
                        Uri.parse('https://www.github.com/mrxamjad');
                    await launchUrl(url);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icon/github-min.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

// Social LinkWidget
Card SocialLinkWidget(BuildContext context,
    {String? title, icon = Icons.abc, required onTap()}) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        // width: context.percentHeight * 100,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
            // border: Border.all(color: xcolorGreenAccent, width: 2),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: const []),
        child: Column(
          children: [
            IconButton(
                onPressed: (() {}),
                icon: FaIcon(
                  icon,
                  size: 35,
                )),
            if (title != null) Text(title)
          ],
        ),
      ),
    ),
  );
}
