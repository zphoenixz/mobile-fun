import 'dart:convert';

import 'package:mobile_fun/bl/models/post.dart';

PostInteraction postFromJson(String str) =>
    PostInteraction.fromJson(json.decode(str));

String postToJson(PostInteraction data) => json.encode(data.toJson());

class PostInteraction {
  PostInteraction({
    required this.seenByUser,
    required this.favByUser,
    required this.post,
  });

  bool seenByUser;
  bool favByUser;
  final Post post;

  factory PostInteraction.fromJson(Map<String, dynamic> json) =>
      PostInteraction(
        seenByUser: json["seenByUser"],
        favByUser: json["favByUser"],
        post: Post.fromJson(json["post"]),
      );

  Map<String, dynamic> toJson() => {
        "seenByUser": seenByUser,
        "favByUser": favByUser,
        "post": post.toJson(),
      };
}
