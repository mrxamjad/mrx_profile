import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

//Redirect the user to user profile

Future<void> goToWebPage(String urlString) async {
  final Uri _url = Uri.parse(urlString);
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

SizedBox SocialNewtwork() {
  return SizedBox(
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SocialLinkWidget(
                  icon: FontAwesomeIcons.github,
                  onTap: () async {
                    print("printed");
                    await goToWebPage("https://flutter.dev");
                    print("printed");
                  },
                ),
                SocialLinkWidget(
                  icon: FontAwesomeIcons.linkedinIn,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
                ),
                SocialLinkWidget(
                  icon: FontAwesomeIcons.instagram,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
                ),
                SocialLinkWidget(
                  icon: FontAwesomeIcons.facebook,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
                ),
                SocialLinkWidget(
                  icon: FontAwesomeIcons.googlePlus,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
                ),
                SocialLinkWidget(
                  icon: FontAwesomeIcons.telegram,
                  onTap: () async {
                    await goToWebPage("https://flutter.dev");
                  },
                ),
                SocialLinkWidget(
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
Card SocialLinkWidget({String? title, icon = Icons.abc, required onTap()}) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
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
