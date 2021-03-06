import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/database.dart';
import '../components/directory.dart';

class AppStateManager extends ChangeNotifier {
 
  bool? _loggedIn ;
  bool? _signedup = false;
  bool? _initialized = false;
  
  bool? get isSignedup => _signedup;
  bool? get isLoggedIn => _loggedIn;
  bool? get isInitialized => _initialized;


  String username = '';
  
  signup() {
    _signedup = true;
    notifyListeners();
  }

  signupout () {
    _signedup = false;
    notifyListeners();
  }

  savename(String name) async {
    final sharedPreferences =  await SharedPreferences.getInstance();
    await sharedPreferences.setString('username', name);
  }

  readname() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username')!;
  }

  void initializeApp() {
    Timer(
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        notifyListeners();
      },
    );
  }

  Future<void> init() async{
    await requestPermission(Permission.storage);
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

  create (BuildContext context,{required String mail,required pass, })async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
       return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The password provided is too weak"),
            duration: Duration(seconds: 2),
          )
        );
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("An account already exists for that email"),
            duration: Duration(seconds: 2),
          )
        );
      }
    } catch (e) {
      print(e);
    }
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
            content: Text("The email entered is not found"),
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
    await PassDatabase.instance.close();
    _loggedIn = false;
    _initialized = false;
    _signedup = false;
    notifyListeners();
  }
}
