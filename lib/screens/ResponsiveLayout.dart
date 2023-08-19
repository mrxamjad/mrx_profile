import 'package:flutter/material.dart';
import 'package:mrx_profile/screens/DesktopLayout.dart';

import 'package:mrx_profile/screens/MobileLayout.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    double currentHieght =
        double.parse(MediaQuery.of(context).size.height.toString());
    double currentWidth =
        double.parse(MediaQuery.of(context).size.width.toString());
    return LayoutBuilder(
      builder: (contex, constraints) {
        return (currentWidth.toDouble() < 600.0.toDouble()
            ? HomePage()
            : DesktopLayout());
      },
    );
  }
}
