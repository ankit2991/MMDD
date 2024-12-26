import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mddmerchant/api/api.dart';

class UpComingEvents extends StatefulWidget {
  bool prev;
   UpComingEvents({this.prev=false});

  @override
  State<UpComingEvents> createState() => _UpComingEventsState();
}

class _UpComingEventsState extends State<UpComingEvents> {
  @override
  List<dynamic> _data = [];
  List<dynamic> service_data = [];
  List<Map<String, dynamic>> submit_data = [];
  List<bool> select_Facility = [];
  List<TextEditingController> Quantity_con = [];
  List<TextEditingController> remark_con = [];
  // List<TextEditingController> price_con=[];
  List<TextEditingController> Total_con = [];
  var amount_con = TextEditingController();
  var Payment_remark_con = TextEditingController();
  bool loder = false;
  bool service_data_loder = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    loder = true;
    _data.clear();
   if (widget.prev) {
      Api.EventBookingDetailsList(Is_booking: "1",
            Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                "CompleteEvent")
        .then(
      (value) {
        _data = value;
        setState(() {
          loder = false;
        });
        // print(value);
      },
    );
   }else{
     Api.EventBookingDetailsList(Is_booking: "1",
            Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                "UpcomingEvent")
        .then(
      (value) {
        _data = value;
        setState(() {
          loder = false;
        });
        // print(value);
      },
    );
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2.4,
          title:widget.prev?Text('Due Register',
              style: TextStyle(color: Colors.white, fontFamily: 'Fontmain')): Text('UpComing Events'.tr,
              style: TextStyle(color: Colors.white, fontFamily: 'Fontmain')),
          backgroundColor: Color(0xffC4A68B),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white, // Change the color of the icon
            iconSize: 30.0, // Adjust the size of the icon
          ),
        ),
        body: Stack(
          children: [
            loder
                ? Text("")
                : ListView.builder(
                
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    itemCount: _data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, Top_index) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        //  height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 0.5,
                                  color: const Color.fromARGB(134, 0, 0, 0),
                                  offset: Offset(1, 1))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  _data[Top_index]["EventStartDate"],
                                  style: TextStyle(fontFamily: 'Fontmain'),
                                ),
                              ],
                            ),
                            Text(
                              _data[Top_index]["CustomerName"],
                              style: TextStyle(fontFamily: 'Fontmain'),
                            ),
                            Text(
                              _data[Top_index]["EventName"],
                              style: TextStyle(fontFamily: 'Fontmain'),
                            ),
                            Text(
                              _data[Top_index]["MobileNo"],
                              style: TextStyle(fontFamily: 'Fontmain'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (_data[Top_index]["TotalAmount"] !=
                                          null)
                                        Text(
                                          "Total Amount : ₹ ${_data[Top_index]["TotalAmount"]}",
                                          style: TextStyle(
                                              fontFamily: 'Fontmain',
                                              fontSize: 10),
                                        ),
                                      if (_data[Top_index]["BookingAmount"] !=
                                          null)
                                        Text(
                                          "Advance Amount : ₹ ${_data[Top_index]["BookingAmount"]}",
                                          style: TextStyle(
                                              fontFamily: 'Fontmain',
                                              fontSize: 10),
                                        ),
                                      if (_data[Top_index]["DueAmount"] != null)
                                        Text(
                                          "Due Amount : ₹ ${_data[Top_index]["DueAmount"]}",
                                          style: TextStyle(
                                              fontFamily: 'Fontmain',
                                              fontSize: 10),
                                        ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Payment_remark_con.clear();
                                    Quantity_con.clear();
                                    Total_con.clear();
                                    select_Facility.clear();
                                    remark_con.clear();
                                    submit_data.clear();
                                    setState(() {
                                      service_data_loder = true;
                                    });

                                    await Api.FacilityReport().then(
                                      (value) {
                                        service_data = value;
                                        setState(() {
                                          service_data_loder = false;
                                        });
                                      },
                                    );

                                    log("Add service ");
                                    showModalBottomSheet(
                                      scrollControlDisabledMaxHeightRatio: 300,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        print(service_data);
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height /
                                                2,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            child: Column(
                                              children: [
                                                AppBar(
                                                  title: Text('Add Service',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Fontmain',
                                                          fontSize: 15)),
                                                  backgroundColor:
                                                      Color(0xffC4A68B),
                                                  centerTitle: true,
                                                  leading: IconButton(
                                                    icon:
                                                        Icon(Icons.arrow_back),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    color: Colors
                                                        .white, // Change the color of the icon
                                                    iconSize:
                                                        30.0, // Adjust the size of the icon
                                                  ),
                                                ),
                                                Container(
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              2) -
                                                          58,
                                                  child: ListView.builder(
                                                    // physics: NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        service_data.length + 1,
                                                    itemBuilder:
                                                        (context, index) {
                                                      select_Facility
                                                          .add(false);
                                                      Quantity_con.add(
                                                          TextEditingController());
                                                      remark_con.add(
                                                          TextEditingController());
                                                      Total_con.add(
                                                          TextEditingController());

                                                      ValueNotifier<bool>
                                                          check = ValueNotifier(
                                                              select_Facility[
                                                                  index]);
                                                      var price_con =
                                                          TextEditingController();
                                                      if (service_data.length >
                                                          index) {
                                                        price_con.text =
                                                            service_data[index]
                                                                    ["Amount"]
                                                                .toString();
                                                      }

                                                      // var quentity_con =
                                                      //     TextEditingController();
                                                      // var remark_con =
                                                      //     TextEditingController();
                                                      // var total_con =
                                                      // TextEditingController();
                                                      // bool check=false;
                                                      return service_data
                                                                  .length <=
                                                              index
                                                          ? GestureDetector(
                                                              onTap: () async {
                                                                 setState(() {
                                                                 loder =true;                                                                   
                                                                 });
                                                                 Navigator.of(context).pop();
                                                                print(
                                                                    submit_data);
                                                                    for (var i = 0; i < submit_data.length; i++) {
                                                                      if (submit_data[i].length<=2) {
                                                                        submit_data.removeAt(i);
                                                                      }
                                                                    }
                                                                var tot = 0.0;
                                                                //  String a="\"3000.0\"";
                                                                //  tot=double.parse(a)+tot;
                                                                for (var i = 0;
                                                                    i <
                                                                        service_data
                                                                            .length;
                                                                    i++) {
                                                                  if (Total_con[
                                                                              i]
                                                                          .text !=
                                                                      "") {
                                                                    tot = double.parse(
                                                                            Total_con[i].text) +
                                                                        tot;
                                                                  }
                                                                }
                                                                print(tot);
                                                                if (submit_data.isNotEmpty) {
                                                                      await Api.RecipitFacilityInsert(
                                                                        Amount: tot
                                                                            .toString(),
                                                                        EventId:
                                                                            _data[Top_index]["id"]
                                                                                .toString(),
                                                                        Remarks:
                                                                            _data[Top_index]["Remarks"]
                                                                                .toString(),
                                                                        serviceAdd:
                                                                            submit_data)
                                                                    .then(
                                                                  (value) {
                                                                    if (value) {
                                                                     
                                                                      _data
                                                                          .clear();
                                                                          if (widget.prev) {
                                                                                Api.EventBookingDetailsList(Is_booking: "1",
                                                                              Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent: "CompleteEvent")
                                                                          .then(
                                                                        (value) {
                                                                          _data =
                                                                              value;
                                                                          setState(
                                                                              () {
                                                                            loder =
                                                                                false;
                                                                          });
                                                                          // print(value);
                                                                        },
                                                                      );
                                                                  
                                                                          }else{
                                                                      Api.EventBookingDetailsList(Is_booking: "1",
                                                                              Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent: "UpcomingEvent")
                                                                          .then(
                                                                        (value) {
                                                                          _data =
                                                                              value;
                                                                          setState(
                                                                              () {
                                                                            loder =
                                                                                false;
                                                                          });
                                                                          // print(value);
                                                                        },
                                                                      );
                                                                           } }
                                                                  },
                                                                );
                                                         
                                                                }else{
                                                                  setState(() {
                                                                    loder=false;
                                                                  });
                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("palce select services")));
                                                                }
                                                                 },
                                                              child: Container(
                                                                height: 50,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                color: Color(
                                                                    0xffC4A68B),
                                                                child: Text(
                                                                  "Submit",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          "Fontmain"),
                                                                ),
                                                              ),
                                                            )
                                                          : ValueListenableBuilder(
                                                              valueListenable:
                                                                  check,
                                                              builder: (context,
                                                                  value,
                                                                  child) {
                                                                return Container(
                                                                  // height: 100,
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius: BorderRadius.circular(5),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            blurRadius:
                                                                                2,
                                                                            color:
                                                                                Colors.black,
                                                                            offset: Offset(0, 2))
                                                                      ]),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Checkbox(
                                                                            value:
                                                                                value,
                                                                            onChanged:
                                                                                (value) {
                                                                              select_Facility.remove(index);
                                                                              select_Facility.insert(index, check.value ? false : true);
                                                                              check.value = check.value ? false : true;
                                                                              if (check.value) {
                                                                                submit_data.add({
                                                                                  "\"Id\"": "\"${service_data[index]["Id"]}\""
                                                                                });
                                                                              } else {
                                                                                // ________________________________________________   Search element on list of map
                                                                                int element_index = submit_data.indexWhere((map) => map["Id"] == "\"${service_data[index]["Id"].toString()}\"");
                                                                                print(element_index);
                                                                                submit_data.removeAt(element_index);
                                                                                print(submit_data);
                                                                              }
                                                                            },
                                                                          ),
                                                                          Text(
                                                                            service_data[index]["FacilityName"],
                                                                            style:
                                                                                TextStyle(fontFamily: "Fontmain"),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                (MediaQuery.of(context).size.width / 3) - 20,
                                                                            // color: Colors.amber,
                                                                            margin:
                                                                                EdgeInsets.only(bottom: 5),
                                                                            child:
                                                                                IgnorePointer(
                                                                              ignoring: check.value ? false : true,
                                                                              child: TextFormField(
                                                                                controller: Quantity_con[index],
                                                                                onChanged: (value) {
                                                                                  if (value.isNotEmpty && value != " " && int.parse(value) > 0) {
                                                                                    Total_con[index].text = (int.parse(value) * service_data[index]["Amount"]).toString();
                                                                                    // submit_data.removeAt(index);
                                                                                    // submit_data.insert(index, {"Id":"\"${service_data[index]["Id"]}\"","Name":"\"${service_data[index]["FacilityName"]}\"","Quantity":"\"${Quantity_con[index].text.trim()}\"","Price":"\"${price_con.text.trim()}\"","Total":"\"${total_con.text.trim()}\"","Remark":"\"${remark_con[index].text.trim()}\""});
                                                                                  } else {
                                                                                    Total_con[index].clear();
                                                                                  }
                                                                                },
                                                                                keyboardType: TextInputType.number,
                                                                                style: TextStyle(color:check.value? const Color.fromARGB(255, 66, 65, 65): const Color.fromARGB(255, 146, 145, 145)),
                                                                                decoration: InputDecoration(label: Text("Quantity"), labelStyle: TextStyle(color:check.value? const Color.fromARGB(255, 66, 65, 65): const Color.fromARGB(255, 146, 145, 145)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: const Color.fromARGB(255, 146, 145, 145))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: const Color.fromARGB(255, 146, 145, 145)))),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                (MediaQuery.of(context).size.width / 3) - 20,
                                                                            // color: Colors.amber,
                                                                            margin:
                                                                                EdgeInsets.only(bottom: 5),
                                                                            child:
                                                                                IgnorePointer(
                                                                              ignoring: true,
                                                                              child: TextFormField(
                                                                                controller: price_con,
                                                                                keyboardType: TextInputType.number,
                                                                                style: TextStyle(color:check.value? const Color.fromARGB(255, 66, 65, 65): const Color.fromARGB(255, 146, 145, 145)),
                                                                                decoration: InputDecoration(labelText: "price", labelStyle: TextStyle(color:check.value? const Color.fromARGB(255, 66, 65, 65): const Color.fromARGB(255, 146, 145, 145)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: const Color.fromARGB(255, 146, 145, 145))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: const Color.fromARGB(255, 146, 145, 145)))),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                (MediaQuery.of(context).size.width / 3) - 20,
                                                                            // color: Colors.amber,
                                                                            margin:
                                                                                EdgeInsets.only(bottom: 5),
                                                                            child:
                                                                                IgnorePointer(
                                                                              ignoring: true,
                                                                              child: TextFormField(
                                                                                controller: Total_con[index],
                                                                                style: TextStyle(color:check.value? const Color.fromARGB(255, 66, 65, 65): const Color.fromARGB(255, 146, 145, 145)),
                                                                                keyboardType: TextInputType.number,
                                                                                decoration: InputDecoration(labelText: "Total", labelStyle: TextStyle(color:check.value? const Color.fromARGB(255, 66, 65, 65): const Color.fromARGB(255, 146, 145, 145)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: const Color.fromARGB(255, 146, 145, 145))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: const Color.fromARGB(255, 146, 145, 145)))),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                5),
                                                                        child:
                                                                            IgnorePointer(
                                                                          ignoring: check.value
                                                                              ? false
                                                                              : true,
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                remark_con[index],
                                                                            style:
                                                                                TextStyle(color:check.value? const Color.fromARGB(255, 66, 65, 65): const Color.fromARGB(255, 146, 145, 145)),
                                                                            decoration: InputDecoration(
                                                                                labelText: "remark",
                                                                                labelStyle: TextStyle(color:check.value? const Color.fromARGB(255, 66, 65, 65): const Color.fromARGB(255, 146, 145, 145)),
                                                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color:check.value? const Color.fromARGB(255, 66, 65, 65): const Color.fromARGB(255, 146, 145, 145))),
                                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color:check.value? const Color.fromARGB(255, 66, 65, 65): const Color.fromARGB(255, 146, 145, 145)))),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.symmetric(vertical: 10),
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                100,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            color:check.value?
                                                                                Color(0xffC4A68B):Color.fromARGB(139, 196, 166, 139),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                if (Quantity_con[index].text.isNotEmpty &&int.parse(Quantity_con[index].text)>=1) {  
                                                                                  try {
                                                                                int element_index = submit_data.indexWhere((map) => map["\"Id\""] == "\"${service_data[index]["Id"]}\"");
                                                                                submit_data[element_index] = {
                                                                                  "\"Id\"": "\"${service_data[index]["Id"]}\"",
                                                                                  "\"Name\"": "\"${service_data[index]["FacilityName"]}\"",
                                                                                  "\"Quantity\"": "\"${Quantity_con[index].text.trim()}\"",
                                                                                  "\"Price\"": "${double.parse(price_con.text.trim()).toInt()}",
                                                                                  "\"Total\"": "\"${double.parse(Total_con[index].text.trim()).toInt()}\"",
                                                                                  "\"Remark\"": "\"${remark_con[index].text.trim()}\""
                                                                                };
                                                                                    
                                                                                  } catch (e) {
                                                                                      int element_index = submit_data.indexWhere((map) => map["\"Id\""] == "\"${service_data[index]["Id"]}\"");
                                                                                submit_data[element_index] = {
                                                                                  "\"Id\"": "\"${service_data[index]["Id"]}\"",
                                                                                  "\"Name\"": "\"${service_data[index]["FacilityName"]}\"",
                                                                                  "\"Quantity\"": "\"${Quantity_con[index].text.trim()}\"",
                                                                                  "\"Price\"": "${double.parse(price_con.text.trim()).toInt()}",
                                                                                  "\"Total\"": "\"${double.parse(Total_con[index].text.trim()).toInt()}\"",
                                                                                  "\"Remark\"": "\"${remark_con[index].text.trim()}\""
                                                                                };
                                                                                  }
                                                                                // submit_data.removeAt(element_index);

                                                                                // submit_data.insert(index, );
                                                                                print(remark_con[index].text);
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                "SAVE",
                                                                                style: TextStyle(fontFamily: "Fontmain", color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 5, top: 5),
                                    height: 45,
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        20,
                                    color: Color(0xffC4A68B),
                                    alignment: Alignment.center,
                                    child: Text('ADD SERVICE',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Fontmain',
                                            fontSize: 10)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    log("Add PAYMENT ");
                                    amount_con.clear();
                                    Payment_remark_con.clear();
                                    showModalBottomSheet(
                                      context: context,
                                      // enableDrag: true,
                                      // isDismissible: true,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                AppBar(
                                                  title: Text('Add Payment',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Fontmain',
                                                          fontSize: 15)),
                                                  backgroundColor:
                                                      Color(0xffC4A68B),
                                                  centerTitle: true,
                                                  leading: IconButton(
                                                    icon:
                                                        Icon(Icons.arrow_back),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    color: Colors
                                                        .white, // Change the color of the icon
                                                    iconSize:
                                                        30.0, // Adjust the size of the icon
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      child: Column(
                                                        spacing: 10,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    _data[Top_index]
                                                                        [
                                                                        "EventStartDate"],
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Fontmain'),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                _data[Top_index]
                                                                    [
                                                                    "CustomerName"],
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Fontmain'),
                                                              ),
                                                              Text(
                                                                _data[Top_index]
                                                                    [
                                                                    "EventName"],
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Fontmain'),
                                                              ),
                                                              Text(
                                                                _data[Top_index]
                                                                    [
                                                                    "MobileNo"],
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Fontmain'),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        if (_data[Top_index]["TotalAmount"] !=
                                                                            null)
                                                                          Text(
                                                                            "Total Amount : ₹ ${_data[Top_index]["TotalAmount"]}",
                                                                            style:
                                                                                TextStyle(fontFamily: 'Fontmain', fontSize: 10),
                                                                          ),
                                                                        if (_data[Top_index]["BookingAmount"] !=
                                                                            null)
                                                                          Text(
                                                                            "Advance Amount : ₹ ${_data[Top_index]["BookingAmount"]}",
                                                                            style:
                                                                                TextStyle(fontFamily: 'Fontmain', fontSize: 10),
                                                                          ),
                                                                        if (_data[Top_index]["DueAmount"] !=
                                                                            null)
                                                                          Text(
                                                                            "Due Amount : ₹ ${_data[Top_index]["DueAmount"]}",
                                                                            style:
                                                                                TextStyle(fontFamily: 'Fontmain', fontSize: 10),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  amount_con,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Amount",
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .black)),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Colors.black))),
                                                            ),
                                                          ),
                                                          Container(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  Payment_remark_con,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Remark",
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .black)),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Colors.black))),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              setState(() {
                                                                loder = true;
                                                              });
                                                              await Api.RecipitInsert(
                                                                      Amount: amount_con
                                                                          .text
                                                                          .trim(),
                                                                      Remark: Payment_remark_con
                                                                          .text
                                                                          .trim(),
                                                                      Event_id: _data[Top_index]
                                                                              [
                                                                              "id"]
                                                                          .toInt()
                                                                          .toString())
                                                                  .then(
                                                                (value) {
                                                                  if (widget.prev) {
                                                                      Api.EventBookingDetailsList(Is_booking: "1",
                                                                          Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                                                                              "CompleteEvent")
                                                                      .then(
                                                                    (value) {
                                                                      _data
                                                                          .clear();
                                                                      _data =
                                                                          value;
                                                                      setState(
                                                                          () {
                                                                        loder =
                                                                            false;
                                                                      });
                                                                      // print(value);
                                                                    },
                                                                  );
                                                             
                                                                  }else{
                                                                  Api.EventBookingDetailsList(Is_booking: "1",
                                                                          Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                                                                              "UpcomingEvent")
                                                                      .then(
                                                                    (value) {
                                                                      _data
                                                                          .clear();
                                                                      _data =
                                                                          value;
                                                                      setState(
                                                                          () {
                                                                        loder =
                                                                            false;
                                                                      });
                                                                      // print(value);
                                                                    },
                                                                  );
                                                                }},
                                                              );
                                                              amount_con
                                                                  .clear();
                                                              remark_con
                                                                  .clear();

                                                              // Api.
                                                            },
                                                            child: Container(
                                                              height: 50,
                                                              color: Color(
                                                                  0xffC4A68B),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "Save",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Fontmain',
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 5, top: 5),
                                    height: 45,
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        20,
                                    color: Color(0xffC4A68B),
                                    alignment: Alignment.center,
                                    child: Text('ADD PAYMENT',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Fontmain',
                                            fontSize: 10)),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
           
            if (loder)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: SpinKitCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              ),
            if (service_data_loder)
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
        ));
  }
}
