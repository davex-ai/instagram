import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/profile.dart';
import 'package:instagram/utils/color.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _search = TextEditingController();
  bool showRes = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _search.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _search,
          decoration: const InputDecoration(labelText: 'Search...'),
          onFieldSubmitted: (String l) {
            setState(() {
              showRes = true;
            });
          },
        ),
      ),
      body: showRes
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username', isGreaterThanOrEqualTo: _search.text)
                  .get(),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: (snap.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            uid: (snap.data! as dynamic).docs[index]['uid'],
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            (snap.data! as dynamic).docs[index]['photoUrl'],
                          ),
                        ),
                        title: Text(
                          (snap.data! as dynamic).docs[index]['username'],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final posts = (snapshot.data! as dynamic).docs;
                return StaggeredGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: List.generate(posts.length, (index) {
                    return StaggeredGridTile.count(
                      crossAxisCellCount: (index % 7 == 0) ? 2 : 1,
                      mainAxisCellCount: (index % 7 == 0) ? 2 : 1,
                      child: Image.network(
                        posts[index]['postUrl'],
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                );
              },
            ),
    );
  }
}
