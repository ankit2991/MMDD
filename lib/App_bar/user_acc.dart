import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mddmerchant/constrans.dart';
import 'package:mddmerchant/App_bar/OurService/our_service.dart';
import 'package:mddmerchant/main.dart';
import 'package:mddmerchant/screen/Mpinpage.dart';
import 'package:mddmerchant/screen/otp.dart';
import 'dart:developer' as developer;
import "../api/api.dart";
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
    File ?_profile;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Profile Picture and Name
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                  //   Api.pickImage(img: true, source: ImageSource.gallery).then((value) {
                  //   setState(() {
                  //   _profile=value["file"];
                  //     // Api.UpdateProfileImg(img: _profile!);
                  //   });
                  // },);
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: mainColor,
                    // backgroundImage:_profile==null? AssetImage(""):Image.file(_profile!),
                    // Profile picture placeholder
                    child:Api.User_info["Table"][0]["profileImage"]!=null?Image.network(fit: BoxFit.cover,Api.User_info["Table"][0]["profileImage"],errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.person, size: 50, color: Colors.white);
                    },) :Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  Api.User_info["Table"][0]["MemberName"],
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Fontmain"),
                ),
                Text(
                  Api.User_info["Table"][0]["MobileNo"],
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontFamily: "Fontmain"),
                ),
                Api.User_info["Table"][0]["AccountBalance"] != null
                    ? Text(
                        "Wallet ₹${Api.User_info["Table"][0]["AccountBalance"].toString()}",
                        style: TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: 'Fontmain',
                        ))
                    : Text("Wallet ₹00",
                        style: TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.w700,
                          color: Colors.grey[700],
                          fontFamily: 'Fontmain',
                        )),
              ],
            ),
          ),
          // Profile Options List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                ProfileOption(
                    title: "Account Document", page: Account_Document()),
                ProfileOption(
                    title: "Basic Information", page: BasicInformationPage()),
                ProfileOption(
                    title: "Registration Information",
                    page: RegistrationInformationPage()),
                ProfileOption(
                    title: "Bank Information", page: BankInformationPage()),
                ProfileOption(title: "MMDD Orders", page: MMDDOrdersPage()),
                ProfileOption(title: "My Services", page: MyServicesPage()),
                ProfileOption(title: "Discount", page: Discount_screen()),
                ProfileOption(title: "Our Services", page: OurService()),
                ProfileOption(
                    title: "My Terms & Conditions",
                    page: TermsAndConditionsPage()),
                ProfileOption(title: "Review", page: ReviewPage()),
                ProfileOption(title: "Phone Diary", page: PhoneDiary()),
                ProfileOption(title: "Contact Us", page: ContactPage()),
                ProfileOption(title: "Log Out", page: LogOutPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Widget for each option as a card
class Discount_screen extends StatefulWidget {
  const Discount_screen({super.key});

  @override
  State<Discount_screen> createState() => _Discount_screenState();
}

class _Discount_screenState extends State<Discount_screen> {
  List<dynamic> _data = [];
  bool loader = false;
  void refresh() {
    setState(() {
      loader = true;
    });
    _data.clear();
    Api.FacilityReport().then(
      (value) {
        _data = value;
        setState(() {
          loader = false;
        });
      },
    );
  }

  List<bool?> bools = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    loader = true;
    _data.clear();

    Api.FacilityReport().then(
      (value) {
        _data = value;
        print(_data);
        setState(() {
          loader = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Discount",
            style: TextStyle(fontFamily: "Fontmain"),
          ),
          elevation: 3.5,
          backgroundColor: Color(0xffC4A68B),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Stack(children: [
          loader
              ? Center(
                  child: Text('No Data Available'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    if (_data[index]["IsDiscount"] != null) {
                      bools.add(_data[index]["IsDiscount"]);
                    } else {
                      bools.add(false);
                    }
                    ValueNotifier<bool?> date_ref = ValueNotifier(false);
                    ValueNotifier<bool?> check =
                        ValueNotifier(_data[index]["IsDiscount"]);
                    ValueNotifier<double?> total = ValueNotifier(0);
                    var discount_con = TextEditingController();
                    DateTime? _startDate;
                    DateTime? _endDate;
                    if (_data[index]["IsDiscount"] == true) {
                      discount_con.text =
                          _data[index]["DiscountAmount"].toString();
                      total.value = _data[index]["Amount"] -
                          _data[index]["DiscountAmount"];
                      if (_data[index]["DisStartDate"] != null) {
                        _startDate =
                            DateTime.parse(_data[index]["DisStartDate"]);
                      }
                      if (_data[index]["DisEndDate"] != null) {
                        _endDate = DateTime.parse(_data[index]["DisEndDate"]);
                        if (_endDate.isBefore(DateTime.now())) {
                          Api.FacilityDiscountInsert(
                                  DiscountStartDate:
                                      "${_startDate!.toLocal()}".split(' ')[0],
                                  DiscountEndDate:
                                      "${_endDate!.toLocal()}".split(' ')[0],
                                  DiscountAmount: discount_con.text,
                                  FacilityId: _data[index]["Id"].toString(),
                                  IsDiscount: "0")
                              .then(
                            (value) {
                              if (bools[index] == true) {
                                // if( int.parse(amount_con.text)-int.parse(discount_con.text)>=0){
                                Api.snack_bar(
                                    context: context,
                                    message: "Discount Activated successfully");
                              } else {
                                Api.snack_bar(
                                    context: context,
                                    message:
                                        "Discount Deactivated successfully");
                              }
                            },
                          );
                        }
                      }
                    }

                    Future<void> _selectDate(
                        BuildContext context, bool isStart) async {
                      final DateTime? pickedDate;
                      if (isStart) {
                        pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                      } else {
                        pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: _startDate ?? DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                      }

                      if (pickedDate != null) {
                        if (isStart) {
                          _startDate = pickedDate;
                          date_ref.value =
                              date_ref.value == true ? false : true;
                        } else {
                          _endDate = pickedDate;
                          date_ref.value =
                              date_ref.value == true ? false : true;
                        }
                      }
                    }

                    // var tot_con=TextEditingController();
                    return Container(
                      margin: EdgeInsets.all(10),
                      // height: 80,
                      // color: Colors.amber,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: const Color.fromARGB(146, 0, 0, 0),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Row(
                            children: [
                              ValueListenableBuilder(
                                valueListenable: check,
                                builder: (context, value, child) {
                                  return Checkbox(
                                    value: bools[index],
                                    onChanged: (values) {
                                      setState(() {
                                        check.value = values;
                                        bools.removeAt(index);
                                        bools.insert(index, values);
                                      });
                                    },
                                  );
                                },
                              ),
                              Text(
                                _data[index]["FacilityName"],
                                style: TextStyle(
                                    fontFamily: "Fontmain",
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 100,
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue:
                                      _data[index]["Amount"].toString(),
                                  decoration: InputDecoration(
                                      label: Text("Amount"),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: discount_con,
                                  onChanged: (valuee) {
                                    if (valuee != "" &&
                                        int.parse(valuee) != 0) {
                                      if (_data[index]["Amount"] -
                                              int.parse(valuee) >=
                                          0) {
                                        total.value = _data[index]["Amount"] -
                                            int.parse(valuee);
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text("Something went wrong"),
                                            content: Text(
                                                "Please remove extra amount"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context); // Close dialog without doing anything
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Perform an action here
                                                  discount_con.text = "0.0";
                                                  Navigator.pop(
                                                      context); // Close dialog after action
                                                },
                                                child: Text("Confirm"),
                                              ),
                                            ],
                                          ),
                                        );
                                        total.value = 0;
                                      }
                                    } else {
                                      total.value = 0;
                                    }
                                  },
                                  readOnly: bools[index] == true ? false : true,
                                  decoration: InputDecoration(
                                      labelText: "Discount",
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.black))),
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: total,
                                builder: (context, value, child) {
                                  return Container(
                                    width: 100,
                                    child: TextFormField(
                                      controller: TextEditingController(
                                          text: total.value.toString()),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          labelText: "Net Amount",
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black))),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                          ValueListenableBuilder(
                            valueListenable: date_ref,
                            builder: (context, value, child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        30,
                                    child: TextFormField(
                                      onTap: () {
                                        _selectDate(context, true);
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please select Discount Start Date";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          onPressed: () {
                                            _selectDate(context, true);
                                          },
                                        ),
                                        labelText: "Start Discount Date",
                                        labelStyle: TextStyle(
                                          color: Color(0xe5777474),
                                          fontFamily: 'sub-tittle',
                                          fontSize: 14,
                                        ),
                                        floatingLabelStyle:
                                            TextStyle(color: Color(0xffC4A68B)),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffC4A68B),
                                              width: 2),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'sub-tittle',
                                        fontSize: 12.0,
                                      ),
                                      controller: TextEditingController(
                                        text: _startDate != null
                                            ? "${_startDate!.toLocal()}"
                                                .split(' ')[0]
                                            : '',
                                      ),
                                      readOnly: true,
                                    ),
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        30,
                                    child: TextFormField(
                                      onTap: () {
                                        if (_startDate != null) {
                                          _selectDate(context, false);
                                        } else {
                                          Api.snack_bar(
                                              context: context,
                                              message:
                                                  "Please Select Start Date");
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please select Discount Start Date";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          onPressed: () {
                                            if (_startDate != null) {
                                              _selectDate(context, false);
                                            } else {
                                              Api.snack_bar(
                                                  context: context,
                                                  message:
                                                      "Please Select Start Date");
                                            }
                                          },
                                        ),
                                        labelText: "End Discount Date",
                                        labelStyle: TextStyle(
                                          color: Color(0xe5777474),
                                          fontFamily: 'sub-tittle',
                                          fontSize: 14,
                                        ),
                                        floatingLabelStyle:
                                            TextStyle(color: Color(0xffC4A68B)),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffC4A68B),
                                              width: 2),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'sub-tittle',
                                        fontSize: 12.0,
                                      ),
                                      controller: TextEditingController(
                                        text: _endDate != null
                                            ? "${_endDate!.toLocal()}"
                                                .split(' ')[0]
                                            : '',
                                      ),
                                      readOnly: true,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              Api.FacilityDiscountInsert(
                                      DiscountStartDate:
                                          "${_startDate!.toLocal()}"
                                              .split(' ')[0],
                                      DiscountEndDate: "${_endDate!.toLocal()}"
                                          .split(' ')[0],
                                      DiscountAmount: discount_con.text,
                                      FacilityId: _data[index]["Id"].toString(),
                                      IsDiscount:
                                          bools[index] == true ? "1" : "0")
                                  .then(
                                (value) {
                                  if (bools[index] == true) {
                                    // if( int.parse(amount_con.text)-int.parse(discount_con.text)>=0){
                                    Api.snack_bar(
                                        context: context,
                                        message:
                                            "Discount Activated successfully");
                                  } else {
                                    Api.snack_bar(
                                        context: context,
                                        message:
                                            "Discount Deactivated successfully");
                                  }
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffC4A68B),
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Fontmain"),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
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
        ]));
  }
}

