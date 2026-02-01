import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String uid;
  final String bio;
  final List followers;
  final List following;
  final String photoURL;

  const User ({
    required this.email,
    required this.username,
    required this.uid,
    required this.bio,
    required this.followers,
    required this.following,
    required this.photoURL
  });
  Map<String, dynamic> toJson() => {
    'email': email,
    'username' : username,
    'uid': uid,
    'bio': bio,
    'followers': followers,
    'following': following,
    'photoURL': photoURL
  };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot['email'], username: snapshot['username'], uid: snapshot['uid'], bio: snapshot['bio'],
        followers: snapshot['followers'], following: snapshot['following'], photoURL: snapshot['photoURL'])
  }
}