import 'package:flutter/material.dart';
import 'package:instagram/logic/authentication.dart';
import 'package:instagram/models/user.dart';

class UserProvider with ChangeNotifier{
  User? _user;
  final Authentication _authMethods = Authentication();

  User get getUser => _user!;

  Future<void> refereshUser() async {
     User user = await _authMethods.getUserDetails();
     _user = user;
     notifyListeners();
  }
}