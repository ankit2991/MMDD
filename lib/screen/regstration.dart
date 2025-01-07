import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mddmerchant/App_bar/user_acc.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/main.dart';
import 'package:mddmerchant/screen/terms_and_condation.dart';

class RegisTration extends StatefulWidget {
  String Mob;
  RegisTration({required this.Mob});
  @override
  _CheckboxExampleState createState() => _CheckboxExampleState();
}

List? _Category = <Map<String, dynamic>>[];
String? _selectedCategory = null;

final List _SubCategory = <Map<String, dynamic>>[];
String? _selectedSubCategory = null;

// final _syState = <Map<String, dynamic>>[];
String? _selectedState = null; // Default selected language
String? _selectedSyCity = null;

class _CheckboxExampleState extends State<RegisTration> {
  bool isChecked = false;

  // final List<String> _Sycity = ['Jodhpur', 'Barmer'];
  var name_con = TextEditingController();
  var Bus_name_con = TextEditingController();
  var mob_no_con = TextEditingController();
  var Alt_mob_no_con = TextEditingController();
  var email_con = TextEditingController();
  var locality_Area_con = TextEditingController();
  var address_con = TextEditingController();
  var B_location_con = TextEditingController();
  var M_pin_con = TextEditingController();
  var ref_code_con = TextEditingController();
  bool loader=false;
  void loding (bool a){
    setState(() {
      loader=a;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Api.CategoryList_data.clear();
    _Category!.clear();
    _selectedCategory = null;
    _selectedSubCategory = null;
    loader=true;
    Api.CategoryList().then(
      (value) {
        for (var i = 0; i < Api.CategoryList_data.length; i++) {
          _Category!.add({
            "ID": Api.CategoryList_data[i]["ID"],
            "ServiceName": Api.CategoryList_data[i]["ServiceName"]
          });
        }
        setState(() {});
        Api.StateList().then(
          (value) {
            setState(() {});
            Api.CityList().then(
              (value) {
                setState(() {
                  loader=false;
                });
              },
            );
          },
        );
      },
    );
  }

  int Business_category_index = -1;
  int Business_Sub_category_index = 1;
  int State_index = -1;
  int city_index = -1;
  String? lett;
  String? lott;
    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    mob_no_con.text = widget.Mob;

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                       validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Please enter Name";
                  }
                  },
                      controller: name_con,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        labelText: "Name",
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
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: Bus_name_con,
                           validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Please enter Business Name";
                  }
                  },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
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
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      // iconSize: 20,
                           validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Please Select Business Category";
                  }
                  },
                      isExpanded: true,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        labelText: 'Business Category',
                      ),
                
                      onChanged: (String? newValue) async {
                        setState(() {
                        loader=true;
                          
                        });
                        int index = _Category!
                            .indexWhere((map) => map['ServiceName'] == newValue);
                        Business_category_index = index;
                
                        setState(() {
                          _selectedCategory = newValue!;
                          _selectedSubCategory = null;
                          // print(_Category![index].toString());
                        });
                
                        print(Api.CategoryList_data![index]["ID"].toString());
                        _SubCategory.clear();
                        await Api.Sub_CategoryList(
                                id: _Category![index]["ID"].toString())
                            .then(
                          (value) {
                            for (var i = 0;
                                i < Api.Sub_CategoryList_data.length;
                                i++) {
                              _SubCategory!.add({
                                "ID": Api.Sub_CategoryList_data[i]["ID"],
                                "SubCategoryName": Api.Sub_CategoryList_data[i]
                                    ["SubCategoryName"]
                              });
                            }
                          },
                        );
                        setState(() {
                          loader=false;
                        });
                      },
                      items: _Category!.map<DropdownMenuItem<String>>((var value) {
                        return DropdownMenuItem<String>(
                          value: value["ServiceName"] ?? "",
                          child: Text(value["ServiceName"] ?? ""),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _selectedSubCategory,
                           validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Please Select Business SubCategory";
                  }
                  },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        labelText: 'Business SubCategory',
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSubCategory = newValue!;
                          int index = Api.Sub_CategoryList_data!
                              .indexWhere((map) => map['ServiceName'] == newValue);
                          Business_Sub_category_index = index;
                        });
                      },
                      items: Api.Sub_CategoryList_data.map<DropdownMenuItem<String>>(
                          (var value) {
                        return DropdownMenuItem<String>(
                          value: value["ServiceName"],
                          child: Text(value["ServiceName"]),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 15),
                    IgnorePointer(
                      ignoring: true,
                      child: TextFormField(
                        controller: mob_no_con,
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
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: Alt_mob_no_con,
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
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        // _formKey.currentState!.validate();
                      },
                      controller: email_con,
                           validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Enter Email";
                  }else if(value.isEmail==false){
                    return "Invalid Email";

                  }
                  },
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
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedState,
                           validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Please select State";
                  }
                  },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        labelText: 'State',
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedState = newValue!;
                          int index = Api.state_list!
                              .indexWhere((map) => map['Name'] == newValue);
                          State_index = index;
                        });
                      },
                      items:
                          Api.state_list.map<DropdownMenuItem<String>>((var value) {
                        return DropdownMenuItem<String>(
                          value: value["Name"],
                          child: Text(value["Name"]),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedSyCity,
                           validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Please Select City";
                  }
                  },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        labelText: 'City',
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSyCity = newValue!;
                          int index = Api.city_list!
                              .indexWhere((map) => map['Name'] == newValue);
                          city_index = index;
                        });
                      },
                      items: Api.city_list.map<DropdownMenuItem<String>>((var value) {
                        return DropdownMenuItem<String>(
                          value: value["Name"],
                          child: Text(value["Name"]),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                           validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Please enter Locality Area";
                  }
                  },
                      controller: locality_Area_con,
                      decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
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
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: address_con,
                           validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Please enter Address";
                  }
                  },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
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
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          loader=true;
                        });
                        print("object");
                        Api.get_loc(context,loding).then(
                          (value) {
                            print("----------------------");
                            log("${value.latitude}");
                            print("----------------------");
                            log("${value.longitude}");
                            print("----------------------");
                            lett = value.latitude.toString();
                            lott = value.longitude.toString();
                            String address = "${value.latitude},${value.longitude}";
                            B_location_con.text = address;
                            setState(() {
                              loader=false;
                            });
                          },
                        );
                      },
                      child: IgnorePointer(
                        ignoring: true,
                        child: TextFormField(
                               validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Please Set Your Bussiness Location";
                  }
                  },
                          controller: B_location_con,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                            labelText: "Set Your Bussiness Location",
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
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      maxLength: 6,
                           validator: (value) {
                     if (value == null || value.isEmpty) {
                    return "Please Enter 6 Digit for create MPIN";
                  }
                  },
                      controller: M_pin_con,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        labelText: "Enter 6 Digit for create MPIN",
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
                      //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                      // ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: ref_code_con,
                      decoration: InputDecoration(
                        labelText: "Referal Code",
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
                      //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                      // ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isChecked,
                          isError: isChecked?false:true,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                              if (isChecked) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => read_TermsAndConditation(),));                                
                              }
                            });
                          },
                          activeColor: Color(0xffC4A68B),
                        ),
                        Text(
                          'I Agree Terms & Conditions',
                          style: TextStyle(fontFamily: 'Fontmain'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC4A68B),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // 30px rounded corners
                        ),
                        minimumSize: Size(650, 50),
                      ),
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {
                          if (isChecked) {
                            print(Api.CategoryList_data[Business_category_index]["ID"]);
                        print(Api.Sub_CategoryList_data[Business_Sub_category_index]
                            ["ID"]);
                        print((Api.state_list[State_index]["Id"]).toString());
                        print((Api.city_list[city_index]["Id"]).toString());
                
                      String result=await  Api.MerchantRegistration(
                          BName: Bus_name_con.text.trim(),
                          MName: name_con.text.trim(),
                          CityId:Api.city_list[city_index]["Id"].round().toString().trim(),
                          email: email_con.text.trim(),
                          MPin: M_pin_con.text.trim(),
                          F_SubServiceCategory: Api.Sub_CategoryList_data[Business_Sub_category_index]["ID"].toString().trim(),
                          ServiceId: Api.CategoryList_data[Business_category_index]["ID"].toString().trim(),
                          Latitude:lett.toString().trim(),
                          Longitude: lott.toString().trim(),
                          StateId:  Api.state_list[State_index]["Id"].round().toString().trim(),
                          mobile: mob_no_con.text.trim(),
                          othermobileno: Alt_mob_no_con.text.trim(),
                          IsMasterReferCode: ref_code_con.text.trim(),
                          AreaId: locality_Area_con.text.trim(),
                          OrgAddress: address_con.text.trim()
                
                
                        );
                        if (result=="R100") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LogOutPage()));                    
                        }else{
                          Api.snack_bar(context: context, message: "Something Went Wrong");
                        }
                          }
                        }
                      },
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                      ),
                    ),
                  ],
                ),
              ),
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
