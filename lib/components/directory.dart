import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

String appName = "MyUbuntu";
String dirPath = "/storage/emulated/0/$appName";
Directory appDirectory = Directory(dirPath);
Future<Directory> creadir() async {

  // Directory? appDocDir = await getExternalStorageDirectory();
  //     String newPath ="";
  //     List<String>? folders =appDocDir?.path.split("/");
  //     for (var i = 0; i < folders!.length; i++) {
  //       String folder = folders[i];
  //       if (folder != "Android") {
  //         newPath += "/"+folder;
  //       } else {
  //         break;
  //       }
  //     }
  //     newPath = newPath + "/$appName";
  //     appDocDir = Directory(newPath); 
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