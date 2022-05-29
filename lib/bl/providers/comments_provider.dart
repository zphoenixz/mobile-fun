import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/comment.dart';
import '../services/json_placeholder_api.dart';

class CommentsProvider with ChangeNotifier {
  update() {}
  // final _cachePosts = GetStorage("authors");

  final JsonPlaceholderApi _jsonPlaceholderApi = JsonPlaceholderApi();

  late List<Comment> _postComments;

  List<Comment> get postComments {
    return _postComments;
  }

  Future<List<Comment>> loadPostComments(int postId) async {
    _postComments = await _getPostCommentsFromApi(postId);
    return _postComments;
  }

  Future<List<Comment>> _getPostCommentsFromApi(int postId) async {
    log("Loading Author from API...");
    return await _jsonPlaceholderApi.getPostComments(postId);
  }
}
