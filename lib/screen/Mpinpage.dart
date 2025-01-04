// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/main.dart';
// import 'package:mddmerchant/Registration/regis.dart';
// import 'package:mddmerchant/Registration/createMpin.dart';
import 'package:mddmerchant/screen/creatMPin.dart';
import 'package:mddmerchant/screen/otp.dart';

class MpinPage extends StatefulWidget {
  String mob_no;
  MpinPage({required this.mob_no});

  @override
  State<MpinPage> createState() => _MpinPageState();
}

class _MpinPageState extends State<MpinPage> {
  var n1 = TextEditingController();

  var n2 = TextEditingController();

  var n3 = TextEditingController();

  var n4 = TextEditingController();

  var n5 = TextEditingController();

  var n6 = TextEditingController();

  var nu1 = FocusNode();

  var nu2 = FocusNode();

  var nu3 = FocusNode();

  var nu4 = FocusNode();

  var nu5 = FocusNode();

  var nu6 = FocusNode();

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset("assets/images/main/ic_launcher-removebg-preview.png"),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(
                          'assets/images/main/ic_launcher-removebg-preview.png'), // Replace with your asset path
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  // height: 300,
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFDAB89B),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  padding: EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          height: 250,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'M-Pin',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'Fontmain',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Enter Your Security Pin for login.',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Fontmain'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    width: 40,
                                    height: 40,
                                    // padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      maxLength: 1,
                                      controller: n1,
                                      focusNode: nu1,
                                      keyboardType: TextInputType.number,
                                      buildCounter: (context,
                                          {required currentLength,
                                          required maxLength,
                                          required isFocused}) {
                                        // Return an empty SizedBox to hide the counter
                                        return SizedBox.shrink();
                                      },
                                      onChanged: (value) {
                                        if (value != "") {
                                          nu2.requestFocus();
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color:
                                            Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize:
                                            16, // Optional: Change font size
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    width: 40,
                                    height: 40,
                                    // padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      focusNode: nu2,
                                      maxLength: 1,
                                      onChanged: (value) {
                                        if (value != "") {
                                          nu3.requestFocus();
                                        }
                                      },
                                      buildCounter: (context,
                                          {required currentLength,
                                          required maxLength,
                                          required isFocused}) {
                                        // Return an empty SizedBox to hide the counter
                                        return SizedBox.shrink();
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: n2,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color:
                                            Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize:
                                            16, // Optional: Change font size
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    width: 40,
                                    height: 40,
                                    // padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      focusNode: nu3,
                                      maxLength: 1,
                                      onChanged: (value) {
                                        if (value != "") {
                                          nu4.requestFocus();
                                        }
                                      },
                                      buildCounter: (context,
                                          {required currentLength,
                                          required maxLength,
                                          required isFocused}) {
                                        // Return an empty SizedBox to hide the counter
                                        return SizedBox.shrink();
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: n3,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color:
                                            Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize:
                                            16, // Optional: Change font size
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    width: 40,
                                    height: 40,
                                    // padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      focusNode: nu4,
                                      maxLength: 1,
                                      onChanged: (value) {
                                        if (value != "") {
                                          nu5.requestFocus();
                                        }
                                      },
                                      buildCounter: (context,
                                          {required currentLength,
                                          required maxLength,
                                          required isFocused}) {
                                        // Return an empty SizedBox to hide the counter
                                        return SizedBox.shrink();
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: n4,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color:
                                            Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize:
                                            16, // Optional: Change font size
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    width: 40,
                                    height: 40,
                                    // padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      focusNode: nu5,
                                      maxLength: 1,
                                      onChanged: (value) {
                                        if (value != "") {
                                          nu6.requestFocus();
                                        }
                                      },
                                      buildCounter: (context,
                                          {required currentLength,
                                          required maxLength,
                                          required isFocused}) {
                                        // Return an empty SizedBox to hide the counter
                                        return SizedBox.shrink();
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: n5,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color:
                                            Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize:
                                            16, // Optional: Change font size
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    width: 40,
                                    height: 40,
                                    // padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      focusNode: nu6,
                                      maxLength: 1,
                                      onChanged: (value) async {
                                        if (value != "") {
                                          setState(() {
                                            loader = true;
                                          });
                                          String temp = await Api.Mpin_check(
                                              mob_no: widget.mob_no,
                                              Mpin: n1.text +
                                                  n2.text +
                                                  n3.text +
                                                  n4.text +
                                                  n5.text +
                                                  n6.text);
                                          if (temp == "R100") {
                                            await Api.prefs
                                                .setBool('login', true)
                                                .then(
                                              (value) {
                                                print(
                                                    Api.prefs.getBool('login'));
                                                // Get.offAll(HomeScreen);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeScreen()));
                                              },
                                            );
                                          } else {
                                            
                                            Api.snack_bar(context: context, message: "invalid M-pin");
                                            n1.clear();
                                            n2.clear();
                                            n3.clear();
                                            n4.clear();
                                            n5.clear();
                                            n6.clear();
                                            nu1.requestFocus();
                                          }
                                        }
                                        setState(() {
                                          loader = false;
                                        });
                                      },
                                      buildCounter: (context,
                                          {required currentLength,
                                          required maxLength,
                                          required isFocused}) {
                                        // Return an empty SizedBox to hide the counter
                                        return SizedBox.shrink();
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: n6,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color:
                                            Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize:
                                            16, // Optional: Change font size
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        setState(() {
                                          loader = true;
                                        });
                                        await Api.send_otp(widget.mob_no,context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OtpPage(
                                                      mob_no: widget.mob_no,
                                                      priv_screen:
                                                          "Mpin_Screen",
                                                    )));
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateMPin(mob_no: mob_no,)));
                                        setState(() {
                                          loader = false;
                                        });
                                      },
                                      child: Text(
                                        'Forgot M-Pin?',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Fontmain'),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (n1.text.isNotEmpty && n2.text.isNotEmpty && n3.text.isNotEmpty&&n4.text.isNotEmpty&&n5.text.isNotEmpty&&n6.text.isNotEmpty) {
                                setState(() {
                                  loader = true;
                                });
                                String temp = await Api.Mpin_check(
                                    mob_no: widget.mob_no,
                                    Mpin: n1.text +
                                        n2.text +
                                        n3.text +
                                        n4.text +
                                        n5.text +
                                        n6.text);
                                if (temp == "R100") {
                                  await Api.prefs.setInt('is_Hindi', 0).then(
                                    (value) {
                                      Api.prefs.setBool('login', true).then(
                                        (value) {
                                          print(Api.prefs.getBool('login'));
                                          Get.offAll(HomeScreen());
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             HomeScreen()));
                                        },
                                      );
                                    },
                                  );
                                } else {
                                Api.snack_bar(context: context, message: "invalid M-pin");
                                  n1.clear();
                                  n2.clear();
                                  n3.clear();
                                  n4.clear();
                                  n5.clear();
                                  n6.clear();
                                }
                                setState(() {
                                  loader = false;
                                });
                              } else {
                              Api.snack_bar(context: context, message: "please enter M-Pin");
                              }
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisTration()));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 64, vertical: 16),
                            ),
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (loader)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
