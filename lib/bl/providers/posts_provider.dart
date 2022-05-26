import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/json_placeholder_api.dart';

class PostsProvider with ChangeNotifier {
  update() {}

  final JsonPlaceholderApi _jsonPlaceholderApi = JsonPlaceholderApi();

  List<Post> _currentPosts = [];

  List<Post> get currentPosts {
    return _currentPosts;
  }

  Future<void> getPosts() async {
    _currentPosts = await _jsonPlaceholderApi.getPosts();
    notifyListeners();
  }
}
