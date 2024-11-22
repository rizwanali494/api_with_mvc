import 'package:api_with_mvc/Controller/get_post_clr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/get_post_model.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<PostModel> posts = [];
  final postclr = PostController();

  void _getpost() async {
    final data = await postclr.getPostList();
    setState(() {
      posts = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getpost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: (posts.isEmpty)
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.blueAccent,
            backgroundColor: Colors.transparent,
          ),
        )
            : ListView.builder(
          itemCount: posts.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Text(posts[index].body),
            );
          },
        ),
      ),
    );
  }
}
