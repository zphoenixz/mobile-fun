import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bl/models/post_interaction.dart';
import '../../bl/providers/posts_provider.dart';
import '../../utils/constants.dart';
import 'post_item_android_view.dart';

class PostPageScaffoldAndroid extends StatefulWidget {
  const PostPageScaffoldAndroid({
    Key? key,
  }) : super(key: key);

  @override
  State<PostPageScaffoldAndroid> createState() =>
      _PostPageScaffoldAndroidState();
}

class _PostPageScaffoldAndroidState extends State<PostPageScaffoldAndroid> {
  late PostsProvider _postsProvider;
  late bool _deleted;

  @override
  void initState() {
    _postsProvider = Provider.of<PostsProvider>(context, listen: false);
    _deleted = false;
    _loadPosts();
    super.initState();
  }

  _loadPosts() async {
    await _postsProvider.loadPosts();
  }

  _reloadPosts() async {
    await _postsProvider.getPostsFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Text(
                  "All",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Favs",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Posts",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              IconButton(
                iconSize: 30,
                icon: const Icon(
                  Icons.refresh,
                  size: 30,
                ),
                onPressed: () async => await _reloadPosts(),
              )
            ],
          ),
          body: Selector<PostsProvider, List<PostInteraction>>(
            selector: (BuildContext context, PostsProvider postsProvider) =>
                postsProvider.currentPosts,
            shouldRebuild: (previous, next) => true,
            builder: (context, List<PostInteraction> currentPosts, child) {
              return currentPosts.isNotEmpty
                  ? TabBarView(children: [
                      PostItemAndroidView(posts: currentPosts, showFavs: false),
                      PostItemAndroidView(posts: currentPosts, showFavs: true),
                    ])
                  : _deleted
                      ? Center(
                          child: Text(
                            "Refresh to get new Posts...",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        )
                      : const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        );
            },
          ),
          floatingActionButton: CircleAvatar(
            radius: 30,
            backgroundColor: Constants.redCancelColor,
            child: IconButton(
              iconSize: 30,
              color: Colors.white,
              icon: const Icon(
                Icons.delete,
              ),
              onPressed: () async {
                _postsProvider.deleteAllPostsFromCache();
                _deleted = true;
              },
            ),
          )),
    );
  }
}
