import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/logic/storage.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
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
        String photoURL = await Storage().uploadImageToStorage("profilePics", file, false);
        await _firestore.collection("users").doc(userCredential.user!.uid).set({
          'username' : username,
          'uid': userCredential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoURL': photoURL
        });
        res = "Successfully registered";
      }
    } on FirebaseAuthException catch (err){
      if (err.code == "invalid-email"){
        res = "Invalid Email";
      } else if(err.code == "weak-password"){
        res = "Weak Password";
      }
    }
    catch(err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password
}) async {
    String res = "Some Error Occurred";
    try {
      if(email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "Successfully logged In";
      } else {
        res = "Please fill all field";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}