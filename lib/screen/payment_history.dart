import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mddmerchant/api/HashService.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/screen/subdcription_plan.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';

class payment_history extends StatefulWidget {
  const payment_history({super.key});

  @override
  State<payment_history> createState() => _payment_historyState();
}

class _payment_historyState extends State<payment_history>
    implements PayUCheckoutProProtocol {
  late PayUCheckoutProFlutter _checkoutPro;
  List<dynamic> _data = [];
  List<Widget> histroy = [];
  bool _loder = false;
  Map<String, Map<String, String>> request = {};
  var amount_con = TextEditingController();
  var remark_con = TextEditingController();
  String? sub_id;
  String generateTransactionId() {
    String baseId = "${DateTime.now().millisecondsSinceEpoch}";
    return baseId.length > 25 ? baseId.substring(0, 25) : baseId;
  }

  @override
  void initState() {
    _checkoutPro = PayUCheckoutProFlutter(this);
    _loder = true;
    // TODO: implement initState
    super.initState();
    Api.PaymentList().then(
      (value) {
        _data.clear();
        _data = value;
        print(_data);

        if (_data.isNotEmpty&& _data[0]["DueAmount"] > 0) {
          buttom_sheet(
            DueAmount:"${_data[0]["DueAmount"]}" ,
              SubscriberId: _data[0]["F_SubscriberMaster"].toString(),
              SubscriptionCharge: _data[0]["SubscriptionAmount"].toString());
        }
        List<String> unique_date = [];
        for (var i = 0; i < _data.length; i++) {
          if (unique_date.contains(_data[i]["SubscriptionStartDate"])) {
          } else {
            unique_date.add(_data[i]["SubscriptionStartDate"]);
          }
        }
        for (int i = 0; i < unique_date.length; i++) {
          List<Widget> temp = [];
          // DateFormat inputFormat = DateFormat("dd MMM yyyy");

          // Parse the string into a DateTime object
          // DateTime Date = inputFormat.parse(_data[i]["SubscriptionStartDate"]);
          //            print(Date);
          double totle=0;
          for (int j = i; j < _data.length; j++) {
            if (unique_date[i] == _data[j]["SubscriptionStartDate"]) {
              totle+=_data[j]["Amount"];
              temp.add(Container(
                margin: EdgeInsets.only(bottom: 5),
                // height: 50,
                padding: EdgeInsets.all(10),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: .5,
                          offset: Offset(0, 0))
                    ]),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Voucher No. ${_data[j]["VoucherNo"].toInt().toString()}",
                          style:
                              TextStyle(fontFamily: "Fontmain", fontSize: 11),
                        ),
                        Text(
                          "Date ${_data[j]["VoucherDate"].toString()}",
                          style:
                              TextStyle(fontFamily: "Fontmain", fontSize: 11),
                        ),
                        if (_data[j]["BankRefNo"] != null &&
                            _data[j]["BankRefNo"] != "")
                          Text(
                            "UTR No. ${_data[j]["BankRefNo"].toString()}",
                            style:
                                TextStyle(fontFamily: "Fontmain", fontSize: 11),
                          ),
                      ],
                    )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${_data[j]["PaymentMode"].toString()}",
                          style: TextStyle(
                              fontFamily: "Fontmain",
                              fontSize: 11,
                              color: Colors.green),
                        ),
                        Text(
                          "+ ₹${_data[j]["Amount"].toString()}",
                          style: TextStyle(
                              fontFamily: "Fontmain",
                              fontSize: 11,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
            }
          }
          histroy.add(
            Container(
              // height: 200,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        offset: Offset(0, 2))
                  ]),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      spacing: 3,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount: ₹${_data[i]["SubscriptionAmount"].toString()}",
                              style: TextStyle(
                                  fontFamily: "Fontmain", fontSize: 13),
                            ),
                            if (_data[i]["SubscriptionAmount"]-totle > 0)
                              Text(
                                "Due: ₹${_data[i]["SubscriptionAmount"]-totle}",
                                style: TextStyle(
                                    fontFamily: "Fontmain", fontSize: 13),
                              ),
                          ],
                        ),
                        Text(
                          "Start Date: ${_data[i]["SubscriptionStartDate"].toString()}",
                          style:
                              TextStyle(fontFamily: "Fontmain", fontSize: 11),
                        ),
                        Text(
                          "End Date: ${_data[i]["SubscriptionEndDate"].toString()}",
                          style:
                              TextStyle(fontFamily: "Fontmain", fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  if (_data[i]["SubscriptionAmount"]-totle > 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            buttom_sheet(
                              DueAmount:"${ _data[0]["SubscriptionAmount"]-totle}",
                                SubscriberId:
                                    _data[0]["F_SubscriberMaster"].toString(),
                                SubscriptionCharge:
                                    _data[0]["SubscriptionAmount"].toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xffC4A68B)),
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 10),
                            alignment: Alignment.center,
                            child: Text(
                              "Pay Now",
                              style: TextStyle(
                                  fontFamily: "Fontmain", color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: temp,
                  )
                ],
              ),
            ),
          );
        }
        setState(() {
          _loder = false;
        });
      },
    );
  }

  void buttom_sheet({
    // required String SubscriptionName,
    required String SubscriptionCharge,
    required String SubscriberId,
    required String DueAmount,
  }) {
    String? _selectedValue;
    String? p_mod;
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
                height: (MediaQuery.sizeOf(context).height / 2) - 20,
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
                          // Container(
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         SubscriptionName,
                          //         style: TextStyle(fontFamily: "Fontmain"),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            color: const Color.fromARGB(255, 223, 223, 223),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: "Cash",
                                        groupValue: p_mod,
                                        onChanged: (value) {
                                          p_mod = value;
                                          // amount_con.text=p_mod!;
                                          load.value =
                                              load.value ? false : true;
                                        },
                                      ),
                                      Text(
                                        "Cash",
                                        style:
                                            TextStyle(fontFamily: "Fontmain"),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: "Online",
                                        groupValue: p_mod,
                                        onChanged: (value) {
                                          p_mod = value;
                                          // amount_con.text=_selectedValue!;
                                          load.value =
                                              load.value ? false : true;
                                        },
                                      ),
                                      Text(
                                        "Online",
                                        style:
                                            TextStyle(fontFamily: "Fontmain"),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Radio(
                                value:DueAmount,
                                groupValue: _selectedValue,
                                onChanged: (value) {
                                  _selectedValue = value;
                                  amount_con.text = _selectedValue!;
                                  load.value = load.value ? false : true;
                                },
                              ),
                              Text(
                                "₹${DueAmount}",
                                style: TextStyle(fontFamily: "Fontmain"),
                              ),
                              // Radio(
                              //   value: SubscriptionCharge.toString(),
                              //   groupValue: _selectedValue,
                              //   onChanged: (value) {
                              //     _selectedValue = value;
                              //     amount_con.text = _selectedValue!;
                              //     load.value = load.value ? false : true;
                              //   },
                              // ),
                              // Text(
                              //   "₹${SubscriptionCharge.toString()}",
                              //   style: TextStyle(fontFamily: "Fontmain"),
                              // )
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
                                label: Text("Remark".tr),
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
                        if (p_mod != null) {
                          if (p_mod == "Cash") {
                            if (amount_con.text.isNotEmpty) {
                              sub_id = SubscriberId;
                              Api.SubscriptionInsert(
                                      Response: "",
                                      SendRequest: "",
                                      TStatus: "",
                                      mod_1_2: "-1",
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
                                            "Activated successfully this plan"
                                                .tr);
                                  } else if (value == "R200") {
                                    Api.snack_bar(
                                        context: context,
                                        message: "successfully Add on plan".tr);
                                  }
                                  Api.Mpin_check(
                                          mob_no: Api.prefs
                                                  .getString("mobile_no") ??
                                              "",
                                          Mpin:
                                              Api.prefs.getString("mpin") ?? "")
                                      .then(
                                    (value) {
                                      // Navigator.of(context).pop();
                                      // Navigator.of(context).pop();
                                      Api.PaymentList().then(
                                        (value) {
                                          _data.clear();
                                          _data = value;
                                          print(_data);
                                          setState(() {
                                            _loder = false;
                                          });
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            } else {
                              Api.snack_bar(
                                  context: context,
                                  message: "Please Select Amount".tr);
                            }
                          } else if (p_mod == "Online") {
                            if (amount_con.text.isNotEmpty) {
                              sub_id = SubscriberId;
                              log("my transactionId= ${generateTransactionId()}");
                              request["payUPaymentParams"] = {
                                "${PayUPaymentParamKey.amount}": amount_con.text,
                                "${PayUPaymentParamKey.firstName}":
                                    Api.User_info["Table"][0]["MemberName"],
                                PayUPaymentParamKey.email:
                                    Api.User_info["Table"][0]["EmailId"],
                                "${PayUPaymentParamKey.phone}":
                                    Api.User_info["Table"][0]["MobileNo"],
                                "${PayUPaymentParamKey.transactionId}":
                                    generateTransactionId(),
                                // transactionId Cannot be null or empty and should be unique for each transaction. Maximum allowed length is 25 characters. It cannot contain special characters like: -_/
                                "${PayUPaymentParamKey.userCredential}": Api
                                    .User_info["Table"][0]["Id"]
                                    .toInt()
                                    .toString(),
                                //  Format: <merchantKey>:<userId> ... UserId is any id/email/phone number to uniquely identify the user.
                              };

                              _checkoutPro
                                  .openCheckoutScreen(payUPaymentParams: {
                                // PayUPaymentParamKey.key: "nxmgUi",
                                PayUPaymentParamKey.key: "UiVBn1",
                                // PayUPaymentParamKey.amount: "10",
                                PayUPaymentParamKey.amount: amount_con.text,
                                PayUPaymentParamKey.productInfo: "Payu",
                                PayUPaymentParamKey.firstName:
                                    Api.User_info["Table"][0]["MemberName"],
                                PayUPaymentParamKey.email:
                                    Api.User_info["Table"][0]["EmailId"],
                                PayUPaymentParamKey.phone:
                                    Api.User_info["Table"][0]["MobileNo"],
                                PayUPaymentParamKey.environment: "1",
                                // String - "0" for Production and "1" for Test
                                PayUPaymentParamKey.transactionId:
                                    generateTransactionId(),
                                // transactionId Cannot be null or empty and should be unique for each transaction. Maximum allowed length is 25 characters. It cannot contain special characters like: -_/
                                PayUPaymentParamKey.userCredential: Api
                                    .User_info["Table"][0]["Id"]
                                    .toInt()
                                    .toString(),
                                //  Format: <merchantKey>:<userId> ... UserId is any id/email/phone number to uniquely identify the user.
                                PayUPaymentParamKey.android_surl:
                                    "https:///www.payumoney.com/mobileapp/payumoney/success.php",
                                PayUPaymentParamKey.android_furl:
                                    "https:///www.payumoney.com/mobileapp/payumoney/failure.php",
                                PayUPaymentParamKey.ios_surl:
                                    "https:///www.payumoney.com/mobileapp/payumoney/success.php",
                                PayUPaymentParamKey.ios_furl:
                                    "https:///www.payumoney.com/mobileapp/payumoney/failure.php",
                              }, payUCheckoutProConfig: {
                                PayUCheckoutProConfigKeys.merchantName: "PayU",
                              });
                            } else {
                              Api.snack_bar(
                                  context: context, message: "Select Amount");
                            }
                          }
                        } else {
                          Api.snack_bar(
                              context: context,
                              message: "Please Select Payment Mode".tr);
                        }
                      },
                      child: Container(
                        height: 60,
                        width: double.maxFinite,
                        color: Color(0xffC4A68B),
                        alignment: Alignment.center,
                        child: Text(
                          "Pay Amount".tr,
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

  void ref(bool a) {
    setState(() {
    _loder=true;
      
    });
    Api.PaymentList().then(
      (value) {
        _data.clear();
        _data = value;
        print(_data);
        setState(() {
          _loder = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment History".tr,
          style: TextStyle(fontFamily: "Fontmain"),
        ),
        backgroundColor: Color(0xffC4A68B),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          _data.isEmpty
              ? Center(child: Text("No Data Available".tr))
              : ListView(
                  children: histroy,
                  shrinkWrap: true,
                ),
          if (_loder)
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
      floatingActionButton:_data.isNotEmpty&& _data[0]["AccountBalance"] <= 0 ||_data.isNotEmpty&&
              _data[0]["AccountBalance"] == null
          ? GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => subscription_plan(ref: ref,),
                ));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Color(0xffC4A68B)),
                child: Text(
                  "Add plan",
                  style: TextStyle(fontFamily: "Fontmain", color: Colors.white),
                ),
              ),
            )
          : SizedBox(),
    );
  }

  @override
  generateHash(Map response) async {
    // Method 1 :
    Map hashResponse = HashService.generateHash(response);
    _checkoutPro.hashGenerated(hash: hashResponse);
  }

  @override
  onPaymentSuccess(dynamic response) {
    print("________________________________________________");

    log(response.toString());
    if (sub_id != null) {
      setState(() {
        _loder = true;
      });
      Navigator.pop(context);
      final payuResponse = jsonDecode(response["payuResponse"]) ?? {};
      Api.SubscriptionInsert(
              SendRequest: "${request.toString()}",
              Response: payuResponse.toString(),
              TStatus: payuResponse["status"],
              mod_1_2: "-2",
              Amount: payuResponse["amount"],
              BankRefNo: payuResponse["bank_ref_no"].toString(),
              PaymentMode: "Online",
              Remarks: remark_con.text,
              SubscriberId: sub_id!,
              TransctionNo: payuResponse["txnid"])
          .then(
        (value) {
          if (value == "R100") {
            Api.snack_bar2(
                context: context, message: "Activated successfully this plan");
          } else if (value == "R200") {
            Api.snack_bar(
                context: context, message: "successfully Add on plan");
          }
          Api.Mpin_check(
                  mob_no: Api.prefs.getString("mobile_no") ?? "",
                  Mpin: Api.prefs.getString("mpin") ?? "")
              .then(
            (value) {
              setState(() {
                _loder = false;
              });
              // Navigator.of(context).pop();
              // Navigator.of(context).pop();
              Api.PaymentList().then(
                (value) {
                  _data.clear();
                  _data = value;
                  print(_data);
                  setState(() {
                    _loder = false;
                  });
                },
              );
            },
          );
        },
      );
    } else {
      Api.snack_bar(context: context, message: "Error");
    }
    // Api.snack_bar(context: context, message: "payment Done");
  }

  @override
  onPaymentFailure(dynamic response) {
    log(response.toString());
    Api.snack_bar(context: context, message: "Error payment".tr);
  }

  @override
  onPaymentCancel(dynamic response) {
    log(response.toString());
    Api.snack_bar(context: context, message: "payment Cancel".tr);
  }

  @override
  onError(dynamic response) {
    log(response.toString());
  }
}
