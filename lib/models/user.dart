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
}