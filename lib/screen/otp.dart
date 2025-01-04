// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/screen/Mpinpage.dart';
import 'package:mddmerchant/screen/creatMPin.dart';
import './regstration.dart';
import 'dart:async';
// import 'package:mddmerchant/Registration/regis.dart';
// import 'package:mddmerchant/Registration/createMpin.dart';

class OtpPage extends StatefulWidget {
  String mob_no;
  String priv_screen;
  OtpPage({required this.mob_no, required this.priv_screen});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  ValueNotifier<int> OTPtimer = ValueNotifier<int>(30);
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (OTPtimer.value != 0) {
          --OTPtimer.value;
          log("${OTPtimer.value}");
        }
      },
    );
  }

  @override
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

  Widget build(BuildContext context) {
    print(widget.priv_screen);
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
                                'OTP',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'Fontmain',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Enter Your OTP for verify your mobile number.',
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
                                      focusNode: nu1,
                                      onChanged: (value) {
                                        if (value != "") {
                                          nu2.requestFocus();
                                        }
                                      },
                                      maxLength: 1,
                                      buildCounter: (context,
                                          {required currentLength,
                                          required maxLength,
                                          required isFocused}) {
                                        // Return an empty SizedBox to hide the counter
                                        return SizedBox.shrink();
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: n1,
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
                                      onChanged: (value) {
                                        if (value != "") {
                                          nu3.requestFocus();
                                        }
                                      },
                                      maxLength: 1,
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
                                      onChanged: (value) {
                                        if (value != "") {
                                          nu4.requestFocus();
                                        }
                                      },
                                      maxLength: 1,
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
                                      onChanged: (value) {
                                        if (value != "") {
                                          nu5.requestFocus();
                                        }
                                      },
                                      maxLength: 1,
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
                                      onChanged: (value) {
                                        if (value != "") {
                                          nu6.requestFocus();
                                        }
                                      },
                                      maxLength: 1,
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
                                      buildCounter: (context,
                                          {required currentLength,
                                          required maxLength,
                                          required isFocused}) {
                                        // Return an empty SizedBox to hide the counter
                                        return SizedBox.shrink();
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: n6,
                                      onChanged: (value) async {
                                        setState(() {
                                          loader = true;
                                        });
                                        if (value != "") {
                                          if (n1.text != "" &&
                                              n1.text != "" &&
                                              n2.text != "" &&
                                              n3.text != "" &&
                                              n4.text != "" &&
                                              n5.text != "" &&
                                              n6.text != "") {
                                            String otp = n1.text +
                                                n2.text +
                                                n3.text +
                                                n4.text +
                                                n5.text +
                                                n6.text;
                                            bool check = await Api.otp_insert(
                                                mob_no: widget.mob_no,
                                                Otp: otp);
                                            if (check) {
                                              log("Done .");
                                              if (widget.priv_screen ==
                                                  "Mpin_Screen") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreateMPin(
                                                              mob_no:
                                                                  widget.mob_no,
                                                            )));
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisTration(
                                                              Mob:
                                                                  widget.mob_no,
                                                            )));
                                              }
                                            } else {
                                              Api.snack_bar(context: context, message: "invalid OTP");
                                              n1.clear();
                                              n2.clear();
                                              n3.clear();
                                              n4.clear();
                                              n5.clear();
                                              n6.clear();
                                              nu1.requestFocus();
                                              log("wrong");
                                            }
                                          } else {
                                            Api.snack_bar(context: context, message: "invalid OTP");
                                          }
                                        }
                                        setState(() {
                                          loader = false;
                                        });
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
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: OTPtimer,
                                    builder: (context, value, child) {
                                      return OTPtimer.value.toString() == "0"
                                          ? GestureDetector(
                                            onTap: ()async{
                                             await Api.send_otp( widget.mob_no,context);
                                              OTPtimer.value=30;
                                              n1.clear();
                                              n2.clear();
                                              n3.clear();
                                              n4.clear();
                                              n5.clear();
                                              n6.clear();
                                              nu1.requestFocus();
                                            },
                                            child: Text(
                                                "Don't get OTP? Resend OTP",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Fontmain'),
                                              ),
                                          )
                                          : Text(
                                              "00:${value.toString()}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Fontmain'),
                                            );
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                loader = true;
                              });
                              if (n1.text != "" &&
                                  n1.text != "" &&
                                  n2.text != "" &&
                                  n3.text != "" &&
                                  n4.text != "" &&
                                  n5.text != "" &&
                                  n6.text != "") {
                                String otp = n1.text +
                                    n2.text +
                                    n3.text +
                                    n4.text +
                                    n5.text +
                                    n6.text;
                                bool check = await Api.otp_insert(
                                    mob_no: widget.mob_no, Otp: otp);
                                if (check) {
                                  log("Done .");
                                  if (widget.priv_screen == "Mpin_Screen") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CreateMPin(
                                                  mob_no: widget.mob_no,
                                                )));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RegisTration(
                                                  Mob: widget.mob_no,
                                                )));
                                  }
                                } else {
                                  Api.snack_bar(context: context, message: "invalid OTP");
                                  n1.clear();
                                  n2.clear();
                                  n3.clear();
                                  n4.clear();
                                  n5.clear();
                                  n6.clear();
                                  log("wrong");
                                }
                              } else {
                              Api.snack_bar(context: context, message: "invalid OTP");
                              }
                              setState(() {
                                loader = false;
                              });
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
