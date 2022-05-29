import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:mobile_fun/view/pages/home_page.dart';
import '../../view/pages/posts_page.dart';
import '../../view/pages/post_details_page.dart';
import 'routing_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case homePageRoute:
        log('loading $homePageRoute route..');
        return MaterialPageRoute(builder: (context) => const HomePage());
      case postsPageRoute:
        log('loading $postsPageRoute route..');
        return MaterialPageRoute(builder: (context) => const PostsPage());
      case postDescriptionPageRoute:
        log('loading $postDescriptionPageRoute route..');

        return MaterialPageRoute(
            builder: (context) => PostDetailsPage(
                  postIndex: int.parse(args.arguments.toString()),
                ));
      default:
        log('loading default $homePageRoute route..');
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
