
import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {
 
  bool _loggedIn = false;

  bool get isLoggedIn => _loggedIn;
  

  login() {
    _loggedIn = true;
    notifyListeners();
  }

  
  void logout() {
    _loggedIn = false;
    notifyListeners();
  }
}
