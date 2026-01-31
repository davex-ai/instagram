import "dart:typed_data";

import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import "package:image_picker/image_picker.dart";
import "package:instagram/logic/authentication.dart";
import "package:instagram/utils/color.dart";
import "package:instagram/utils/utils.dart";
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
  Uint8List? _image;
  bool _loaded = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
  _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _loaded = true;
    });
    String response = await Authentication()
        .signUpUser(email: _emailController.text, password: _passwordController.text,
        username: _usernameController.text, bio: _bioController.text, file: _image!);
    setState(() {
      _loaded = false;
    });
    if (response != 'Successfully registered'){
      showSnackBar(response, context);
    }
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
                      _image != null ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      ):
                      const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage("data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAmgMBIgACEQEDEQH/xAAbAAEBAAMBAQEAAAAAAAAAAAAABgEEBQMCB//EADoQAAICAQICBAsGBgMAAAAAAAABAgMEBREhMRJBUXEGEyIyUmGRkqHB0RQVI0Kx8FRygaLh8UNic//EABUBAQEAAAAAAAAAAAAAAAAAAAAB/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A/cAAAAAAAAADzvvrx6nZdJRiutgegJ/K16cm1i1qK9KfF+w1HrGc3v45LuigKsE1RruTB/jRhZHu2Z28LOpzIb1NqS5wlzQG0AAAAAAAAAAAAAAAAAADaS3fBIktUzXm5Dab8VHhCPzO9rdzp06xxezn5C/qSgAAFQPTHunj3Rtqe04/E8wBaYeRHKxoXQ5SXFdj7D2OF4NWv8ah8uEl8/kd0igAAAAAAAAAAAAAAAOR4S7/AGOr/wBPkycKjX6/GafJpbuuSl+/aS5QAAQAAHU8Hd/t77HW/wBUUxP+DNe9t1vUoqKff/ooCKAAAAAAAAAAAAAAAA+bIRshKElvGS2ZHZmNPEyJUz6uT7V1MszWz8KrNq6FqakvNkuaAjgb+TpGXQ30a/Gw6nXxfsNR0XJ7OmxPscGVHmZinKSjFbtvZJdZs0admXvyKJxXbNdFfE72maVDDfjLGp3du3Bd31Ir30zEWJiRr/Pzm/WbYAAAAAAAAAAAAAAAB55F9ePU7LpKMUT2drd9rccb8KHb+Z/QCguyKaFvdZGH8zNOzWsGD26cpfywZLSblJyk25PrfMwBT/fuH2W+6vqY+/cPsu91fUmgBTLXcN/lt91fUzHXMJvi7I98CX4mQLGjPxb3tVfByfKLez9jNkherY3cPU8nFa6M+nX6E/3wArQaeBqNGatoPo2bcYPmbgAAAAAAAAA+LrYUVTtse0Irds+zi+EtzjVTSn57cpbeoDkZ+ZZm3uc+EU/Ij1RX1NYAqAAAAAAAAAAA+oTlXNThJxlHimuoqtKzvttHlbK2HCaX6kmb+h2urUa1v5M04v5fEiqsAAAAAAAAmfCKfSz4x6owXxKYktal0tUyPU0v7UBpAAqAAAAAAAAAAAHriz8Xk0z9GafxPIPk9uwC6BiL6UU+1bmSKAAAAABJawttTyN+1foitONrmm2XyWRjrpTS2lDrfrAngZfBtPmjBUAAAAAAAAAAAMS5MydDScCeVdGcltTF7uXpepAVEFtBJ80kj6CBFAAAAAAAAauXp+Nl8ba/K9KPBnIyPB+2Lbx7YyXZPgyhAEfbp2ZT52PNrtiukvga0oyi9pRafrWxcmHFS85J96AhufIyWc8TGn5+PTLvgj4+78L+Fp9xFEeYLH7vwv4Wn3EfcMXHh5lFUe6CAjoVWWPauuc3/wBYtm5RpGbb/wAXi12zexVJJcFw7jJBycTQqa2pZEnbLs5R/wAnUjFQioxSUVwSXJH0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/Z"),
                      ),
                      Positioned(bottom: -10, left: 80, child: IconButton(onPressed: selectImage, icon: const Icon( Icons.add_a_photo)))
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
                    onTap: signUpUser,
                    child: Container(
                      child: _loaded
                          ? const Center(
                        child: CircularProgressIndicator( color: primaryColor,),
                      )   : const Text("Sign Up"),
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