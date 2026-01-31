import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:instagram/utils/color.dart";

class Login extends StatefulWidget {
  const Login ({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/ic_instagram.svg", color : primaryColor, height: 64,),
                const SizedBox(height: 64,)
              ],
            ),
      ))
    );
  }
}