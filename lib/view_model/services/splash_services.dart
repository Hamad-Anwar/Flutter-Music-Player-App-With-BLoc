import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music/utils/utils.dart';
import 'package:music/view/home/home_view.dart';
import 'package:music/view/onBoarding/onBoarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashServices{
  static isFirstTime({required BuildContext context})async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    final check=pref.getBool('OPENED') ?? false;
    Timer(const Duration(seconds: 2), () {
      if(check){
        Utils.go(context: context, screen: const HomeView(),replace: true);
      }else{
        Utils.go(context: context, screen: const OnBoarding(),replace: true);
      }
    });
  }

}