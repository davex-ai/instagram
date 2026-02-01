import 'package:flutter/material.dart';
import 'package:instagram/logic/firestoreMethods.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/providers/user.dart';
import 'package:instagram/utils/color.dart';
import 'package:instagram/widget/comment_card.dart';
import 'package:provider/provider.dart';

class Comment extends StatefulWidget {
  final snap;
  const Comment({super.key, required this.snap});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comment'),
        centerTitle: false,
      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL),
                radius: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await Firestoremethods().postComment(
                    widget.snap['postId'],
                    widget.snap['text'],
                    user.uid,
                    user.username,
                    user.photoURL,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: const Text('Post', style: TextStyle(color: blueColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
