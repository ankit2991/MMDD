import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:mddmerchant/api/api.dart';

class CreateProAds extends StatefulWidget {
  Function refresh;
  CreateProAds({required this.refresh});
  @override
  _CreateProAdsState createState() => _CreateProAdsState();
}

class _CreateProAdsState extends State<CreateProAds> {
  DateTime? _startDate;
  DateTime? _endDate;
  String ext = "";
  String? Text_color = "white";

  // TimeOfDay? _startTime;
  // TimeOfDay? _endTime;
  var b_name_con = TextEditingController();
  var mob_con = TextEditingController();
  var address_con = TextEditingController();
  var discount_con = TextEditingController();
// var discount_con=TextEditingController();
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

//  Future<void> _selectDate(
//                         BuildContext context, bool isStart) async {
//                       final DateTime? pickedDate;
//                       if (isStart) {
//                         pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime.now(),
//                           lastDate: DateTime(2100),
//                         );
//                       } else {
//                         pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: _startDate,
//                           firstDate: _startDate ?? DateTime.now(),
//                           lastDate: DateTime(2100),
//                         );
//                       }

//                       if (pickedDate != null) {
//                         if (isStart) {
//                           _startDate = pickedDate;
//                           date_ref.value =
//                               date_ref.value == true ? false : true;
//                         } else {
//                           _endDate = pickedDate;
//                           date_ref.value =
//                               date_ref.value == true ? false : true;
//                         }
//                       }
//                     }

//                     bool dis_read_only = false;
//                     bool dis_date_only = false;
//                     if (bools[index] == true) {
//                       if (_endDate != null) {
//                         if (_endDate!.isBefore(DateTime.now())) {
//                           dis_read_only = false;
//                           dis_date_only = false;
//                         } else {
//                           dis_read_only = true;
//                           dis_date_only = true;
//                         }
//                       }
//                     } else {
//                       dis_read_only = true;
//                       dis_date_only = true;
//                     }
  File? _image;
  final GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Promos & Ads'.tr,
            style: TextStyle(color: Colors.white, fontFamily: 'Fontmain')),
        centerTitle: true,
        backgroundColor: Color(0xffC4A68B),
        elevation: 2.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Change the color of the icon
          iconSize: 30.0, // Adjust the size of the icon
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                RepaintBoundary(
                  key: _globalKey,
                  child: GestureDetector(
                    onTap: () async {
                      print("object");
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
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Column(
                                      children: [
                                        if (mob_con.text.isNotEmpty)
                                          Text(mob_con.text,
                                              style: TextStyle(
                                                  color: Text_color == "black"
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontFamily: "Fontmain")),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              // if(b_name_con.text.isNotEmpty)
                              //   Row(
                              //     children: [

                              //     ],
                              //   ),
                              Column(
                                children: [
                                  if (_startDate != null && _endDate != null)
                                    Text(
                                        "Valid:${DateFormat('dd-MM-yyyy').format(_startDate!)}" +
                                            " To " +
                                            "${DateFormat('dd-MM-yyyy').format(_endDate!)}",
                                        style: TextStyle(
                                            color: Text_color == "black"
                                                ? Colors.black
                                                : Colors.white,
                                            fontFamily: "Fontmain",
                                            fontSize: 10)),
                                  if (address_con.text.isNotEmpty)
                                    Text(address_con.text,
                                        style: TextStyle(
                                            color: Text_color == "black"
                                                ? Colors.black
                                                : Colors.white,
                                            fontFamily: "Fontmain",
                                            fontSize: 10)),
                                ],
                              )
                            ],
                          ),
                          if (discount_con.text.isNotEmpty)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                alignment: Alignment.center,
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/main/discount.png"))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${discount_con.text}%\nOFF",
                                      style: TextStyle(
                                          color: Text_color == "black"
                                              ? Colors.black
                                              : Colors.white,
                                          fontFamily: "Fontmain"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(b_name_con.text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Text_color == "black"
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: "Fontmain",
                                      fontSize: 14))),
                        ],
                      ),
                      //     child: _picker!=null ? Image.file(,fit: BoxFit.contain,)
                      // : Text("No image selected."),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: b_name_con,
                  decoration: InputDecoration(
                    labelText: "Business Name".tr,
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
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: mob_con,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Mobile Number".tr,
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
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.digitsOnly // Only numbers
                  // ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: address_con,
                  decoration: InputDecoration(
                    labelText: "Address".tr,
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
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffC4A68B),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      minimumSize: Size(650, 45),
                    ),
                    onPressed: () {
                      Api.pickImage(source: ImageSource.gallery, img: true)
                          .then(
                        (value) {
                          setState(() {
                            _image = value["file"];
                            ext = value["ext"];
                          });
                        },
                      );
                    },
                    child: Text(
                      'SELECT BACKGROUND IMAGE'.tr,
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Fontmain'),
                    )),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: discount_con,
                  decoration: InputDecoration(
                    labelText: "Discount(%)",
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
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onTap: (){
                     _selectDate(context, true);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, true),
                    ),
                    labelText: "Event Start Date".tr,
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Colors.brown),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  controller: TextEditingController(
                    text: _startDate != null
                        ? "${DateFormat('dd-MM-yyyy').format(_startDate!)}"
                        : '',
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  onTap: (){
                    if(_startDate!=null){
                    _selectDate(context, false);
                    }else{
                      Api.snack_bar(context: context,message:"Select Start Date".tr);
                    }
                    },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                          if(_startDate!=null){
                    _selectDate(context, false);
                    }else{
                      Api.snack_bar(context: context,message:"Select Start Date".tr);
                    }
                      },
                    ),
                    labelText: "Event End Date".tr,
                    labelStyle: TextStyle(
                      color: Color(0xe5777474),
                      fontFamily: 'sub-tittle',
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(color: Colors.brown),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'sub-tittle',
                    fontSize: 16.0,
                  ),
                  controller: TextEditingController(
                    text: _endDate != null
                        ? "${DateFormat('dd-MM-yyyy').format(_endDate!)}"
                            .split(' ')[0]
                        : '',
                  ),
                  readOnly: true,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: 150,
                      // color: Colors.amber,
                      child: ListTile(
                        title: Text('white'.tr),
                        leading: Radio<String>(
                          value: 'white',
                          groupValue: Text_color,
                          onChanged: (String? value) {
                            setState(() {
                              Text_color = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      // color: Colors.amber,
                      child: ListTile(
                        title: Text('black'.tr),
                        leading: Radio<String>(
                          value: 'black',
                          groupValue: Text_color,
                          onChanged: (String? value) {
                            setState(() {
                              Text_color = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffC4A68B),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      minimumSize: Size(650, 45),
                    ),
                    onPressed: () {
                      setState(() {});
                      // img_convert(_image);
                    },
                    child: Text(
                      'GENERATE AD'.tr,
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Fontmain'),
                    )),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffC4A68B),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      minimumSize: Size(650, 45),
                    ),
                    onPressed: () {
                      if (_image != null &&
                          b_name_con.text.isNotEmpty &&
                          mob_con.text.isNotEmpty &&
                          address_con.text.isNotEmpty &&
                          discount_con.text.isNotEmpty &&
                          _endDate != null &&
                          _startDate != null) {
                        Api.widget_to_img(_globalKey).then(
                          (value) {
                            Api.ImageInsert(
                                    img: value,
                                    DocType: "3",
                                    ext: "." + ext,
                                    MemberAgreementUpload_UploadFile2:
                                        "UploadFile2",
                                    context: context)
                                .then(
                              (value) {
                                widget.refresh();
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      } else {
                        Api.snack_bar(
                            context: context,
                            message: "Somthing Went Wrong".tr);
                      }
                    },
                    child: Text(
                      'UPLOAD AD'.tr,
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Fontmain'),
                    ))
              ],
            )),
      ),
    );
  }
}
