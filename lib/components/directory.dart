import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';



Future<Directory> creadir(String dirName) async {

  Directory? appDocDir = await getExternalStorageDirectory();
      String newPath ="";
      List<String>? folders =appDocDir?.path.split("/");
      for (var i = 0; i < folders!.length; i++) {
        String folder = folders[i];
        if (folder != "Android") {
          newPath += "/"+folder;
        } else {
          break;
        }
      }
      newPath = newPath + "/$dirName";
      appDocDir = Directory(newPath); 
      await appDocDir.create(recursive: true);
      return Directory(newPath);
       
}


Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      creadir("MyUbuntu");
      return true;
    } else {
      var result = permission.request();
      // ignore: unrelated_type_equality_checks
      if (result == PermissionStatus.granted) {
        creadir("MyUbuntu");
        return true;
      } else {
        return false;
      }
    } 
  }