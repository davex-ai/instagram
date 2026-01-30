import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/firebase_options.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';
import 'package:instagram/responsive/web_screen_layout.dart';
import 'package:instagram/screens/login.dart';
import 'package:instagram/utils/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor
        ),
        home: Login(),
        // home: const ResponsiveLayout(
        //   webScreenLayout: WebScreenLayout(),
        //   mobileScreenLayout: MobileScreenLayout(),
        // ),
    );
  }
}