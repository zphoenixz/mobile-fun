import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_fun/view/ios/post_item_ios_view.dart';
import 'package:provider/provider.dart';

import '../../bl/models/post_interaction.dart';
import '../../bl/providers/posts_provider.dart';
import '../../utils/constants.dart';

class PostPageScaffoldIos extends StatefulWidget {
  const PostPageScaffoldIos({
    Key? key,
  }) : super(key: key);

  @override
  State<PostPageScaffoldIos> createState() => _PostPageScaffoldIosState();
}

class _PostPageScaffoldIosState extends State<PostPageScaffoldIos> {
  late PostsProvider _postsProvider;
  late bool _deleted;
  int? _selectedTab = 0;

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
    _deleted = false;
    await _postsProvider.getPostsFromApi();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Posts",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        leading: const SizedBox(),
        actions: [
          CupertinoButton(
            child: const Icon(
              Icons.refresh,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () async => await _reloadPosts(),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CupertinoSlidingSegmentedControl<int>(
              backgroundColor: Constants.appBarColor,
              thumbColor: Constants.mediumBlackColor,
              padding: const EdgeInsets.all(8),
              groupValue: _selectedTab,
              children: {
                0: SizedBox(
                    width: screenWidth / 4,
                    child: Text(
                      "All",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    )),
                1: SizedBox(
                  width: screenWidth / 4,
                  child: Text(
                    "Favs",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              },
              onValueChanged: (value) {
                setState(() {
                  _selectedTab = value;
                });
              },
            ),
          ),
          Selector<PostsProvider, List<PostInteraction>>(
              selector: (BuildContext context, PostsProvider postsProvider) =>
                  postsProvider.currentPosts,
              shouldRebuild: (previous, next) => true,
              builder: (context, List<PostInteraction> currentPosts, child) {
                return currentPosts.isNotEmpty
                    ? Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: _selectedTab == 0
                                ? PostItemIosView(
                                    posts: currentPosts, showFavs: false)
                                : PostItemIosView(
                                    posts: currentPosts, showFavs: true)),
                      )
                    : _deleted
                        ? Padding(
                            padding: const EdgeInsets.only(top: 150),
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
                              child: CupertinoActivityIndicator(
                                radius: 15,
                              ),
                            ),
                          );
              }),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          _postsProvider.deleteAllPostsFromCache();
          _deleted = true;
        },
        child: Container(
          color: Constants.redCancelColor,
          height: 70,
          padding: const EdgeInsets.only(bottom: 15),
          child: Center(
              child: Text(
            'Delete All',
            style: Theme.of(context).textTheme.displayMedium,
          )),
        ),
      ),
    );
  }
}
