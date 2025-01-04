import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/screen/Mpinpage.dart';
// import 'package:mddmerchant/Registration/mpin.dart';
// import 'package:mddmerchant/Registration/regis.dart';

class CreateMPin extends StatefulWidget {
  String mob_no;
  CreateMPin({required this.mob_no});

  @override
  State<CreateMPin> createState() => _CreateMPinState();
}

class _CreateMPinState extends State<CreateMPin> {
  var n1 = TextEditingController();

  var n2 = TextEditingController();

  var n3 = TextEditingController();

  var n4 = TextEditingController();

  var n5 = TextEditingController();

  var n6 = TextEditingController();

  var n11 = TextEditingController();

  var n22 = TextEditingController();

  var n33 = TextEditingController();

  var n44 = TextEditingController();

  var n55 = TextEditingController();

  var n66 = TextEditingController();

  var nu1 = FocusNode();

  var nu2 = FocusNode();

  var nu3 = FocusNode();

  var nu4 = FocusNode();

  var nu5 = FocusNode();

  var nu6 = FocusNode();

  var nu11 = FocusNode();

  var nu22 = FocusNode();

  var nu33 = FocusNode();

  var nu44 = FocusNode();

  var nu55 = FocusNode();

  var nu66 = FocusNode();

bool loader=false;

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
                                'Change M-Pin',
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
                                    // fontSize: 16,
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
                                      maxLength: 1,
                                       onChanged: (value) {
                                        if (value != "") {
                                          nu2.requestFocus();
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
                                      controller: n1,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                              Text(
                                'Enter Confirm M-Pin.',
                                style: TextStyle(
                                    // fontSize: 16,
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
                                      focusNode: nu11,
                                      maxLength: 1,
                                       onChanged: (value) {
                                        if (value != "") {
                                          nu22.requestFocus();
                                        }
                                      },
                                      buildCounter: (context,
                                          {required currentLength,
                                          required maxLength,
                                          required isFocused}) {
                                        // Return an empty SizedBox to hide the counter
                                        return SizedBox.shrink();
                                      },
                                      controller: n11,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                                      focusNode: nu22,
                                      maxLength: 1,
                                       onChanged: (value) {
                                        if (value != "") {
                                          nu33.requestFocus();
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
                                      controller: n22,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                                      focusNode: nu33,
                                      maxLength: 1,
                                       onChanged: (value) {
                                        if (value != "") {
                                          nu44.requestFocus();
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
                                      controller: n33,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                                      focusNode: nu44,
                                      maxLength: 1,
                                       onChanged: (value) {
                                        if (value != "") {
                                          nu55.requestFocus();
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
                                      controller: n44,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                                      focusNode: nu55,
                                      maxLength: 1,
                                       onChanged: (value) {
                                        if (value != "") {
                                          nu66.requestFocus();
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
                                      controller: n55,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                                      focusNode: nu66,
                                      maxLength: 1,
                                      buildCounter: (context,
                                          {required currentLength,
                                          required maxLength,
                                          required isFocused}) {
                                        // Return an empty SizedBox to hide the counter
                                        return SizedBox.shrink();
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: n66,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 13,
                                          bottom: 10,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white, // Change text color
                                        fontFamily:
                                            'sub-tittle', // Change font family
                                        fontSize: 16, // Optional: Change font size
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
                            ],
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                              loader=true;                                
                              });
                              if (n1.text == n11.text &&
                                  n2.text == n22.text &&
                                  n3.text == n33.text &&
                                  n4.text == n44.text &&
                                  n5.text == n55.text &&
                                  n6.text == n66.text) {
                                String new_mpin = n1.text +
                                    n2.text +
                                    n3.text +
                                    n4.text +
                                    n5.text +
                                    n6.text;
                                String temp = await Api.change_password(
                                    mob_no: widget.mob_no, Mpin: new_mpin);
                                if (temp == "R100") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MpinPage(
                                                mob_no: widget.mob_no,
                                              )));
                                  log("Done");
                                }
                              } else {
                                Api.snack_bar(context: context, message: "Wrong pin");
                              }
                              setState(() {
                                loader=false;
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
