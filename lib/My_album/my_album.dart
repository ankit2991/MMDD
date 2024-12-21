import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddmerchant/My_album/Album/images.dart';
import 'package:mddmerchant/My_album/Video/video.dart';

class MyAlbum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Album'.tr, style: TextStyle(color: Colors.white, fontFamily: 'Fontmain')),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white, // Change the color of the icon
            iconSize: 30.0, // Adjust the size of the icon
          ),
          backgroundColor: Color(0xffC4A68B),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: .84,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyImage()),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Spacer(),
                            Image.asset(
                              "assets/images/myalbum/images.png",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Spacer(),
                            Text(
                              "Images".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Fontmain',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyVideo()),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Spacer(),
                            Image.asset(
                              "assets/images/myalbum/videos.png",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Spacer(),
                            Text(
                              "Videos".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Fontmain',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