class ProfileOption extends StatelessWidget {
  final String title;
  final Widget page;
  // final TextStyle? titleStyle;

  ProfileOption({required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Fontmain',
              // fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          onTap: () async {
            await Api.prefs.setBool('login', false).then(
              (value) {
                print(Api.prefs.getBool('login'));
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => page), // The new page to display
                //   (Route<dynamic> route) => false, // Remove all previous routes
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
            );
            // Navigate to the selected page
          },
        ),
      ),
    );
  }
}

class Account_Document extends StatelessWidget {
  const Account_Document({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Document",
          style: TextStyle(
            fontFamily: "Fontmain",
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xffC4A68B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Api.moveFileToLocalStorage().then(
                  (value) {
                    
                    Api.snack_bar(
                        context: context,
                        message: "check your download folder");
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 0))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Text(
                  "Download pdf",
                  style: TextStyle(fontFamily: "Fontmain"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Api.pickPDF().then(
                  (value) {
                    if (value != null) {
                      File temp = File(value ?? "");
                      Api.ImageInsert(
                          DocType: "4",
                          MemberAgreementUpload_UploadFile2:
                              "MemberAgreementUpload",
                          ext: ".pdf",
                          img: temp,
                          context: context);
                    } else {
                      Api.snack_bar(
                          context: context, message: "File not select");
                    }
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                // width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 0))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Text("Upload pdf",
                    style: TextStyle(fontFamily: "Fontmain")),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Example pages
class BasicInformationPage extends StatelessWidget {
  var nam_con = TextEditingController(
      text: Api.User_info["Table"][0]["MemberName"] ?? "");
  var B_nam_con =
      TextEditingController(text: Api.User_info["Table"][0]["OrgName"] ?? "");
  var mob_con =
      TextEditingController(text: Api.User_info["Table"][0]["MobileNo"] ?? "");
  var alt_mob_con = TextEditingController(
      text: Api.User_info["Table"][0]["OtherMobileNo"] ?? "");
  var email_con =
      TextEditingController(text: Api.User_info["Table"][0]["EmailId"] ?? "");
  var state_con =
      TextEditingController(text: Api.User_info["Table"][0]["StateName"] ?? "");
  var city_con =
      TextEditingController(text: Api.User_info["Table"][0]["CityName"] ?? "");
  var loc_con =
      TextEditingController(text: Api.User_info["Table"][0]["AreaName"] ?? "");
  var address_con = TextEditingController(
      text: Api.User_info["Table"][0]["OrgAddress"] ?? "");

  var Template_con = TextEditingController(
      text: Api.User_info["Table"][0]["AdsTemplate"].toString());
  var Balance_con = TextEditingController(
      text: Api.User_info["Table"][0]["SmsBalance"].toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Basic Information',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontmain',
          ),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            spacing: 15,
            children: [
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: nam_con,
                  decoration: InputDecoration(
                    labelText: "Owner Name",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4A68B)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: B_nam_con,
                  decoration: InputDecoration(
                    labelText: "Business Name",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4A68B)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: mob_con,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    // Default label color
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    // Label color when focused
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xffC4A68B),
                          width: 2), // Border color when focused
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly // Only numbers
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: alt_mob_con,
                  decoration: InputDecoration(
                    labelText: "Alternate Mobile Number",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    // Default label color
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    // Label color when focused
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xffC4A68B),
                          width: 2), // Border color when focused
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly // Only numbers
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: email_con,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4A68B)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: state_con,
                  decoration: InputDecoration(
                    labelText: "State",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4A68B)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: city_con,
                  decoration: InputDecoration(
                    labelText: "City",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4A68B)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: loc_con,
                  decoration: InputDecoration(
                    labelText: "Locality Area",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4A68B)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: address_con,
                  decoration: InputDecoration(
                    labelText: "Address",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4A68B)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: Template_con,
                  decoration: InputDecoration(
                    labelText: "Ads Template",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4A68B)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: Balance_con,
                  decoration: InputDecoration(
                    labelText: "Balance",
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffC4A68B)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationInformationPage extends StatefulWidget {
  @override
  State<RegistrationInformationPage> createState() =>
      _RegistrationInformationPageState();
}

class _RegistrationInformationPageState
    extends State<RegistrationInformationPage> {
  var gst_no_con = TextEditingController();

  var other_lic_con = TextEditingController();

  var fss_con = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    bool c1 = false;
    bool c2 = false;
    bool c3 = false;
    if (Api.User_info["Table"][0]["FassiLicNo"] != null) {
      fss_con.text = Api.User_info["Table"][0]["FassiLicNo"];
      c3 = true;
    }
    if (Api.User_info["Table"][0]["nigamlicanceNo"] != null) {
      other_lic_con.text = Api.User_info["Table"][0]["nigamlicanceNo"];
      c2 = true;
    }
    if (Api.User_info["Table"][0]["GSTNo"] != null) {
      gst_no_con.text = Api.User_info["Table"][0]["GSTNo"];
      c1 = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Business Info',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontmain',
          ),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  IgnorePointer(
                    ignoring: c1,
                    child: TextFormField(
                      controller: gst_no_con,
                      decoration: InputDecoration(
                        labelText: "GST No",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontFamily: 'sub-tittle',
                          fontSize: 14,
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC4A68B)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  IgnorePointer(
                    ignoring: c2,
                    child: TextFormField(
                      controller: other_lic_con,
                      decoration: InputDecoration(
                        labelText: "Other License",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontFamily: 'sub-tittle',
                          fontSize: 14,
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC4A68B)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  IgnorePointer(
                    ignoring: c3,
                    child: TextFormField(
                      controller: fss_con,
                      decoration: InputDecoration(
                        labelText: "FSSAI",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontFamily: 'sub-tittle',
                          fontSize: 14,
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffC4A68B)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (Api.User_info["Table"][0]["FassiLicNo"] == null ||
                      Api.User_info["Table"][0]["GSTNo"] == null ||
                      Api.User_info["Table"][0]["RegNo"] == null)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffC4A68B),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          minimumSize: Size(550, 45),
                        ),
                        onPressed: () {
                          if (fss_con.text.isNotEmpty &&
                                  gst_no_con.text.isNotEmpty
                              // &&other_lic_con.text.isNotEmpty
                              ) {
                            setState(() {
                              loading = true;
                            });
                            Api.MerchentLicanceDetail(
                                    FassiLicNo: fss_con.text.trim(),
                                    Gst: gst_no_con.text.trim(),
                                    nigamlicanceNo: other_lic_con.text.trim())
                                .then(
                              (value) {
                                if (value) {
                                  setState(() {
                                    loading = false;
                                  });

                                  Api.Mpin_check(
                                          mob_no: Api.prefs
                                                  .getString("mobile_no") ??
                                              "",
                                          Mpin:
                                              Api.prefs.getString("mpin") ?? "")
                                      .then(
                                    (value) {},
                                  );
                                  Navigator.of(context).pop();
                                  Api.snack_bar(
                                      context: context, message: "Save");
                                } else {
                                  Api.snack_bar(
                                      context: context,
                                      message: "Something Went Wrong");
                                }
                              },
                            );
                          } else {
                            Api.snack_bar(
                                context: context, message: "fill all fields");
                          }
                        },
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Fontmain',
                          ),
                        ))
                ],
              ),
            ),
          ),
          if (loading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class BankInformationPage extends StatelessWidget {
  var bnk_name_con = TextEditingController();
  var acc_holder_name_con = TextEditingController();
  var acc_no_con = TextEditingController();
  var ifsc_code_con = TextEditingController();
  // bool c1 = false;
  // bool c2 = false;
  // bool c3 = false;
  // bool c4 = false;
  // bool c1=false;
  @override
  Widget build(BuildContext context) {
    if (Api.User_info["Table"][0]["Mer_bankName"] != null) {
      bnk_name_con.text = Api.User_info["Table"][0]["Mer_bankName"];
      // c1 = true;
    }
    if (Api.User_info["Table"][0]["Mer_bankAcc"] != null) {
      acc_no_con.text = Api.User_info["Table"][0]["Mer_bankAcc"];
      // c3 = true;
    }
    if (Api.User_info["Table"][0]["Mer_IFSCCode"] != null) {
      ifsc_code_con.text = Api.User_info["Table"][0]["Mer_IFSCCode"];
      // c4 = true;
    }
    if (Api.User_info["Table"][0]["Mer_AcHolderName"] != null) {
      acc_holder_name_con.text = Api.User_info["Table"][0]["Mer_AcHolderName"];
      // c2 = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bank Info',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontmain',
          ),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              TextFormField(
                controller: bnk_name_con,
                decoration: InputDecoration(
                  labelText: "Bank Name",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'sub-tittle',
                  fontSize: 16.0,
                ),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: acc_holder_name_con,
                decoration: InputDecoration(
                  labelText: "Account Holder Name",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'sub-tittle',
                  fontSize: 16.0,
                ),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: acc_no_con,
                // keyboardType: TextInputType.number,
                maxLength: 20,
                decoration: InputDecoration(
                  labelText: "Account Number",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'sub-tittle',
                  fontSize: 16.0,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]'))
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: ifsc_code_con,
                // keyboardType: TextInputType.number,
                maxLength: 11,
                
                decoration: InputDecoration(
                  labelText: "IFSC Code",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'sub-tittle',
                  fontSize: 16.0,
                ),
                // inputFormatters: [
                //   FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]'))
                // ],
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffC4A68B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    minimumSize: Size(650, 45),
                  ),
                  onPressed: () {
                    Api.MerchentBankDetail(
                        Mer_AcHolderName: acc_holder_name_con.text.trim(),
                        Mer_IFSCCode: ifsc_code_con.text.trim(),
                        Mer_bankName: bnk_name_con.text.trim(),
                        Mer_bankAcc: acc_no_con.text.trim());
                    // Api.downloadPdf("https://tourism.gov.in/sites/default/files/2019-04/dummy-pdf_2.pdf", "abc.pdf");
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Fontmain',
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class MMDDOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MMDD Orders',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontmain',
          ),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
          child: Text(
        'No Data Awailable',
        style: TextStyle(fontFamily: 'Fontmain', color: Color(0xe5777474)),
      )),
    );
  }
}

class MyServicesPage extends StatefulWidget {
  @override
  State<MyServicesPage> createState() => _MyServicesPageState();
}

class _MyServicesPageState extends State<MyServicesPage> {
  @override
  List<dynamic> _data = [];
  bool loader = false;
  void refresh() {
    setState(() {
      loader = true;
    });
    _data.clear();
    Api.FacilityReport().then(
      (value) {
        _data = value;
        setState(() {
          loader = false;
        });
      },
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    loader = true;
    _data.clear();
    Api.FacilityReport().then(
      (value) {
        _data = value;
        setState(() {
          loader = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Services',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontmain',
          ),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Stack(
        children: [
          loader
              ? Center(
                  child: Text('No Data Available'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return Api.User_info["Table"][0]["IsEcom"] == true
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor:
                                  const Color.fromARGB(255, 235, 233, 233),
                              leading: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 300,
                                        width: 300,
                                        child: CachedNetworkImage(
                                          imageUrl: _data[index]["FacilityImg"],
                                          errorWidget: (context, url, error) {
                                            return Container(
                                              height: 80,
                                              width: 80,
                                              color: Colors.red,
                                            );
                                          },
                                          progressIndicatorBuilder:
                                              (context, url, progress) {
                                            return CupertinoActivityIndicator();
                                          },
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  // color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                  )),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl: _data[index]["FacilityImg"],
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      height: 80,
                                      width: 80,
                                      color: Colors.red,
                                    );
                                  },
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return CupertinoActivityIndicator();
                                  },
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    );
                                  },
                                ),
                              ),
                              title: Text(
                                _data[index]["FacilityName"],
                                style: TextStyle(
                                    fontFamily: "Fontmain",
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                _data[index]["Amount"].toString(),
                                style: TextStyle(
                                    fontFamily: "Fontmain",
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.all(10),
                            height: 80,
                            // color: Colors.amber,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    color: const Color.fromARGB(146, 0, 0, 0),
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _data[index]["FacilityName"],
                                  style: TextStyle(
                                      fontFamily: "Fontmain",
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _data[index]["Amount"].toString(),
                                  style: TextStyle(
                                      fontFamily: "Fontmain",
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                          );
                  },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddService(
                      refresh: refresh,
                    )),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(50), // Adjust the value for desired radius
        ),
        backgroundColor: Color(0xffC4A68B),
      ),
    );
  }
}

class AddService extends StatefulWidget {
  Function refresh;
  AddService({required this.refresh});
  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  String? _selectedValue;
  var amount_con = TextEditingController();
  var service_con = TextEditingController();
  var service_name_con = TextEditingController();
  String? _selectedCategory;
  List<dynamic> _data = [];
  int? selectted_service_id;
  @override
  void initState() {
    loading = true;
    // TODO: implement initState
    super.initState();
    Api.service(Api.User_info["Table"][0]["ServiceID"].toString()).then(
      (value) {
        _data = value;
        setState(() {
          loading = false;
        });
      },
    );
  }

  File? _image;
  String ext = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Service',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontmain',
          ),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            spacing: 15,
            children: [
              // const SizedBox(height: 15),
              if (Api.User_info["Table"][0]["IsEcom"] == true)
                GestureDetector(
                  onTap: () {
                    Api.pickImage(source: ImageSource.gallery, img: true).then(
                      (value) {
                        setState(() {
                          _image = value["file"];
                          ext = value["ext"];
                        });
                      },
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 600,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                            image: _image != null
                                ? FileImage(_image!)
                                : AssetImage("assets/images/main/img.jpg"),
                            fit: BoxFit.fill)),
                  ),
                ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                // iconSize: 20,
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Business Category',
                ),

                onChanged: (String? newValue) async {
                  int index = _data!
                      .indexWhere((map) => map['SubCategoryName'] == newValue);
                  setState(() {
                    _selectedCategory = newValue!;
                    selectted_service_id = index;
                  });
                },
                items: _data!.map<DropdownMenuItem<String>>((var value) {
                  return DropdownMenuItem<String>(
                    value: value["SubCategoryName"] ?? "",
                    child: Text(value["SubCategoryName"] ?? ""),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: service_name_con,
                decoration: InputDecoration(
                  labelText: "Service Name",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'sub-tittle',
                  fontSize: 16.0,
                ),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
              ),
              TextFormField(
                controller: amount_con,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Service Amount",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'sub-tittle',
                  fontSize: 16.0,
                ),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
              ),
              // const SizedBox(height: 15),
              TextFormField(
                controller: service_con,
                decoration: InputDecoration(
                  labelText: "Service Details",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'sub-tittle',
                  fontSize: 16.0,
                ),
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
              ),
              // const SizedBox(height: 15),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffC4A68B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    minimumSize: Size(650, 45),
                  ),
                  onPressed: () async {
                    if (Api.User_info["Table"][0]["IsEcom"] == true) {
                      // List<int> fileBytes = await _image!.readAsBytes();
                      // String base64File = base64Encode(fileBytes);
                      Api.FacilityInsert(
                        Amount: amount_con.text.trim(),
                        Description: service_con.text.trim(),
                        F_SubServiceCategory: selectted_service_id.toString(),
                        FacilityName: service_name_con.text.trim(),
                        ext: "." + ext ?? "",
                        img: _image,
                        context: context,
                      ).then(
                        (value) {
                          widget.refresh();
                          Navigator.of(context).pop();
                        },
                      );
                    } else {
                      Api.FacilityInsert_nonimg(
                        Amount: amount_con.text.trim(),
                        Description: service_con.text.trim(),
                        F_SubServiceCategory: selectted_service_id.toString(),
                        FacilityName: service_name_con.text.trim(),
                        // FacilityImg: base64File
                      ).then(
                        (value) {
                          if (value) {
                            widget.refresh();
                            Navigator.of(context).pop();
                          }
                        },
                      );
                    }
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Fontmain',
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessCategoryPage extends StatelessWidget {
  const BusinessCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TermsAndConditionsPage extends StatefulWidget {
  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  var terms_con = TextEditingController();
  bool loader = false;
  Map _data = {};
  @override
  void initState() {
    loader = true;
    // TODO: implement initState
    super.initState();
    Api.get_Merchent_Trem_And_Condition().then(
      (value) {
        _data = value;
        terms_con.text = _data["Table1"][0]["TermsAndConditions"] ?? "";
        setState(() {
          loader = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Terms',
          style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      TextField(
                        controller: terms_con,
                        // maxLength: 1000,
                        // onChanged: (value) {
                        //   setState(() {

                        //   });
                        // },
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Write your Terms & Conditions...",
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        style: TextStyle(fontFamily: 'sub-tittle'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffC4A68B),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            minimumSize: Size(550, 50),
                          ),
                          onPressed: () {
                            setState(() {
                              loader = true;
                            });
                            Api.Add_Merchant_TremAndCond(
                                    TermsAndConditions: terms_con.text)
                                .then(
                              (value) {
                                if (value) {
                                  setState(() {
                                    loader = false;
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                            );
                          },
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Fontmain',
                            ),
                          ))
                    ],
                  ),
                ),
                Text(loader
                    ? ""
                    : _data["Table1"][0]["TermsAndConditions"] ?? ""),
              ],
            ),
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

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<dynamic> _data = [];
  bool loader = false;
  @override
  void initState() {
    loader = true;
    // TODO: implement initState
    super.initState();
    Api.GetMerchentcustomerReview().then(
      (value) {
        setState(() {
          _data = value;
          loader = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Review',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontmain',
          ),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Stack(
        children: [
          loader
              ? Center(
                  child: Text(
                  'Review Content',
                  style: TextStyle(
                      fontFamily: 'Fontmain', color: Color(0xe5777474)),
                ))
              : _data.isEmpty
                  ? Container(
                      height: 120,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(146, 0, 0, 0),
                                blurRadius: 3,
                                offset: Offset(0, 0))
                          ]),
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            minLeadingWidth: 20,
                            contentPadding: EdgeInsets.all(5),
                            // enabled: ,
                            horizontalTitleGap: 10,
                            leading: Icon(
                              Icons.account_box_outlined,
                              size: 40,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "CustomerName",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                RatingBar.builder(
                                  initialRating: 5,
                                  // minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color:
                                        const Color.fromARGB(255, 7, 255, 255),
                                  ),
                                  onRatingUpdate: (rating) {
                                    // setState(() {
                                    //   // _rating = rating;
                                    // });
                                    print("Selected rating: $rating");
                                  },
                                ),
                              ],
                            ),
                            subtitle: Text("CustomerRemark",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 61, 61, 61))),
                          ),
                          Text("MembarRemark",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 151, 151, 151)))
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.5, horizontal: 5),
                      itemCount: _data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(146, 0, 0, 0),
                                blurRadius: 3,
                                offset: Offset(0, 0))
                          ]),
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                minLeadingWidth: 20,
                                contentPadding: EdgeInsets.all(5),
                                // enabled: ,
                                horizontalTitleGap: 10,
                                leading: Icon(
                                  Icons.account_box_outlined,
                                  size: 40,
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _data[index]["CustomerName"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RatingBar.builder(
                                      initialRating: _data[index]["Rating"],
                                      // minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: const Color.fromARGB(
                                            255, 7, 255, 255),
                                      ),
                                      onRatingUpdate: (rating) {
                                        // setState(() {
                                        //   // _rating = rating;
                                        // });
                                        print("Selected rating: $rating");
                                      },
                                    ),
                                  ],
                                ),
                                subtitle: Text(_data[index]["CustomerRemark"],
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 61, 61, 61))),
                              ),
                              Text(_data[index]["MembarRemark"],
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 151, 151, 151)))
                            ],
                          ),
                        );
                      },
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

