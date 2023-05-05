import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

//Redirect the user to user profile

Future<void> goToWebPage(String urlString) async {
  final Uri _url = Uri.parse(urlString);
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

SizedBox SocialNewtwork(BuildContext context) {
  return SizedBox(
    child: Container(
      width: context.percentHeight * 100,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SocialLinkWidget(
                  context,
                  icon: FontAwesomeIcons.github,
                  onTap: () async {
                    print("printed");
                    await goToWebPage("https://flutter.dev");
                    print("printed");
                  },
                ),
                SocialLinkWidget(
                  context,
                  icon: FontAwesomeIcons.linkedinIn,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
                ),
                SocialLinkWidget(
                  context,
                  icon: FontAwesomeIcons.instagram,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
                ),
                SocialLinkWidget(
                  context,
                  icon: FontAwesomeIcons.facebook,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
                ),
                SocialLinkWidget(
                  context,
                  icon: FontAwesomeIcons.googlePlus,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
                ),
                SocialLinkWidget(
                  context,
                  icon: FontAwesomeIcons.telegram,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
                ),
                SocialLinkWidget(
                  context,
                  icon: FontAwesomeIcons.whatsapp,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
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
