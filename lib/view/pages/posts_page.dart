import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bl/providers/platform_provider.dart';
import '../android/post_page_android_scaffold.dart';
import '../ios/post_page_ios_scaffold.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlatformProvider platformProvider =
        Provider.of<PlatformProvider>(context, listen: false);
    final bool platformIsAndroid = platformProvider.isAndroid;

    return platformIsAndroid
        ? const PostPageScaffoldAndroid()
        : const PostPageScaffoldIos();
  }
}
