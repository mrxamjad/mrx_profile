// Hire me Section

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

Container HireMeSection(BuildContext context) {
  return Container(
    width: 300,
    child: Stack(
      children: [
        Lottie.network(
            fit: BoxFit.cover,
            'https://assets10.lottiefiles.com/packages/lf20_CR23KK4W5R.json'),
        const Text(
            "Hire Me for Java, web Development and also for flutter developer"),
        Column(
          children: [
            // Text("context.isLandscape:${context.isLandscape}"),
            Text("context.mdColumns:${context.mdColumns}"),
            Text(" context.mdGutter:${context.mdGutter} "),
            Text("context.mdDeviceType:${context.mdDeviceType}"),
            Text(" context.mdDeviceSize:${context.mdDeviceSize}"),
            Text(" context.mdWindowSize:${context.mdWindowSize}"),
            Text("context.isMobile:${context.isMobile}"),
            Text("context.screenWidth:${context.screenWidth}"),
            Text("context.percentWidth:${context.percentWidth}"),
            Text("context.safePercentWidth:${context.safePercentWidth}"),

            const VxDevice(mobile: Text("Hi Mobile"), web: Text("Hi Web")),
            const VxResponsive(
              xsmall: Text("Hi Extra Small"),
              small: Text("Hi Small"),
              medium: Text("Hi Medium"),
              large: Text("Hi Large"),
              xlarge: Text("Hi Extra Large"),
              fallback: Text("Hi Nothing Specified"),
            ),
            VxLayout(
              builder: (context, size, _) {
                return ElevatedButton(
                  onPressed: () {},
                  child: size.toString().text.make(),
                ).w(200).p16();
              },
            ),
            Text("context.mq:${context.mq}"),
          ],
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
        )
      ],
    ),
  );
}
