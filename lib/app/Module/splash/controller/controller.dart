import 'package:flutter/material.dart';
import 'package:insti_meteo/app/Module/splashOne/view/splashOne.dart';

time(BuildContext context) {
  Future.delayed(Duration(seconds: 5),(){
    print("cc");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashOne()),);
  });
}