class PhoneDiary extends StatefulWidget {
  @override
  State<PhoneDiary> createState() => _PhoneDiaryState();
}

class _PhoneDiaryState extends State<PhoneDiary> {
  bool loader = false;
  List<dynamic> _data = [];
  @override
  void initState() {
    loader = true;
    // TODO: implement initState
    super.initState();
    Api.Merchentwisecustomer().then(
      (value) {
        _data = value;
        setState(() {
          loader = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phone Diary',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontmain',
          ),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Stack(
        children: [
          loader
              ? Center(
                  child: Text(
                    'No Data Awailable',
                    style: TextStyle(
                        fontFamily: 'Fontmain', color: Color(0xe5777474)),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  itemCount: _data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // return Container(
                    //   margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(color: const Color.fromARGB(139, 0, 0, 0),blurRadius: .5, offset: Offset(0, 0))]),
                    //   child: ListTile(
                    //     dense: true,
                    //     minLeadingWidth: 20,
                    //     leading: CircleAvatar(radius: 25,backgroundImage: AssetImage("assets/images/main/user.png"),),
                    //     title: Text(_data[index]["CustomerName"],style: TextStyle(fontFamily: "Fontmain"),),
                    //     subtitle: Text(_data[index]["MobileNo"],),
                    //     trailing: GestureDetector(
                    //       onTap: (){
                    //         Api.launchDialer(_data[index]["MobileNo"]);
                    //       },
                    //       child: Icon(Icons.phone)),
                    //   ),
                    // );
                    return Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(139, 0, 0, 0),
                                blurRadius: .5,
                                offset: Offset(0, 0))
                          ]),
                      child: Column(
                        spacing: 10,
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              Icon(Icons.account_box),
                              Text(_data[index]["CustomerName"],
                                  style: TextStyle(fontFamily: "Fontmain"))
                            ],
                          ),
                          Row(
                            spacing: 10,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Api.launchDialer(_data[index]["MobileNo"]);
                                  },
                                  child: Icon(Icons.phone)),
                              Text(_data[index]["MobileNo"],
                                  style: TextStyle(fontFamily: "Fontmain"))
                            ],
                          )
                        ],
                      ),
                    );
                  },
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

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Contact Us',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Fontmain',
            ),
          ),
          backgroundColor: Color(0xffC4A68B),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(148, 0, 0, 0),
                        offset: Offset(0, 0),
                        blurRadius: 5)
                  ],
                  color: Colors.white),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Call Us : 18005700102",
                    style: TextStyle(fontFamily: "Fontmain", fontSize: 15),
                  ),
                  IconButton(
                      onPressed: () {
                        Api.launchDialer("18005700102");
                      },
                      icon: Icon(Icons.phone))
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(148, 0, 0, 0),
                        offset: Offset(0, 0),
                        blurRadius: 5)
                  ],
                  color: Colors.white),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mail Us :",
                            style: TextStyle(
                                fontFamily: "Fontmain", fontSize: 15)),
                        Text("suport@makemydreamday.in",
                            style:
                                TextStyle(fontFamily: "Fontmain", fontSize: 15))
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Api.openEmail(
                            toEmail: "suport@makemydreamday.in",
                            body: "",
                            subject: "");
                      },
                      icon: Icon(Icons.mail))
                ],
              ),
            )
          ],
        ));
  }
}

