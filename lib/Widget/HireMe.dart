// Hire me Section

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mrx_profile/Widget/HeadingTitle.dart';
import 'package:mrx_profile/Widget/drawer.dart';
import 'package:velocity_x/velocity_x.dart';

Container HireMeSection(BuildContext context) {
  return Container(
    child: Stack(
      children: [
        Lottie.network(
            fit: BoxFit.cover,
            'https://assets10.lottiefiles.com/packages/lf20_CR23KK4W5R.json'),
        VxLayout(
          builder: (context, size, _) {
            return ElevatedButton(
              onPressed: () {},
              child: size.toString().text.make(),
            ).w(200).p16();
          },
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: HeadingTitle(
                  title: "Our works that done passionly and beautifuly"),
            ),
            Wrap(
              children: [
                VxSwiper.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Stack(
                        children: [
                          Container()
                          // Lottie.network()
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        )
      ],
    ),
  );
}
