
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Error";
    try {
      if (email.isNotEmpty || password.isNotEmpty || bio.isNotEmpty || file != null){
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await _firestore.collection("users").doc(userCredential.user!.uid).set({
          'username' : username,
          'uid': userCredential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': []
        });
        res = "Successfully registered";
      }
    } catch(err) {
      res = err.toString();
    }
    return res;
  }
}