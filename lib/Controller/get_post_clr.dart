import 'dart:convert';

import 'package:api_with_mvc/Models/get_post_model.dart';
import 'package:http/http.dart' as http;

class PostController {
  List<PostModel> postlist = [];

  Future<List<PostModel>> getPostList() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      postlist = data.map((post) => PostModel.fromJson(post)).toList();
      print("Fetched ${postlist.length} posts.");
      return postlist;
    } else {
      print("Response Status Code is not 200.");
      return [];
    }
  }
}
