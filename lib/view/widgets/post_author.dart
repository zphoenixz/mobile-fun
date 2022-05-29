import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bl/models/author.dart';
import '../../bl/providers/author_provider.dart';
import '../../bl/providers/platform_provider.dart';

class PostAuthor extends StatefulWidget {
  const PostAuthor({
    Key? key,
    required this.authorId,
  }) : super(key: key);

  final int authorId;

  @override
  State<PostAuthor> createState() => _PostAuthorState();
}

class _PostAuthorState extends State<PostAuthor> {
  late AuthorProvider _authorProvider;
  late PlatformProvider _platformProvider;

  @override
  void initState() {
    _authorProvider = Provider.of<AuthorProvider>(context, listen: false);
    _platformProvider = Provider.of<PlatformProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Author>(
        future: _authorProvider.loadAuthor(
            widget.authorId), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Author> snapshot) {
          if (snapshot.hasData) {
            Author? postAuthor = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 10.0,
                    right: 10,
                  ),
                  child: Text(
                    "User",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    left: 10.0,
                    right: 10,
                  ),
                  child: Text(
                    postAuthor!.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    left: 10.0,
                    right: 10,
                  ),
                  child: Text(
                    postAuthor.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    left: 10.0,
                    right: 10,
                  ),
                  child: Text(
                    postAuthor.phone,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    left: 10.0,
                    right: 10,
                  ),
                  child: Text(
                    postAuthor.website,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            );
          }

          return Center(
            child: _platformProvider.isAndroid
                ? const CircularProgressIndicator()
                : const CupertinoActivityIndicator(
                    radius: 15,
                  ),
          );
          ;
        });
  }
}
