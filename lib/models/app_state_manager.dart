
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import '../components/directory.dart';
class AppStateManager extends ChangeNotifier {
 
  bool _loggedIn = false;

  bool get isLoggedIn => _loggedIn;
  

  Future<void> init() async{
    
    requestPermission(Permission.storage);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        notifyListeners();
      } else {
        _loggedIn = false;
        notifyListeners();
      }
      notifyListeners();
    });
  } 

  login(BuildContext context,{required String mail,required pass, }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: pass,
      );
      _loggedIn = true;
      notifyListeners();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The username entered is not found"),
            duration: Duration(seconds: 2),
          )
        );
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The password is not correct"),
            duration: Duration(seconds: 2),
          )
        );
      }
    }
  }

  signout () async {
    await FirebaseAuth.instance.signOut();
  }
}
