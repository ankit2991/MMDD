import 'package:flutter/material.dart';
// import 'package:mddmerchant/constrans.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mddmerchant/api/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OurService(),
    );
  }
}

class OurService extends StatelessWidget {
  final Color mainColor = Colors.brown; // Example main color, adjust as needed.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My AddOn".tr,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontmain',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffC4A68B),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                ProfileOption(title: "Business Category".tr, page: BusiNessCare()),
                ProfileOption(title: "SMS Package".tr, page: send_enquiry(service_name: "SMS Package".tr,)),
                ProfileOption(
                    title: "Advertisement Template".tr, page: send_enquiry(service_name: "Advertisement Template".tr,)),
                ProfileOption(title: "Catalogue Service".tr, page: send_enquiry(service_name:"Catalogue Service".tr ,)),
                ProfileOption(
                    title: "Terms And Conditions".tr, page: send_enquiry(service_name: "Terms And Conditions".tr,)),
                ProfileOption(title: "Accounting Service".tr, page: send_enquiry(service_name:"Accounting Service".tr ,)),
                ProfileOption(title: "GST Registration".tr, page: send_enquiry(service_name:"GST Registration".tr ,)),
                ProfileOption(title: "FSSAI Registration".tr, page: send_enquiry(service_name: "FSSAI Registration".tr,)),
                ProfileOption(
                    title: "Nagar Nigam Registration".tr, page: send_enquiry(service_name: "Nagar Nigam Registration".tr,)),
                ProfileOption(title: "Shop Registration".tr, page: send_enquiry(service_name:"Shop Registration".tr ,)),
                ProfileOption(title: "CA Consulting".tr, page: send_enquiry(service_name: "CA Consulting".tr,)),
                ProfileOption(title: "Website Service".tr, page: send_enquiry(service_name:"Website Service".tr ,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String title;
  final Widget page;

  const ProfileOption({
    required this.title,
    required this.page,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
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
        title: Text(title,
            style: TextStyle(
              fontFamily: 'Fontmain',
            )),
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            // ),
            builder: (BuildContext context) {
              return Container(
                height: (MediaQuery.of(context).size.height/2)-55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  
                  children: [
                    Expanded(
                      child: page,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BusiNessCare extends StatefulWidget {
  @override
  State<BusiNessCare> createState() => _BusiNessCareState();
}

class _BusiNessCareState extends State<BusiNessCare> {
  @override
  bool loader = false;
  List<dynamic> _data = [];
  void initState() {
    loader = true;
    // TODO: implement initState
    super.initState();

    Api.ServiceList().then(
      (value) {
        _data = value;
        setState(() {
          loader = false;
        });
      },
    );
  }

  int? select;
  String select_category="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.4,
        title: Text(
          'Business Category'.tr,
          style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
        ),
        backgroundColor: Color(0xffC4A68B),
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
              ? Center(child: Text('Busines Category'))
              : ListView.builder(
                  padding: EdgeInsets.only(bottom: 80),
                  itemCount: _data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: select == index ? Colors.blueGrey : Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
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
                        title: Text(_data[index]["ServiceName"],
                            style: TextStyle(
                                fontFamily: 'Fontmain',
                                color: select == index
                                    ? Colors.white
                                    : Colors.black)),
                        onTap: () {
                          setState(() {
                            select = index;
                            select_category=_data[index]["ServiceName"];
                          });
                        },
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
      floatingActionButton: GestureDetector(
        onTap: (){
          if (select_category.isNotEmpty) {
          Api.ServiceEnquiryInsert(mobile:Api.User_info["Table"][0]["MobileNo"],personName:Api.User_info["Table"][0]["MemberName"],serviceName: select_category).then((value) {
                            if (value) {
                              Navigator.of(context).pop(); 
                               Api.snack_bar(context: context, message: "Send enquiry");                           
                            }else{
                              Api.snack_bar(context: context, message: "Somthing went wrong");
                            }
                          },);
            
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color:  Color(0xffC4A68B),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                    color: const Color.fromARGB(166, 0, 0, 0), blurRadius: 5, offset: Offset(0, 2))
              ]),
          child: Text("SAVE".tr,style: TextStyle(color: Colors.white,fontFamily: "Fontmain",fontSize: 17),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// class SmsPckage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Busines Category',
//           style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
//         ),
//         backgroundColor: Color(0xffC4A68B),
//         leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//       ),
//       body: Center(child: Text('Busines Category')),
//     );
//   }
// }

class send_enquiry extends StatelessWidget {
  String service_name;
  send_enquiry({required this.service_name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,      
        children: [
          // Custom AppBar with BoxShadow
          Container(
            decoration: BoxDecoration(
              color: Color(0xffC4A68B),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Offset for shadow
                ),
              ],
            ),
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Removes the default shadow
                title: Text(
                  'Service Enquiry'.tr,
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
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
            ),
          ),
          // Body content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 0,left: 0,right: 0,),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: [  TextFormField(
                    initialValue: service_name,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Service Name".tr,
                      labelStyle: TextStyle(
                        color: Color(0xe5777474),
                        fontSize: 14,
                        fontFamily: 'sub-tittle',
                      ),
                      floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xe5777474)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xe5777474)),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'sub-tittle',
                      fontSize: 16.0,
                      color:
                          Colors.grey, // Set the initialValue color to gray
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    readOnly: true,
                    initialValue: Api.User_info["Table"][0]["MemberName"],
                    decoration: InputDecoration(
                      labelText: "Name".tr,
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
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    readOnly: true,
                    initialValue: Api.User_info["Table"][0]["MobileNo"],
                    decoration: InputDecoration(
                      labelText: "Mobile Number".tr,
                      labelStyle: TextStyle(
                        color: Color(0xe5777474),
                        fontFamily: 'sub-tittle',
                        fontSize: 14,
                      ),
                      floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey), // Default border
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
                ],),),  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffC4A68B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                        Api.ServiceEnquiryInsert(mobile:Api.User_info["Table"][0]["MobileNo"],personName:Api.User_info["Table"][0]["MemberName"],serviceName: service_name).then((value) {
                          if (value) {
                            Navigator.of(context).pop(); 
                           
                             Api.snack_bar(context: context, message: "Send enquiry".tr);                            
                          }else{
                            Api.snack_bar(context: context, message: "Somthing went wrong".tr);
                          }
                        },);
                    },
                    child: Text(
                      'SEND ENQUIRY'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Fontmain',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class CataLoGue extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Custom AppBar with BoxShadow
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xffC4A68B),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: Offset(0, 3), // Offset for shadow
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0, // Removes the default shadow
//                 title: Text(
//                   'Service Enquiry',
//                   style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
//                 ),
//                 centerTitle: true,
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           // Body content
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       initialValue: "Catalogue Services",
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Service Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontSize: 14,
//                           fontFamily: 'sub-tittle',
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                         color:
//                             Colors.grey, // Set the initialValue color to gray
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xffC4A68B)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Color(0xffC4A68B), width: 2),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Mobile Number",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.grey), // Default border
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Color(0xffC4A68B),
//                               width: 2), // Border color when focused
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly // Only numbers
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xffC4A68B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         'SEND ENQUIRY',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Fontmain',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TermsCondi extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Custom AppBar with BoxShadow
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xffC4A68B),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: Offset(0, 3), // Offset for shadow
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0, // Removes the default shadow
//                 title: Text(
//                   'Service Enquiry',
//                   style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
//                 ),
//                 centerTitle: true,
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           // Body content
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       initialValue: "Terms & Conditions",
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Service Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontSize: 14,
//                           fontFamily: 'sub-tittle',
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                         color:
//                             Colors.grey, // Set the initialValue color to gray
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xffC4A68B)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Color(0xffC4A68B), width: 2),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Mobile Number",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.grey), // Default border
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Color(0xffC4A68B),
//                               width: 2), // Border color when focused
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly // Only numbers
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xffC4A68B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         'SEND ENQUIRY',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Fontmain',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AccoSerVice extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Custom AppBar with BoxShadow
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xffC4A68B),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: Offset(0, 3), // Offset for shadow
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0, // Removes the default shadow
//                 title: Text(
//                   'Service Enquiry',
//                   style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
//                 ),
//                 centerTitle: true,
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           // Body content
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       initialValue: "Accounting Services",
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Service Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontSize: 14,
//                           fontFamily: 'sub-tittle',
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                         color:
//                             Colors.grey, // Set the initialValue color to gray
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xffC4A68B)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Color(0xffC4A68B), width: 2),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Mobile Number",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.grey), // Default border
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Color(0xffC4A68B),
//                               width: 2), // Border color when focused
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly // Only numbers
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xffC4A68B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         'SEND ENQUIRY',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Fontmain',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class GstRegis extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Custom AppBar with BoxShadow
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xffC4A68B),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: Offset(0, 3), // Offset for shadow
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0, // Removes the default shadow
//                 title: Text(
//                   'Service Enquiry',
//                   style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
//                 ),
//                 centerTitle: true,
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           // Body content
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       initialValue: "GST Registration",
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Service Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontSize: 14,
//                           fontFamily: 'sub-tittle',
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                         color:
//                             Colors.grey, // Set the initialValue color to gray
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xffC4A68B)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Color(0xffC4A68B), width: 2),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Mobile Number",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.grey), // Default border
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Color(0xffC4A68B),
//                               width: 2), // Border color when focused
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly // Only numbers
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xffC4A68B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         'SEND ENQUIRY',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Fontmain',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FssaIregi extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Custom AppBar with BoxShadow
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xffC4A68B),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: Offset(0, 3), // Offset for shadow
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0, // Removes the default shadow
//                 title: Text(
//                   'Service Enquiry',
//                   style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
//                 ),
//                 centerTitle: true,
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           // Body content
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       initialValue: "FSSAI Registration",
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Service Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontSize: 14,
//                           fontFamily: 'sub-tittle',
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                         color:
//                             Colors.grey, // Set the initialValue color to gray
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xffC4A68B)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Color(0xffC4A68B), width: 2),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Mobile Number",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.grey), // Default border
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Color(0xffC4A68B),
//                               width: 2), // Border color when focused
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly // Only numbers
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xffC4A68B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         'SEND ENQUIRY',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Fontmain',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NagarNigamReg extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Custom AppBar with BoxShadow
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xffC4A68B),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: Offset(0, 3), // Offset for shadow
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0, // Removes the default shadow
//                 title: Text(
//                   'Service Enquiry',
//                   style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
//                 ),
//                 centerTitle: true,
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           // Body content
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       initialValue: "Nagar Nigam Registration",
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Service Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontSize: 14,
//                           fontFamily: 'sub-tittle',
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                         color:
//                             Colors.grey, // Set the initialValue color to gray
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xffC4A68B)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Color(0xffC4A68B), width: 2),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Mobile Number",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.grey), // Default border
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Color(0xffC4A68B),
//                               width: 2), // Border color when focused
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly // Only numbers
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xffC4A68B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         'SEND ENQUIRY',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Fontmain',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ShopRegi extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Custom AppBar with BoxShadow
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xffC4A68B),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: Offset(0, 3), // Offset for shadow
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0, // Removes the default shadow
//                 title: Text(
//                   'Service Enquiry',
//                   style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
//                 ),
//                 centerTitle: true,
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           // Body content
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       initialValue: "Shop Registration",
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         labelText: "Service Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontSize: 14,
//                           fontFamily: 'sub-tittle',
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xe5777474)),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                         color:
//                             Colors.grey, // Set the initialValue color to gray
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xffC4A68B)),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Color(0xffC4A68B), width: 2),
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Mobile Number",
//                         labelStyle: TextStyle(
//                           color: Color(0xe5777474),
//                           fontFamily: 'sub-tittle',
//                           fontSize: 14,
//                         ),
//                         floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                         border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Colors.grey), // Default border
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Color(0xffC4A68B),
//                               width: 2), // Border color when focused
//                         ),
//                       ),
//                       style: TextStyle(
//                         fontFamily: 'sub-tittle',
//                         fontSize: 16.0,
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly // Only numbers
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xffC4A68B),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                         minimumSize: Size(double.infinity, 50),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         'SEND ENQUIRY',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Fontmain',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CaConsult extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset:
//           true, // Ensures the page adjusts when the keyboard opens
//       appBar: AppBar(
//         backgroundColor: Color(0xffC4A68B),
//         elevation: 2,
//         title: Text(
//           'Service Enquiry',
//           style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               TextFormField(
//                 initialValue: "CA Consulting",
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: "Service Name",
//                   labelStyle: TextStyle(
//                     color: Color(0xe5777474),
//                     fontSize: 14,
//                     fontFamily: 'sub-tittle',
//                   ),
//                   floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xe5777474)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xe5777474)),
//                   ),
//                 ),
//                 style: TextStyle(
//                   fontFamily: 'sub-tittle',
//                   fontSize: 16.0,
//                   color: Colors.grey,
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: "Name",
//                   labelStyle: TextStyle(
//                     color: Color(0xe5777474),
//                     fontFamily: 'sub-tittle',
//                     fontSize: 14,
//                   ),
//                   floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xffC4A68B)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
//                   ),
//                 ),
//                 style: TextStyle(
//                   fontFamily: 'sub-tittle',
//                   fontSize: 16.0,
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: "Mobile Number",
//                   labelStyle: TextStyle(
//                     color: Color(0xe5777474),
//                     fontFamily: 'sub-tittle',
//                     fontSize: 14,
//                   ),
//                   floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
//                   ),
//                 ),
//                 style: TextStyle(
//                   fontFamily: 'sub-tittle',
//                   fontSize: 16.0,
//                 ),
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               ),
//               const SizedBox(height: 15),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xffC4A68B),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(0),
//                   ),
//                   minimumSize: Size(double.infinity, 50),
//                 ),
//                 onPressed: () {},
//                 child: Text(
//                   'SEND ENQUIRY',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Fontmain',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WebsiteService extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset:
//           true, // Ensures the page adjusts when the keyboard opens
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Custom AppBar with BoxShadow
//             Container(
//               decoration: BoxDecoration(
//                 color: Color(0xffC4A68B),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: Offset(0, 3), // Offset for shadow
//                   ),
//                 ],
//               ),
//               child: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0, // Removes the default shadow
//                 title: Text(
//                   'Service Enquiry',
//                   style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
//                 ),
//                 centerTitle: true,
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//             // Body content
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         initialValue: "Website Services",
//                         readOnly: true,
//                         decoration: InputDecoration(
//                           labelText: "Service Name",
//                           labelStyle: TextStyle(
//                             color: Color(0xe5777474),
//                             fontSize: 14,
//                             fontFamily: 'sub-tittle',
//                           ),
//                           floatingLabelStyle:
//                               TextStyle(color: Color(0xe5777474)),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xe5777474)),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xe5777474)),
//                           ),
//                         ),
//                         style: TextStyle(
//                           fontFamily: 'sub-tittle',
//                           fontSize: 16.0,
//                           color:
//                               Colors.grey, // Set the initialValue color to gray
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: "Name",
//                           labelStyle: TextStyle(
//                             color: Color(0xe5777474),
//                             fontFamily: 'sub-tittle',
//                             fontSize: 14,
//                           ),
//                           floatingLabelStyle:
//                               TextStyle(color: Color(0xffC4A68B)),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xffC4A68B)),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Color(0xffC4A68B), width: 2),
//                           ),
//                         ),
//                         style: TextStyle(
//                           fontFamily: 'sub-tittle',
//                           fontSize: 16.0,
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: "Mobile Number",
//                           labelStyle: TextStyle(
//                             color: Color(0xe5777474),
//                             fontFamily: 'sub-tittle',
//                             fontSize: 14,
//                           ),
//                           floatingLabelStyle:
//                               TextStyle(color: Color(0xffC4A68B)),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Colors.grey), // Default border
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Color(0xffC4A68B),
//                                 width: 2), // Border color when focused
//                           ),
//                         ),
//                         style: TextStyle(
//                           fontFamily: 'sub-tittle',
//                           fontSize: 16.0,
//                         ),
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly // Only numbers
//                         ],
//                       ),
//                       const SizedBox(height: 15),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xffC4A68B),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(0),
//                           ),
//                           minimumSize: Size(double.infinity, 50),
//                         ),
//                         onPressed: () {},
//                         child: Text(
//                           'SEND ENQUIRY',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'Fontmain',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
