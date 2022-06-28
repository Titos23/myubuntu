import 'package:flutter/material.dart';
import 'package:myubuntu/screens/screens.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';


class Home extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: FooderlichPages.home,
      key: ValueKey(FooderlichPages.home),
      child: Home(),
    );
  }

  const Home({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (
        context,
        appStateManager,
        child,
      ) {
        return PassScreen();
      },
    );
  }
}