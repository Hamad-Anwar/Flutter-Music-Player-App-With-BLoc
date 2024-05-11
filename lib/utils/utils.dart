// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path/path.dart' as path;
// class Utils {
//   static final controller = Get.put(FilesController());
//
//   static Future<bool> permissionRequest()async{
//
//     var status = await Permission.storage.status;
//     if (status.isDenied) {
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.location,
//         Permission.storage,
//       ].request();
//       var temp = await Permission.storage.status;
//       if(temp.isGranted){
//         return true;
//       }else {
//         return false;
//       }
//     }
//     else
//     {
//       return true;
//     }
//
//   }
//
//
//   static getFileLength(String filePath)async{
//     final player=AudioPlayer();
//     await player.setFilePath(filePath).then((value){
//       String prefix=player.duration!.inMinutes.toString();
//       String postFix=(player.duration!.inSeconds % 60).toString();
//       if(prefix.length<2){
//         prefix='0$prefix';
//       }
//       if(postFix.length<2){
//         postFix='0$postFix';
//       }
//       controller.audioLength.add('$prefix:$postFix');
//     });
//     player.dispose();
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music/res/app_colors.dart';
import 'package:music/res/app_images.dart';
import 'package:permission_handler/permission_handler.dart';
class Utils{
  static go({required BuildContext context,required dynamic screen,bool replace=false}){
    replace ?
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen,))
        : Navigator.push(context, MaterialPageRoute(builder: (context) => screen,));
  }
  static String getRandomImage(){
    return AppImages.imageList[Random().nextInt(13)]!;
  }
  static Future<bool> requestPermission()async{
    var status1 = await Permission.audio.status;
    if(status1.isGranted){
      return true;
    }
    else{
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.audio,
        Permission.manageExternalStorage,
      ].request();
      var temp1 = await Permission.audio.status;
      if(temp1.isGranted){
        return true;
      }else {
        return false;
      }
    }
  }
  static String getGreetingMessage() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour >= 5 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
  static showBottomSheet({required BuildContext context,
  required Widget widget,
    bool isDismissible=false
  }){
    showModalBottomSheet(
      backgroundColor: backgroundColor,
      isDismissible: isDismissible,
      enableDrag: false,
      isScrollControlled: true,
      context: context, builder: (context) {
      return widget;
    },);
  }

}