class LogOutPage extends StatefulWidget {
  @override
  State<LogOutPage> createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  bool loader = false;

  var mob_con = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(Api.prefs.getBool('login'));
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
                  height: 300,
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFDAB89B),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Enter Mobile Number for login.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 24),
                      TextField(
                        controller: mob_con,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          // errorBorder: OutlineInputBorder(),
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (mob_con.text.isNotEmpty) {
                              if (mob_con.text.length == 10) {
                                setState(() {
                                  loader = true;
                                });
                                if (loader) {
                                  bool check_user =
                                      await Api.mob_check(mob_con.text.trim());
                                  if (!check_user) {
                                    await Api.send_otp(
                                        mob_con.text.trim(), context);
                                    // await Api.send_otp(mob_con.text.trim());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OtpPage(
                                                  mob_no: mob_con.text,
                                                  priv_screen: "Log_In_Screen",
                                                )));
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MpinPage(
                                                  mob_no: mob_con.text.trim(),
                                                )));
                                  }
                                }
                                setState(() {
                                  loader = false;
                                });
                              } else {
                                Api.snack_bar(
                                    context: context,
                                    message:
                                        "Please enter proper phone number");
                              }
                            } else {
                              Api.snack_bar(
                                  context: context,
                                  message: "Please enter phone number");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 64, vertical: 16),
                          ),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
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
