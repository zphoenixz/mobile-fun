import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bl/models/post_interaction.dart';
import '../../bl/providers/platform_provider.dart';
import '../../bl/providers/posts_provider.dart';
import '../../utils/constants.dart';
import '../widgets/post_comments.dart';
import '../widgets/post_author.dart';

class PostDetailsPage extends StatefulWidget {
  const PostDetailsPage({
    required this.postIndex,
    Key? key,
  }) : super(key: key);

  final int postIndex;

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  late PostsProvider _postsProvider;
  late PlatformProvider _platformProvider;

  late PostInteraction _currentPost;
  late ScrollController _postDetailsScrollController;

  @override
  void initState() {
    _postsProvider = Provider.of<PostsProvider>(context, listen: false);
    _platformProvider = Provider.of<PlatformProvider>(context, listen: false);

    _currentPost = _postsProvider.currentPosts[widget.postIndex];
    _postDetailsScrollController = ScrollController();
    _setPostRead();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _currentPost = _postsProvider.currentPosts[widget.postIndex];
    super.didChangeDependencies();
  }

  _setPostRead() async {
    PostInteraction modifiedPost = _currentPost;
    modifiedPost.seenByUser = true;
    await _postsProvider.updatePost(widget.postIndex, modifiedPost);
  }

  _setFavUpdate() async {
    PostInteraction modifiedPost = _currentPost;
    modifiedPost.favByUser = !modifiedPost.favByUser;
    await _postsProvider.updatePost(widget.postIndex, modifiedPost);
    !modifiedPost.favByUser
        ? _showToast("Removed from favs", Constants.redFavColor)
        : _showToast("Added to favs", Constants.redFavColor);
  }

  _showToast(final String notificationText, final Color color) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: _platformProvider.isAndroid
            ? Constants.lightBlackColor
            : Colors.transparent,
        actions: [
          _platformProvider.isAndroid
              ? IconButton(
                  iconSize: 30,
                  icon: !_currentPost.favByUser
                      ? const Icon(
                          Icons.star_border,
                        )
                      : const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                  onPressed: () async {
                    await _setFavUpdate();
                    setState(() {});
                  },
                )
              : CupertinoButton(
                  child: !_currentPost.favByUser
                      ? const Icon(
                          Icons.star_border,
                          color: Colors.white,
                          size: 30,
                        )
                      : const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        ),
                  onPressed: () async {
                    await _setFavUpdate();
                    setState(() {});
                  },
                ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _postDetailsScrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10,
              ),
              child: Text(
                "Description",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                left: 10.0,
                right: 10,
              ),
              child: Text(
                _currentPost.post.body,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
            ),
            PostAuthor(authorId: _currentPost.post.userId),
            PostComments(
              postId: _currentPost.post.id,
              postDetailsScrollController: _postDetailsScrollController,
            )
          ],
        ),
      ),
    );
  }
}
