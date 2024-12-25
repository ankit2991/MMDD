import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mddmerchant/constrans.dart';
import 'package:mddmerchant/App_bar/OurService/our_service.dart';
import 'package:mddmerchant/main.dart';
import 'package:mddmerchant/screen/Mpinpage.dart';
import 'package:mddmerchant/screen/otp.dart';
import 'dart:developer' as developer;
import "../api/api.dart";
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserProfile extends StatelessWidget {
  @override
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
            Api.moveFileToLocalStorage();
            // Navigator.pop(context);
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
                CircleAvatar(
                  radius: 50,
                  backgroundColor: mainColor,
                  // Profile picture placeholder
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                 Api.User_info["Table"][0]["MemberName"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  Api.User_info["Table"][0]["MobileNo"],
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          // Profile Options List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                ProfileOption(
                    title: "Account Document", page: BasicInformationPage()),
                ProfileOption(
                    title: "Basic Information", page: BasicInformationPage()),
                ProfileOption(
                    title: "Registration Information",
                    page: RegistrationInformationPage()),
                ProfileOption(
                    title: "Bank Information", page: BankInformationPage()),
                ProfileOption(title: "MMDD Orders", page: MMDDOrdersPage()),
                ProfileOption(title: "My Services", page: MyServicesPage()),
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
          onTap: () async{
            await Api.prefs.setBool('login',false).then((value) {
              print(Api.prefs.getBool('login'));
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
            },);
            // Navigate to the selected page
            
          },
        ),
      ),
    );
  }
}

