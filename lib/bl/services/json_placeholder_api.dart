import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class JsonPlaceholderApi {
  final String _getPostsPath = "https://jsonplaceholder.typicode.com/posts";
  String _getPostPath(String postId) =>
      'https://jsonplaceholder.typicode.com/post/$postId';
  String _getPostCommentsPath(String postId) =>
      '${_getPostPath(postId)}/comments';

  Future<List<Post>> getPosts() async {
    log("** Getting posts from jsonplaceholder.typicode.com");
    try {
      final response = await http.get(Uri.parse(_getPostsPath));

      return (json
              .decode(response.body)
              .map((post) => Post.fromJson(post))
              .toList())
          .cast<Post>();
    } catch (e, s) {
      log("** Error when fetching posts  from jsonplaceholder.typicode.com");
      log(e.toString());
      return <Post>[];
    }
  }
}
