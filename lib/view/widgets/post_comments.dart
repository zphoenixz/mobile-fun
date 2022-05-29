import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bl/models/comment.dart';
import '../../bl/providers/comments_provider.dart';
import '../../bl/providers/platform_provider.dart';
import '../../utils/constants.dart';

class PostComments extends StatefulWidget {
  const PostComments(
      {Key? key,
      required this.postId,
      required this.postDetailsScrollController})
      : super(key: key);

  final int postId;
  final ScrollController postDetailsScrollController;

  @override
  State<PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  late CommentsProvider _commentsProvider;
  late PlatformProvider _platformProvider;

  @override
  void initState() {
    _commentsProvider = Provider.of<CommentsProvider>(context, listen: false);
    _platformProvider = Provider.of<PlatformProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            color: Constants.lightBlackColor,
            child: Text(
              "COMMENTS",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        FutureBuilder<List<Comment>>(
            future: _commentsProvider.loadPostComments(
                widget.postId), // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
              if (snapshot.hasData) {
                List<Comment>? postComments = snapshot.data;

                return ListView.separated(
                  controller: widget.postDetailsScrollController,
                  shrinkWrap: true,
                  itemCount: postComments!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Constants.lightGrayColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        postComments[index].body,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    color: Constants.mediumBlackColor,
                    height: 4,
                  ),
                );
              }
              return Center(
                child: _platformProvider.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(
                        radius: 15,
                      ),
              );
            })
      ],
    );
  }
}
