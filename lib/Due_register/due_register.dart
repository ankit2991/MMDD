import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DueRegi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Due Register'.tr,
          style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Change the color of the icon
          iconSize: 30.0, // Adjust the size of the icon
        ),
      ),
      body: Center(
        child: Text('No Data Available', style: TextStyle(fontFamily: 'Fontmain', color: Color(0xe5777474)),),
      ),
    );
  }
}
