import 'package:flutter/material.dart';

import '../../bl/models/post_interaction.dart';
import '../../core/routes/routing_constants.dart';
import '../../utils/constants.dart';

class PostItemAndroidView extends StatelessWidget {
  const PostItemAndroidView({
    Key? key,
    required this.posts,
    required this.showFavs,
  }) : super(key: key);

  final List<PostInteraction> posts;
  final bool showFavs;

  @override
  Widget build(BuildContext context) {
    final postsToShow = showFavs == true
        ? posts.where((post) => post.favByUser).toList()
        : posts;

    return ListView.separated(
      shrinkWrap: true,
      // controller: scrollProvider.postPageScrollController,
      padding: const EdgeInsets.all(8),
      itemCount: postsToShow.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          tileColor: Constants.lightGrayColor,
          onTap: () {
            Navigator.pushNamed(
              context,
              postDescriptionPageRoute,
              arguments: index,
            );
          },
          leading: postsToShow[index].seenByUser
              ? const SizedBox()
              : const Icon(
                  Icons.circle,
                  size: 15,
                  color: Colors.blue,
                ),
          title: Text(
            postsToShow[index].post.title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: !postsToShow[index].favByUser
              ? const SizedBox()
              : const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Constants.mediumBlackColor,
        height: 4,
      ),
    );
  }
}
