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

  Future<void> likePost(String postId, String uid, List likes) async {
    try{
      if(likes.contains(uid)){
        await _firestore.collection('posts').doc(postId).update({
          'likes' : FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      }
    }catch (err) {

    }
  }

  Future<void> postComment(String postId, String text, String uid, String name, String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now()
        });
      } else {
        print('Enter a Text');
      }
    }catch(e){
      print(e.toString());
    }
  }
  }