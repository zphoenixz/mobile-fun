import 'package:flutter/material.dart';
import 'package:mobile_fun/bl/providers/posts_provider.dart';
import 'package:mobile_fun/bl/models/post.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late PostsProvider _postsProvider;

  @override
  void initState() {
    _postsProvider = Provider.of<PostsProvider>(context, listen: false);
    getPosts();
    super.initState();
  }

  Future<void> getPosts() async {
    _postsProvider.getPosts();
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
              IconButton(
                iconSize: 30,
                icon: const Icon(
                  Icons.refresh,
                ),
                onPressed: () {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        body: Selector<PostsProvider, List<Post>>(
          selector: (BuildContext context, PostsProvider postsProvider) =>
              postsProvider.currentPosts,
          shouldRebuild: (previous, next) => true,
          builder: (context, List<Post> currentPosts, child) {
            print("11================================");
            print(currentPosts.length);
            print("22================================");
            return Container();
            // return authStatus != AuthStatus.loggedIn
            //     ? const HomePage()
            //     : const PostPage();
          },
        ),
      ),
    );
  }
}
