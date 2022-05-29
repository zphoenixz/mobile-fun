import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import './core/routes/routes.dart';
import 'bl/models/enums/auth_status.dart';
import 'bl/providers/auth_provider.dart';
import 'bl/providers/author_provider.dart';
import 'bl/providers/comments_provider.dart';
import 'bl/providers/platform_provider.dart';
import 'bl/providers/posts_provider.dart';
import 'core/theme/custom_theme.dart';
import 'view/pages/home_page.dart';
import 'view/pages/posts_page.dart';

Future<void> main() async {
  await _init();
  runApp(const MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("posts");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlatformProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, PostsProvider>(
          create: (ctx) => PostsProvider(),
          update: (ctx, authProvider, prevPostsProvider) =>
              prevPostsProvider!..update(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CommentsProvider(),
        ),
      ],
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        onGenerateRoute: NavigationRoute.instance.generateRoute,
        supportedLocales: const [Locale('en', 'US')],
        theme: CustomTheme.lightTheme,
        home: Selector<AuthProvider, AuthStatus>(
          selector: (BuildContext context, AuthProvider authProvider) =>
              authProvider.authStatus,
          builder: (context, AuthStatus authStatus, child) {
            return authStatus != AuthStatus.loggedIn
                ? const HomePage()
                : const PostsPage();
          },
        ),
      ),
    );
  }
}
