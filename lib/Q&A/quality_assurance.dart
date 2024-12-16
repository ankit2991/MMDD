import 'package:flutter/material.dart';


class QualityAss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quality Assurance',
          style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),),
        centerTitle: true,
        backgroundColor: Color(0xffC4A68B),
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
