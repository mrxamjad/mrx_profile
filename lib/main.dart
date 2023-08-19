import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mrx_profile/screens/MobileLayout.dart';
import 'package:mrx_profile/screens/ResponsiveLayout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: "AIzaSyApAkdUH0ZuuFTzXnh0C0D7eMfOEP69nZY",
      //     appId: "1:853570329104:web:34f1251bd8b798a9cf0895",
      //     messagingSenderId: "853570329104",
      //     projectId: "profile-724e1")
      );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mrx Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveLayout(),
    );
  }
}
