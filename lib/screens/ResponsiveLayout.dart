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
    double currentHieght = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (contex, constraints) {
        return (currentWidth < 600 ? HomePage() : DesktopLayout());
      },
    );
  }
}
