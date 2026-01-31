import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import "package:instagram/utils/color.dart";
import "package:instagram/widget/text_input.dart";


class SignUp extends StatefulWidget {
  const SignUp ({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }
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
                  Flexible(child: Container(), flex: 2,),
                  SvgPicture.asset("assets/ic_instagram.svg", color : primaryColor, height: 64,),
                  const SizedBox(height: 64,),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(" "),
                      ),
                      Positioned(bottom: -10, left: 80, child: IconButton(onPressed: () {}, icon: const Icon( Icons.add_a_photo)))
                    ],
                  ),
                  const SizedBox(height: 24,),
                  TextInput(textEditingController: _usernameController, hintText: "Enter your username", textInputType: TextInputType.text),
                  const SizedBox(height: 24,),
                  TextInput(textEditingController: _emailController, hintText: "Enter your email", textInputType: TextInputType.emailAddress),
                  const SizedBox(height: 24,),
                  TextInput(textEditingController: _passwordController, hintText: "Enter your password", textInputType: TextInputType.text, isPass: true),
                  const SizedBox(height: 24,),
                  TextInput(textEditingController: _bioController, hintText: "Enter your bio", textInputType: TextInputType.text),
                  const SizedBox(height: 24,),
                  InkWell(
                    child: Container(
                      child: const Text("Log In"),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(4),
                          )
                      ),
                          color: blueColor
                      ),
                    ),),
                  const SizedBox( height: 12,),
                  Flexible(child: Container(), flex: 2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text("Don't have an account?"),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      GestureDetector(
                          onTap: (){},
                          child: Container(
                            child: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold),
                            ), padding: const EdgeInsets.symmetric(vertical: 8),
                          ))],
                  )
                ],
              ),
            ))
    );
  }
}