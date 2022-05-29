import 'dart:convert';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/constants.dart';
import '../models/post_interaction.dart';
import '../services/json_placeholder_api.dart';

class PostsProvider with ChangeNotifier {
  update() {}
  final _cachePosts = GetStorage("posts");

  final JsonPlaceholderApi _jsonPlaceholderApi = JsonPlaceholderApi();

  List<PostInteraction> _currentPosts = [];

  List<PostInteraction> get currentPosts {
    return _currentPosts;
  }

  Future<void> deleteAllPostsFromCache() async {
    log("Deleting posts from Cache...");
    await _cachePosts.erase();
    _currentPosts.clear();
    notifyListeners();
  }

  Future<void> updatePost(
      final int postIndex, final PostInteraction postToUpdate) async {
    _currentPosts[postIndex] = postToUpdate;

    await _writePostsToCache(_currentPosts);
    notifyListeners();
  }

  Future<void> getPostsFromApi() async {
    await _getPostsFromApi();
  }

  Future<void> _getPostsFromApi() async {
    log("Loading posts from API...");
    _currentPosts.clear();

    _currentPosts = await _jsonPlaceholderApi.getPosts();
    _writePostsToCache(_currentPosts);
    showToast("Posts loaded", Constants.darkOkColor);
    notifyListeners();
    return;
  }

  Future<void> loadPosts() async {
    if (_postsInCache()) {
      await _getPostsFromCache();
    } else {
      await _getPostsFromApi();
    }
  }

  bool _postsInCache() {
    if (_cachePosts.hasData("lastPosts")) {
      return true;
    }
    return false;
  }

  Future<void> _writePostsToCache(final List<PostInteraction> posts) async {
    await _cachePosts.remove("lastPosts");
    await _cachePosts.write("lastPosts", jsonEncode(posts));
  }

  Future<void> _getPostsFromCache() async {
    log("Loading posts from Cache...");
    _currentPosts.clear();

    final String rawPosts = await _cachePosts.read("lastPosts");

    _currentPosts = (json
            .decode(rawPosts)
            .map(
              (postInt) => PostInteraction.fromJson(
                postInt,
              ),
            )
            .toList())
        .cast<PostInteraction>();
    showToast("Posts loaded", Constants.darkOkColor);
    notifyListeners();
    return;
  }

  showToast(final String notificationText, final Color color) {
    BotToast.showText(
      text: notificationText,
      contentColor: color,
      textStyle: const TextStyle(
        fontSize: Constants.bodyFont,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
