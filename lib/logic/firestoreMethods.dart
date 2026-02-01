import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/logic/storage.dart';
import 'package:instagram/models/post.dart';
import 'package:uuid/uuid.dart';


class Firestoremethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost (String description, Uint8List file, String uid, String username, String profImage) async {

    String response = 'Error';
    try{
      String photoURL = await Storage().uploadImageToStorage('post', file, true);
      String postId = const Uuid().v1();
      Post post = Post(description: description, username: username, uid: uid, postId: postId, datePublished: DateTime.now() , postUrl: photoURL, postImage: profImage, likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());
      response = 'success';
    }catch(e) {
response = e.toString();
    }
    return response;
  }
}