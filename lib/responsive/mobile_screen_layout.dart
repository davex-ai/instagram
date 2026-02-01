import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/models/user.dart';
import 'package:flutter/material.dart';
import 'package:instagram/providers/user.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: Text('mobile'),
      ),
    );
  }
}
