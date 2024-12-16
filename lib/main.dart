import 'package:flutter/material.dart';
import 'package:mddmerchant/constrans.dart';
import 'package:mddmerchant/Due_register/due_register.dart';
import 'package:mddmerchant/Enquiry/enquiry.dart';
import 'package:mddmerchant/My_album/my_album.dart';
import 'package:mddmerchant/Promoss and ads/promoss_ads.dart';
import 'package:mddmerchant/Q&A/quality_assurance.dart';
import 'package:mddmerchant/Booking_reg/booking_regi.dart';
import 'package:mddmerchant/App_bar/user_acc.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:mddmerchant/screen/spalashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MDD Merchant',
      theme: ThemeData(
        fontFamily: 'Fontmain',
        scaffoldBackgroundColor: kBackgrundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: Splashscreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading: false,
          elevation: 2.0,
          title: Text('Thakur',
              style: TextStyle(
                // fontWeight: FontWeight.w700,
                color: Colors.white,
                fontFamily: 'Fontmain',
              )),
          // centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.g_translate_rounded,
                  color: Colors.white, size: 30),
            ),
            IconButton(
              icon: Icon(Icons.person,
                  color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfile()),
                );
              },
            ), // Custom home icon

          ]),
      body: Stack(children: <Widget>[
        SafeArea(
            child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: .84,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            // childAspectRatio: 2,
                            children: [
                              InkWell(
                                onTap: () {
                                  // Your onTap functionality here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyAlbum()),
                                  );
                                },
                                child: Container(
                                  width: 100, // Set your desired width
                                  height: 100, // Set your desired height
                                  padding: EdgeInsets.all(
                                      12), // Adds padding around the contents
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.3), // Shadow color
                                        spreadRadius: 2, // Spread of the shadow
                                        blurRadius: 2, // Blur radius of the shadow
                                        offset:
                                        Offset(0, 2), // Position of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Image.asset(
                                        "assets/images/main/myalbum.png",
                                        width: 100, // Adjust the width as needed
                                        height: 100, // Adjust the height as needed
                                        fit: BoxFit
                                            .cover, // Optional: Adjusts how the image is fitted
                                      ),
                                      Spacer(),
                                      Text(
                                        "My Album",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Fontmain',
                                          // fontWeight: FontWeight.w400
                                        ), // Slightly reduced font size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 0,
                              // ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QualityAss()),
                                  );
                                  // Your onTap functionality here
                                  print("Q&A clicked!");
                                },
                                child: Container(
                                  width: 100, // Set your desired width
                                  height: 100, // Set your desired height
                                  padding: EdgeInsets.all(
                                      12), // Adds padding around the contents
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.3), // Shadow color
                                        spreadRadius: 2, // Spread of the shadow
                                        blurRadius: 2, // Blur radius of the shadow
                                        offset:
                                        Offset(0, 2), // Position of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Image.asset(
                                        "assets/images/main/q&a.png",
                                        width: 100, // Adjust the width as needed
                                        height: 100, // Adjust the height as needed
                                        fit: BoxFit
                                            .cover, // Optional: Adjusts how the image is fitted
                                      ),
                                      Spacer(),
                                      Text(
                                        "Q&A",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Fontmain',
                                          // fontWeight: FontWeight.w700
                                        ), // Slightly reduced font size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyBoking()),
                                  );
                                },
                                child: Container(
                                  width: 100, // Set your desired width
                                  height: 100, // Set your desired height
                                  padding: EdgeInsets.all(
                                      12), // Adds padding around the contents
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.3), // Shadow color
                                        spreadRadius: 2, // Spread of the shadow
                                        blurRadius: 2, // Blur radius of the shadow
                                        offset:
                                        Offset(0, 2), // Position of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Image.asset(
                                        "assets/images/main/bookingregister.png",
                                        width: 100, // Adjust the width as needed
                                        height: 100, // Adjust the height as needed
                                        fit: BoxFit
                                            .cover, // Optional: Adjusts how the image is fitted
                                      ),
                                      Spacer(),
                                      const Text(
                                        "Booking Register",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Fontmain',
                                          // fontWeight: FontWeight.w700
                                        ), // Slightly reduced font size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyEnquiry()),
                                  );
                                },
                                child: Container(
                                  width: 100, // Set your desired width
                                  height: 100, // Set your desired height
                                  padding: EdgeInsets.all(
                                      12), // Adds padding around the contents
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.3), // Shadow color
                                        spreadRadius: 2, // Spread of the shadow
                                        blurRadius: 2, // Blur radius of the shadow
                                        offset:
                                        Offset(0, 2), // Position of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Image.asset(
                                        "assets/images/main/enquiry.png",
                                        width: 100, // Adjust the width as needed
                                        height: 100, // Adjust the height as needed
                                        fit: BoxFit
                                            .cover, // Optional: Adjusts how the image is fitted
                                      ),
                                      Spacer(),
                                      const Text(
                                        "Enquiry",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Fontmain',
                                          // fontWeight: FontWeight.w700
                                        ), // Slightly reduced font size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Your onTap functionality here
                                  // print("Container clicked!");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PromissAds()),
                                  );
                                },
                                child: Container(
                                  width: 100, // Set your desired width
                                  height: 100, // Set your desired height
                                  padding: EdgeInsets.all(
                                      12), // Adds padding around the contents
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.3), // Shadow color
                                        spreadRadius: 2, // Spread of the shadow
                                        blurRadius: 2, // Blur radius of the shadow
                                        offset:
                                        Offset(0, 2), // Position of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Image.asset(
                                        "assets/images/main/ads.png",
                                        width: 100, // Adjust the width as needed
                                        height: 100, // Adjust the height as needed
                                        fit: BoxFit
                                            .cover, // Optional: Adjusts how the image is fitted
                                      ),
                                      Spacer(),
                                      Text(
                                        "Promos & Ads",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Fontmain',
                                          // fontWeight: FontWeight.w700
                                        ), // Slightly reduced font size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DueRegi()),
                                  );
                                },
                                child: Container(
                                  width: 100, // Set your desired width
                                  height: 100, // Set your desired height
                                  padding: EdgeInsets.all(
                                      12), // Adds padding around the contents
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.3), // Shadow color
                                        spreadRadius: 2, // Spread of the shadow
                                        blurRadius: 2, // Blur radius of the shadow
                                        offset:
                                        Offset(0, 2), // Position of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Image.asset(
                                        "assets/images/main/duereg.png",
                                        width: 100, // Adjust the width as needed
                                        height: 100, // Adjust the height as needed
                                        fit: BoxFit
                                            .cover, // Optional: Adjusts how the image is fitted
                                      ),
                                      Spacer(),
                                      Text(
                                        "Due Register",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Fontmain',
                                          // fontWeight: FontWeight.w700
                                        ), // Slightly reduced font size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ])))
      ]),
    );
  }
}
