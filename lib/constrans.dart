import 'package:flutter/material.dart';

const kBackgrundColor = Color(0xfffbfafa);
const kActiveIconColor = Color(0xffe68342);
const kTextColor = Color(0xff1E1C1C);
const kBlueLightColor = Color(0xffc7b8f5);
const kBlueColor = Color(0xe5777474);
const kshadowColor = Color(0xffe6e6e6);
const mainColor = Color(0xffC4A68B);




class AppColors{
  static const Color scaffoldbackground=Color(0xffC4A68B);
}


class UiHelper {
  static CustomImage({required String img}) {
    return Image.asset("assets/images/main/$img");
  }
}