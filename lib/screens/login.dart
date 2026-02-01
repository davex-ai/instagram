import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:instagram/logic/authentication.dart";
import "package:instagram/responsive/mobile_screen_layout.dart";
import "package:instagram/responsive/responsive_layout_screen.dart";
import "package:instagram/responsive/web_screen_layout.dart";
import "package:instagram/screens/signup.dart";
import "package:instagram/utils/color.dart";
import "package:instagram/utils/utils.dart";
import "package:instagram/widget/text_input.dart";

class Login extends StatefulWidget {
  const Login ({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loaded = false;

  @override
  void dispose() {

    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void ToSignUpScreen() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUp()));
  }
  
  void loginUser() async {
    setState(() {
      _loaded = true;
    });
    String response = await Authentication().loginUser(email: _emailController.text, password: _passwordController.text);
    if(response == "Successfully logged In"){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout()
          )));
    } else {
      showSnackBar(response, context);
    }
    setState(() {
      _loaded = false;
    });
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
                TextInput(textEditingController: _emailController, hintText: "Enter your email", textInputType: TextInputType.emailAddress),
                const SizedBox(height: 24,),
                TextInput(textEditingController: _passwordController, hintText: "Enter your password", textInputType: TextInputType.text, isPass: true),
                const SizedBox(height: 24,),
                InkWell(
                  onTap: loginUser,
                  child: Container(
                  child: _loaded ? const Center(
                    child: CircularProgressIndicator( color: primaryColor,),
                  ) : const Text("Log In"),
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
                      onTap: ToSignUpScreen,
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