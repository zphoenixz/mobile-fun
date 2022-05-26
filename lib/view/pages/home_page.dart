import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bl/providers/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).login();
    });

    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          "Hi I am the homepage XD, I have no use atm,"
          " so in a bit you will be redirected just wait :D ",
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
