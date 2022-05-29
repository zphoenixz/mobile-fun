import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/author.dart';
import '../services/json_placeholder_api.dart';

class AuthorProvider with ChangeNotifier {
  update() {}
  // final _cachePosts = GetStorage("authors");

  final JsonPlaceholderApi _jsonPlaceholderApi = JsonPlaceholderApi();

  late Author _postAuthor;

  Author get postAuthor {
    return _postAuthor;
  }

  Future<Author> loadAuthor(int authorId) async {
    _postAuthor = await _getAuthorFromApi(authorId);
    return _postAuthor;
  }

  Future<Author> _getAuthorFromApi(int authorId) async {
    log("Loading Author from API...");
    return await _jsonPlaceholderApi.getAuthor(authorId);
  }
}
