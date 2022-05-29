import 'package:flutter/material.dart';

import '../../bl/models/post_interaction.dart';
import '../../core/routes/routing_constants.dart';
import '../../utils/constants.dart';

class PostItemIosView extends StatelessWidget {
  const PostItemIosView({
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

    return Center(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: postsToShow.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            enableFeedback: false,
            tileColor: Constants.lightGrayColor,
            onTap: () {
              Navigator.pushNamed(
                context,
                postDescriptionPageRoute,
                arguments: index,
              );
            },
            leading: postsToShow[index].seenByUser
                ? postsToShow[index].favByUser
                    ? const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    : const SizedBox()
                : const Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.blue,
                  ),
            title: Text(
              postsToShow[index].post.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Constants.mediumBlackColor,
          height: 4,
        ),
      ),
    );
  }
}
