import 'dart:async';
import 'package:mddmerchant/constrans.dart';
import 'package:flutter/material.dart';
// import 'package:mddmerchant/main.dart';
import 'package:mddmerchant/App_bar/user_acc.dart';
class Splashscreen extends StatefulWidget{
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}



class _SplashscreenState extends State<Splashscreen>{
  @override
   void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogOutPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldbackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.CustomImage(img: "ic_launcher-removebg-preview.png")
          ],
        ),
      ),
    );
  }
}