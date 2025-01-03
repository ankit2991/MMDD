import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  String ext="";
  String ?Text_color="white";

  // TimeOfDay? _startTime;
  // TimeOfDay? _endTime;
var b_name_con=TextEditingController();
var mob_con=TextEditingController();
var address_con=TextEditingController();
var discount_con=TextEditingController();
// var discount_con=TextEditingController();
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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
                child:  GestureDetector(
                  onTap: ()async{
                    print("object");
                 
                  },
                  child: Container(
                    height: 200,
                    width: 600,                   
                    decoration: BoxDecoration( color: Colors.grey,
                      image: DecorationImage(image:_image != null ? FileImage(_image!):AssetImage("assets/images/main/img.jpg"),fit: BoxFit.fill)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          if(discount_con.text.isNotEmpty)
                            Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: 60,
                             decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/main/discount.png"))),
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text("${discount_con.text}%\nOFF",style: TextStyle(color:Text_color=="black"? Colors.black:Colors.white,fontFamily: "Fontmain"),),
                                
                               ],
                             ),
                            ),
                          Container(
                            child: Column(
                              children: [
                                if(mob_con.text.isNotEmpty)
                                  Text(mob_con.text,style: TextStyle(color: Text_color=="black"? Colors.black:Colors.white,fontFamily: "Fontmain")),
                                if(address_con.text.isNotEmpty)
                                  Text(address_con.text,style: TextStyle(color:Text_color=="black"? Colors.black:Colors.white,fontFamily: "Fontmain")),
                              ],
                            ),
                          )
                          
                            
                            
                        ],)
                        ,
                        if(b_name_con.text.isNotEmpty)
                          Text(b_name_con.text,style: TextStyle(color: Text_color=="black"? Colors.black:Colors.white,fontFamily: "Fontmain")),
                        if( _startDate != null&&_endDate != null)
                          Text("Valid:${_startDate!.toLocal()}".split(' ')[0]+" To "+"${_endDate!.toLocal()}".split(' ')[0],style: TextStyle(color: Text_color=="black"? Colors.black:Colors.white,fontFamily: "Fontmain")),
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
                SizedBox(
                  height: 15,
                ),
                TextFormField(
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
                SizedBox(
                  height: 15,
                ),
                TextFormField(
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
                        Api.pickImage(source: ImageSource.gallery,img: true).then((value) {
                    setState(() {
                      _image=value["file"];
                      ext=value["ext"];
                    });
                  },);
                    },
                    child: Text(
                      'SELECT BACKGROUND IMAGE',
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
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, true),
                    ),
                    labelText: "Event Start Date",
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
                        ? "${_startDate!.toLocal()}".split(' ')[0]
                        : '',
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, false),
                    ),
                    labelText: "Event End Date",
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
                        ? "${_endDate!.toLocal()}".split(' ')[0]
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
                               title: Text('white'),
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
                               title: Text('black'),
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
                      
setState(() {
  
});
                      // img_convert(_image);
                    },
                    child: Text(
                      'GENERATE AD',
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
                      Api.widget_to_img(_globalKey).then((value) {
                       Api.ImageInsert(img: value,DocType: "3",ext: "."+ext,MemberAgreementUpload_UploadFile2:"UploadFile2",context: context ).then((value) {
                         widget.refresh();
                         Navigator.of(context).pop();
                       },);
                        
                      },);
                    },
                    child: Text(
                      'UPLOAD AD',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Fontmain'),
                    ))
              ],
            )),
      ),
    );
  }
}
