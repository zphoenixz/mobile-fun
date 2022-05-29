import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/author.dart';
import '../models/comment.dart';
import '../models/post.dart';
import '../models/post_interaction.dart';

class JsonPlaceholderApi {
  final String _getPostsPath = "https://jsonplaceholder.typicode.com/posts";
  String _getPostPath(int postId) =>
      'https://jsonplaceholder.typicode.com/posts/$postId';
  String _getPostCommentsPath(int postId) => '${_getPostPath(postId)}/comments';

  final String _getAuthorsPath = "https://jsonplaceholder.typicode.com/users";
  String _getAuthorPath(int authorId) => '$_getAuthorsPath/$authorId';

  Future<List<PostInteraction>> getPosts() async {
    log("** Getting posts from jsonplaceholder.typicode.com");
    try {
      final response = await http.get(Uri.parse(_getPostsPath));

      return (json
              .decode(response.body)
              .map(
                (post) => PostInteraction(
                  favByUser: false,
                  seenByUser: false,
                  post: Post.fromJson(post),
                ),
              )
              .toList())
          .cast<PostInteraction>();
    } catch (e, s) {
      log("** Error when fetching posts from jsonplaceholder.typicode.com");
      log(e.toString());
      log(s.toString());
      return <PostInteraction>[];
    }
  }

  Future<dynamic> getAuthor(int authorId) async {
    log("** Getting author from jsonplaceholder.typicode.com");
    try {
      final response = await http.get(Uri.parse(_getAuthorPath(authorId)));

      return Author.fromJson(json.decode(response.body));
    } catch (e, s) {
      log("** Error when fetching author from jsonplaceholder.typicode.com");
      log(e.toString());
      log(s.toString());
      return null;
    }
  }

  Future<List<Comment>> getPostComments(int postId) async {
    log("** Getting post comments from jsonplaceholder.typicode.com");
    try {
      final response = await http.get(Uri.parse(_getPostCommentsPath(postId)));

      return (json
              .decode(response.body)
              .map(
                (comment) => Comment.fromJson(comment),
              )
              .toList())
          .cast<Comment>();
    } catch (e, s) {
      log("** Error when fetching post comments from jsonplaceholder.typicode.com");
      log(e.toString());
      log(s.toString());
      return <Comment>[];
    }
  }
}
