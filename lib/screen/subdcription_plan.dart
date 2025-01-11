// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:math';

import 'dart:developer';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/main.dart';

class subscription_plan extends StatefulWidget {
  Function ref;
  subscription_plan({required this.ref});

  @override
  State<subscription_plan> createState() => _subscription_planState();
}

class _subscription_planState extends State<subscription_plan> {
  List<dynamic> _data = [];
  List<dynamic> _package_list = [];
  List<Widget> itms = [];
  var amount_con = TextEditingController();
  var remark_con = TextEditingController();

  bool loader = false;
  @override
  void initState() {
    loader = true;
    // TODO: implement initState
    super.initState();
    _data.clear();
    _package_list.clear();
    Api.SubscriptionList().then(
      (value) {
        _data = value;
        Api.Packagelist().then(
          (value) {
            _package_list = value;
            int index = _data.indexWhere((item) =>
                item['ID'] == Api.User_info["Table"][0]["F_SubscriberMaster"]);
            if (Api.User_info["Table"][0]["F_SubscriberMaster"] != null&&Api.User_info["Table"][0]["F_SubscriberMaster"]!=0) {
              buttom_sheet(
                  SubscriberId: Api.User_info["Table"][0]["F_SubscriberMaster"]
                      .toString(),
                  SubscriptionCharge:
                      Api.User_info["Table"][0]["AccountBalance"].toString(),
                  SubscriptionName: _data[index]["SubscriptionName"],
                  sub: false);
            }

            setState(() {
              loader = false;
            });
          },
        );
      },
    );
  }

