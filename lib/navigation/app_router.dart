import 'package:flutter/material.dart';
import 'package:myubuntu/screens/signup_screen.dart';

import '../models/models.dart';
import '../screens/screens.dart';


class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;
  final PassManager passManager;
  

  AppRouter({
    required this.appStateManager,
    required this.passManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    passManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    passManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      // 8
      pages: [
        if (appStateManager.isLoggedIn ==false) LoginScreen.page(),
        if (appStateManager.isSignedup == true) SignUpScreen.page(),
        // if (appStateManager.isLoggedIn == false && appStateManager.isSignedup == true) SignUpScreen.page(),
        if (appStateManager.isLoggedIn == true) Home.page(),
        if (passManager.isCreatingNewItem)
          PassItemScreen.page(onCreate: (item) {
            passManager.addItem(item);
          }, onUpdate: (item, index) {

          }),
        if (passManager.selectedIndex != -1)
          PassItemScreen.page(
              item: passManager.selectedpassItem,
              index: passManager.selectedIndex,
              onUpdate: (item, index) {
                passManager.updateItem(item, index);
              },
              onCreate: (_) {
              }),
      ],
    );
  }

  bool _handlePopPage(
      Route<dynamic> route,
      result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == FooderlichPages.passItemDetails) {
      passManager.passItemTapped(-1);
    }

    if (route.settings.name == FooderlichPages.signupPath) {
      appStateManager.signupout();

    }

    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