// Example pages
class BasicInformationPage extends StatelessWidget {
  var nam_con=TextEditingController(text: Api.User_info["Table"][0]["MemberName"]);
  var B_nam_con=TextEditingController(text: Api.User_info["Table"][0]["OrgName"]);
  var mob_con=TextEditingController(text: Api.User_info["Table"][0]["MobileNo"]);
  var alt_mob_con=TextEditingController(text: Api.User_info["Table"][0]["OtherMobileNo"]);
  var email_con=TextEditingController(text: Api.User_info["Table"][0]["EmailId"]);
  var state_con=TextEditingController(text: Api.User_info["Table"][0]["StateName"]);
  var city_con=TextEditingController(text: Api.User_info["Table"][0]["CityName"]);
  var loc_con=TextEditingController(text: Api.User_info["Table"][0]["AreaName"]);
  var address_con=TextEditingController(text: Api.User_info["Table"][0]["OrgAddress"]);
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
                      borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
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
                      borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
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
                      borderSide:
                          BorderSide(color: Colors.grey), // Default border color
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
                      borderSide:
                          BorderSide(color: Colors.grey), // Default border color
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
                      borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
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
                      borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
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
                      borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
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
                      borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
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

class RegistrationInformationPage extends StatelessWidget {
  var gst_no_con=TextEditingController();
  var other_lic_con=TextEditingController();
  var fss_con=TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool c1=false;
    bool c2=false;
    bool c3=false;
    if (Api.User_info["Table"][0].containsKey("FassiLicNo")) {
      fss_con.text=Api.User_info["Table"][0]["FassiLicNo"];
      c3=true;
    }if(Api.User_info["Table"][0].containsKey("nigamlicanceNo")) {
            other_lic_con.text=Api.User_info["Table"][0]["nigamlicanceNo"];
            c2=true;

    }if(Api.User_info["Table"][0].containsKey("GSTNo")){
        gst_no_con.text=Api.User_info["Table"][0]["GSTNo"];
        c1=true;
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
      body: SingleChildScrollView(
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
              ),
              const SizedBox(height: 15),
              if(Api.User_info["Table"][0].containsKey("FassiLicNo")!=true||Api.User_info["Table"][0].containsKey("GSTNo")!=true|| Api.User_info["Table"][0].containsKey("RegNo")!=true&&Api.User_info["Table"][0]["RegNo"]!=null)
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffC4A68B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    minimumSize: Size(550, 45),
                  ),
                  onPressed: () {
                    if(fss_con.text.isNotEmpty&& gst_no_con.text.isNotEmpty&&other_lic_con.text.isNotEmpty){
                    Api.MerchentLicanceDetail(FassiLicNo:fss_con.text.trim(),Gst: gst_no_con.text.trim(),nigamlicanceNo: other_lic_con.text.trim()).then((value) {
                      if (value) {
                        Navigator.of(context).pop();
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error :- ")));
                      }
                    },);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("fill all fields ",style: TextStyle(color: Colors.red),)));
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

class BankInformationPage extends StatelessWidget {
  var bnk_name_con=TextEditingController();
  var acc_holder_name_con=TextEditingController();
  var acc_no_con=TextEditingController();
  var ifsc_code_con=TextEditingController();
  bool c1=false;
  bool c2=false;
  bool c3=false;
  bool c4=false;
  // bool c1=false;
  @override
  Widget build(BuildContext context) {
    if (Api.User_info["Table"][0]["Mer_bankName"]!=null) {
      bnk_name_con.text=Api.User_info["Table"][0]["Mer_bankName"];
      c1=true;
    }
    if (Api.User_info["Table"][0]["Mer_bankAcc"]!=null) {
      acc_no_con.text=Api.User_info["Table"][0]["Mer_bankAcc"];
      c3=true;
    }
    if (Api.User_info["Table"][0]["Mer_IFSCCode"]!=null) {
      ifsc_code_con.text=Api.User_info["Table"][0]["Mer_IFSCCode"];
      c4=true;
    }
    if (Api.User_info["Table"][0]["Mer_AcHolderName"]!=null) {
      acc_holder_name_con.text=Api.User_info["Table"][0]["Mer_AcHolderName"];
      c2=true;
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
              IgnorePointer(
                ignoring: c1,
                child: TextFormField(
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
              ),
              const SizedBox(height: 15),
              IgnorePointer(
                ignoring: c2,
                child: TextFormField(
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
              ),
              const SizedBox(height: 15),
              IgnorePointer(
                ignoring: c3,
                child: TextFormField(
                  controller:acc_no_con ,
                  keyboardType: TextInputType.number,
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
              ),
              const SizedBox(height: 15),
              IgnorePointer(
                ignoring: c4,
                child: TextFormField(
                  controller: ifsc_code_con,
                  keyboardType: TextInputType.number,
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]'))
                  ],
                ),
              ),
              const SizedBox(height: 15),
              if(Api.User_info["Table"][0]["Mer_bankName"]==null||Api.User_info["Table"][0]["Mer_bankAcc"]==null||Api.User_info["Table"][0]["Mer_IFSCCode"]==null||Api.User_info["Table"][0]["Mer_AcHolderName"]==null)
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffC4A68B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    minimumSize: Size(650, 45),
                  ),
                  onPressed: () {
                    Api.MerchentBankDetail(Mer_AcHolderName: acc_holder_name_con.text.trim(),Mer_IFSCCode: ifsc_code_con.text.trim(),Mer_bankName: bnk_name_con.text.trim(),Mer_bankAcc:acc_no_con.text.trim() );
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

class MyServicesPage extends StatelessWidget {
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
      body: Center(
        child: Text('No Data Available'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddService()),
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

class AddService extends StatelessWidget {
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
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Service Category",
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
              const SizedBox(height: 15),
              TextFormField(
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
              const SizedBox(height: 15),
              TextFormField(
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
              const SizedBox(height: 15),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffC4A68B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    minimumSize: Size(650, 45),
                  ),
                  onPressed: () {},
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

class TermsAndConditionsPage extends StatelessWidget {
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            TextField(
              maxLength: 1000,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write your Terms & Conditions...",
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              style: TextStyle(fontFamily: 'sub-tittle'),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffC4A68B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  minimumSize: Size(550, 50),
                ),
                onPressed: () {},
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
    );
  }
}

class ReviewPage extends StatelessWidget {
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
      body: Center(
          child: Text(
        'Review Content',
        style: TextStyle(fontFamily: 'Fontmain', color: Color(0xe5777474)),
      )),
    );
  }
}

class PhoneDiary extends StatelessWidget {
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
      body: Center(
          child: Text(
        'No Data Awailable',
        style: TextStyle(fontFamily: 'Fontmain', color: Color(0xe5777474)),
      )),
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
      body: Center(
          child: Text(
        'No Data Awailable',
        style: TextStyle(fontFamily: 'Fontmain', color: Color(0xe5777474)),
      )),
    );
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
                        decoration: InputDecoration(
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
                            setState(() {
                              loader = true;
                            });
                            if (loader) {
                              bool check_user =
                                  await Api.mob_check(mob_con.text.trim());
                              if (!check_user) {
                                await Api.send_otp(mob_con.text.trim());
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
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding:
                                EdgeInsets.symmetric(horizontal: 64, vertical: 16),
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