  void buttom_sheet(
      {required String SubscriptionName,
      required String SubscriptionCharge,
      required String SubscriberId,
      required bool sub}) {
    String? _selectedValue;
    if (Api.User_info["Table"][0]["F_SubscriberMaster"] != null &&
        sub == true &&
        Api.User_info["Table"][0]["F_SubscriberMaster"] != 0) {
      // SubscriptionCharge = ((double.parse(SubscriptionCharge) -
      //             Api.User_info["Table"][0]["SubscriptionAmount"]) +
      //         Api.User_info["Table"][0]["AccountBalance"])
      //     .toString();
    }
    if (sub==false) {
      showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: 300,
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        // isScrollControlled: ,
        builder: (context) {
          ValueNotifier<bool> load = ValueNotifier(false);
          return ValueListenableBuilder(
            valueListenable: load,
            builder: (context, value, child) {
              return Padding(
                // padding: const EdgeInsets.only(bottom: 0,),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: (MediaQuery.sizeOf(context).height / 2) - 60,
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xffC4A68B),
                        title: Text(
                          "Add Payment".tr,
                          style: TextStyle(fontFamily: "Fontmain"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    SubscriptionName,
                                    style: TextStyle(fontFamily: "Fontmain"),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: SubscriptionCharge.toString(),
                                  groupValue: _selectedValue,
                                  onChanged: (value) {
                                    _selectedValue = value;
                                    load.value = load.value ? false : true;
                                    amount_con.text=_selectedValue!;
                                  },
                                ),
                                Text(
                                  SubscriptionCharge.toString(),
                                  style: TextStyle(fontFamily: "Fontmain"),
                                )
                              ],
                            ),
                            // TextFormField(
                            //   controller: amount_con,
                            //   keyboardType: TextInputType.number,
                            //   decoration: InputDecoration(
                            //       label: Text("Amount"),
                            //       enabledBorder:
                            //           OutlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color: Colors
                            //                       .black)),
                            //       focusedBorder:
                            //           OutlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color:
                            //                       Colors.black))),
                            // ),
                            TextFormField(
                              controller: remark_con,
                              decoration: InputDecoration(
                                  label: Text("Remark"),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (amount_con.text.isNotEmpty) {
                            Api.SubscriptionInsert(
                                    Amount: amount_con.text,
                                    BankRefNo: "",
                                    PaymentMode: "Cash",
                                    Remarks: remark_con.text,
                                    SubscriberId: SubscriberId,
                                    TransctionNo: "")
                                .then(
                              (value) {
                                if (value == "R100") {
                                  Api.snack_bar2(
                                      context: context,
                                      message:
                                          "Activated successfully this plan");
                                } else if (value == "R200") {
                                  Api.snack_bar2(
                                      context: context,
                                      message: "successfully Add on plan");
                                }
                                Api.Mpin_check(
                                        mob_no:
                                            Api.prefs.getString("mobile_no") ??
                                                "",
                                        Mpin: Api.prefs.getString("mpin") ?? "")
                                    .then(
                                  (value) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    widget.ref(false);
                                  },
                                );
                              },
                            );
                          } else {
                            Api.snack_bar(
                                context: context,
                                message: "Something went wrong");
                          }
                        },
                        child: Container(
                          height: 60,
                          width: double.maxFinite,
                          color: Color(0xffC4A68B),
                          alignment: Alignment.center,
                          child: Text(
                            "Pay Amount",
                            style: TextStyle(
                                fontFamily: "Fontmain", color: Colors.white),
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
      );
    } else {
      showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: 300,
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        // isScrollControlled: ,
        builder: (context) {
          ValueNotifier<bool> load = ValueNotifier(false);
          return ValueListenableBuilder(
            valueListenable: load,
            builder: (context, value, child) {
              return Padding(
                // padding: const EdgeInsets.only(bottom: 0,),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: (MediaQuery.sizeOf(context).height / 2) - 60,
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xffC4A68B),
                        title: Text(
                          "Add Payment".tr,
                          style: TextStyle(fontFamily: "Fontmain"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    SubscriptionName,
                                    style: TextStyle(fontFamily: "Fontmain"),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: (double.parse(SubscriptionCharge)/2).round().toString(),
                                  groupValue: _selectedValue,
                                  onChanged: (value) {
                                    _selectedValue = value;
                                    amount_con.text=_selectedValue!;
                                    load.value = load.value ? false : true;
                                  },
                                ),
                                Text(
                                  (double.parse(SubscriptionCharge)/2).round().toString(),
                                  style: TextStyle(fontFamily: "Fontmain"),
                                ),
                                Radio(
                                  value: SubscriptionCharge.toString(),
                                  groupValue: _selectedValue,
                                  onChanged: (value) {
                                    _selectedValue = value;
                                    amount_con.text=_selectedValue!;
                                    load.value = load.value ? false : true;
                                  },
                                ),
                                Text(
                                  SubscriptionCharge.toString(),
                                  style: TextStyle(fontFamily: "Fontmain"),
                                )
                              ],
                            ),
                            // TextFormField(
                            //   controller: amount_con,
                            //   keyboardType: TextInputType.number,
                            //   decoration: InputDecoration(
                            //       label: Text("Amount"),
                            //       enabledBorder:
                            //           OutlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color: Colors
                            //                       .black)),
                            //       focusedBorder:
                            //           OutlineInputBorder(
                            //               borderSide: BorderSide(
                            //                   color:
                            //                       Colors.black))),
                            // ),
                            TextFormField(
                              controller: remark_con,
                              decoration: InputDecoration(
                                  label: Text("Remark"),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (amount_con.text.isNotEmpty) {
                            Api.SubscriptionInsert(
                                    Amount: amount_con.text,
                                    BankRefNo: "",
                                    PaymentMode: "Cash",
                                    Remarks: remark_con.text,
                                    SubscriberId: SubscriberId,
                                    TransctionNo: "")
                                .then(
                              (value) {
                                if (value == "R100") {
                                  Api.snack_bar(
                                      context: context,
                                      message:
                                          "Activated successfully this plan");
                                } else if (value == "R200") {
                                  Api.snack_bar(
                                      context: context,
                                      message: "successfully Add on plan");
                                }
                                Api.Mpin_check(
                                        mob_no:
                                            Api.prefs.getString("mobile_no") ??
                                                "",
                                        Mpin: Api.prefs.getString("mpin") ?? "")
                                    .then(
                                  (value) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    widget.ref(false);
                                  },
                                );
                              },
                            );
                          } else {
                            Api.snack_bar(
                                context: context,
                                message: "Something went wrong");
                          }
                        },
                        child: Container(
                          height: 60,
                          width: double.maxFinite,
                          color: Color(0xffC4A68B),
                          alignment: Alignment.center,
                          child: Text(
                            "Pay Amount",
                            style: TextStyle(
                                fontFamily: "Fontmain", color: Colors.white),
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    itms.clear();
    for (var i = 0; i < _data.length; i++) {
      List<TableRow> Temp = [];
      for (var j = 0; j < _package_list.length; j++) {
        // int index = _package_list.indexWhere((item) => item['ID'] == _data[i]['ID']);
        if (_package_list[j]['ID'] == _data[i]['ID']) {
          Temp.add(
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  _package_list[j]["FacilitiesName"],
                  style: TextStyle(
                      color: const Color.fromARGB(255, 13, 2, 95),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  _package_list[j]["Remarks"],
                  style: TextStyle(
                      color: const Color.fromARGB(255, 13, 2, 95),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          );
        }
      }
      itms.add(
        SingleChildScrollView(
          child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                margin: EdgeInsets.only(
                    bottom: (MediaQuery.of(context).size.height) * 0.8,
                    right: 20,
                    left: 20,
                    top: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(136, 0, 0, 0),
                          blurRadius: 5,
                          offset: Offset(2, 4))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹ ${_data[i]["SubscriptionCharge"]}",
                          style: TextStyle(
                              fontSize: 20,
                              color: const Color.fromARGB(255, 13, 2, 95),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 245, 24, 72),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: Text(
                            "${_data[i]["SubscriptionName"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Table(
                      children: Temp,
                    ),
                    GestureDetector(
                      onTap: () {
                        amount_con.clear();
                        remark_con.clear();
                        log(_data[i]["ID"].toString());
                        buttom_sheet(
                            SubscriptionName: _data[i]["SubscriptionName"],
                            SubscriptionCharge:
                                _data[i]["SubscriptionCharge"].toString(),
                            SubscriberId: _data[i]["ID"].toString(),
                            sub: true);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 245, 24, 72),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        child: Text(
                          Api.User_info["Table"][0]["F_SubscriberMaster"] !=
                                      null &&
                                  Api.User_info["Table"][0]
                                          ["F_SubscriberMaster"] !=
                                      0
                              ? "Upgrade"
                              : "GET STARTED".tr,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Subscription Plan".tr,
            style: TextStyle(fontFamily: "Fontmain"),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Color(0xffC4A68B),
        ),
        body: loader
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: AnotherCarousel(
                    overlayShadow: true,
                    autoplay: false,
                    dotBgColor: Colors.transparent,
                    dotColor: const Color.fromARGB(255, 10, 0, 100),
                    showIndicator: true,
                    dotIncreasedColor: Color.fromARGB(255, 10, 0, 100),
                    animationCurve: Curves.decelerate,
                    images: itms),
              ));
  }
}
