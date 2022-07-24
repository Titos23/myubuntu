import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

String appName = "MyUbuntu";
String dirPath = "/storage/emulated/0/$appName";
Directory appDirectory = Directory(dirPath);

Future<Directory> creadir() async {
  await appDirectory.create(recursive: true);
  return Directory(dirPath);
}

Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      creadir();
      return true;
    } else {
      var result = permission.request();
      // ignore: unrelated_type_equality_checks
      if (result == PermissionStatus.granted) {
        creadir();
        return true;
      } else {
        return false;
      }
    } 
  }