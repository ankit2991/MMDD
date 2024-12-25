import 'dart:async';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/constrans.dart';
import 'package:flutter/material.dart';
// import 'package:mddmerchant/main.dart';
import 'package:mddmerchant/App_bar/user_acc.dart';
import 'package:mddmerchant/main.dart';
class Splashscreen extends StatefulWidget{
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}



class _SplashscreenState extends State<Splashscreen>{
  @override
   void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()async{
      if (Api.prefs.getBool('login')==true) {
      await Api.Mpin_check(mob_no: Api.prefs.getString("mobile_no")??"", Mpin: Api.prefs.getString("mpin")??"").then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      },);        
      }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogOutPage()));

      }
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