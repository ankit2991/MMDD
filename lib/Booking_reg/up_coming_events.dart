import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/show_pdf.dart';

class UpComingEvents extends StatefulWidget {
  bool prev;
  UpComingEvents({this.prev = false});

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
  var amount_con2 = TextEditingController();
  var Payment_remark_con2 = TextEditingController();
  bool loder = false;
  void ref(bool a) {
    setState(() {
      loder = a;
    });
  }
  List<bool> save = [];
  bool service_data_loder = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    loder = true;
    _data.clear();
    if (widget.prev) {
      Api.EventBookingDetailsList(
              Is_booking: "1",
              Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                  "DueEvent")
          .then(
        (value) {
          _data = value;
          setState(() {
            loder = false;
          });
          // print(value);
        },
      );
    } else {
      Api.EventBookingDetailsList(
              Is_booking: "1",
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

 Future<void> add_payment({
    required int i,
    required String Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent
  }) async {
    ref(true);
    await Api.RecipitInsert(
            Amount: amount_con2.text.trim(),
            Remark: Payment_remark_con2.text.trim(),
            Event_id: _data[i]["id"].toInt().toString())
        .then(
      (value) {
        Api.EventBookingDetailsList(
                Is_booking: "1",
                Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                    Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent)
            .then(
          (value) {
            _data.clear();
            _data = value;
            Api.createPdf(
                    Total: _data[i]["TotalAmount"],
                    comp_mob_no: Api.User_info["Table"][0]["MobileNo"],
                    compny_name: Api.User_info["Table"][0]["OrgName"],
                    now_Date:
                        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                    cust_mob_no: _data[i]["MobileNo"],
                    cust_name: _data[i]["CustomerName"],
                    event_date: _data[i]["EventStartDate"],
                    event_name: _data[i]["EventName"],
                    data: [],
                    add_service: false,
                    Amount: amount_con2.text,
                    Du_Amount: _data[i]["DueAmount"],
                    remark: Payment_remark_con2.text,
                    Advance_Amount: _data[i]["BookingAmount"] ?? "")
                .then((value) {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => show_pdf(
                  my_pdf: value,
                ),
              ))
                  .then(
                (value) {
                  // Navigator.of(context).pop();
                  ref(false);
                  // loading.value =
                  //     false;
                },
              );
            });

            // print(value);
          },
        );
      },
    );
    amount_con.clear();
    remark_con.clear();
  }


Future<void> submit_service({required int i, required double tot,required Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent}) async {
    ref(true);
    await Api.RecipitFacilityInsert(
            Amount: tot.toString(),
            EventId: _data[i]["id"].toString(),
            Remarks: _data[i]["Remarks"].toString(),
            serviceAdd: submit_data)
        .then(
      (value) {
        if (value) {
          _data.clear();
          Api.EventBookingDetailsList(
                  Is_booking: "1",
                  Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                      Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent)
              .then(
            (value) {
              _data = value;
              Api.createPdf(
                      Total: tot.toString(),
                      comp_mob_no: Api.User_info["Table"][0]["MobileNo"],
                      compny_name: Api.User_info["Table"][0]["OrgName"],
                      now_Date:
                          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                      cust_mob_no: _data[i]["MobileNo"],
                      cust_name: _data[i]["CustomerName"],
                      event_date: _data[i]["EventStartDate"],
                      event_name: _data[i]["EventName"],
                      data: submit_data,
                      add_service: true)
                  .then(
                (value) async {
                  //               load = false;
                  // temp.value=temp.value?false:true;

                  // Navigator.of(
                  //         context)
                  //     .pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => show_pdf(
                      my_pdf: value,
                    ),
                  ))
                      .then(
                    (value) {
                      ref(false);
                    },
                  );
                },
              );

              // print(value);
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2.4,
          title: widget.prev
              ? Text('Due Register'.tr,
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'))
              : Text('UpComing Events'.tr,
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Fontmain')),
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
            loder || _data.isEmpty
                ? Center(child: Text("No Data Available".tr))
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
                          ValueNotifier<bool> temp = ValueNotifier(true);
                          // ValueNotifier<bool> load = ValueNotifier(false);
                          bool load = false;
                          return ValueListenableBuilder(
                            valueListenable: temp,
                            builder: (context, value, child) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: Container(
                                  height: MediaQuery.sizeOf(context).height / 2,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: [
                                      AppBar(
                                        title: Text('Add Service'.tr,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Fontmain',
                                                fontSize: 15)),
                                        backgroundColor: Color(0xffC4A68B),
                                        centerTitle: true,
                                        leading: IconButton(
                                          icon: Icon(Icons.arrow_back),
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
                                        height: (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2) -
                                            58,
                                        child: load
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : ListView.builder(
                                                // physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: load
                                                    ? 1
                                                    : service_data.length + 1,
                                                itemBuilder: (context, index) {
                                                  save.add(true);

                                                  select_Facility.add(false);
                                                  Quantity_con.add(
                                                      TextEditingController());
                                                  remark_con.add(
                                                      TextEditingController());
                                                  Total_con.add(
                                                      TextEditingController());

                                                  ValueNotifier<bool> check =
                                                      ValueNotifier(
                                                          select_Facility[
                                                              index]);
                                                  var price_con =
                                                      TextEditingController();
                                                  //  FocusNode qt_focus=FocusNode();
                                                  //  FocusNode remark_focus=FocusNode();
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
                                                  return service_data.length <=
                                                          index
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            load = true;
                                                            temp.value =
                                                                temp.value
                                                                    ? false
                                                                    : true;
                                                            // Navigator.of(context).pop();
                                                            print(submit_data);
                                                            for (var i = 0;
                                                                i <
                                                                    submit_data
                                                                        .length;
                                                                i++) {
                                                              if (submit_data[i]
                                                                      .length <=
                                                                  2) {
                                                                submit_data
                                                                    .removeAt(
                                                                        i);
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
                                                              if (Total_con[i]
                                                                      .text !=
                                                                  "") {
                                                                tot = double.parse(
                                                                        Total_con[i]
                                                                            .text) +
                                                                    tot;
                                                              }
                                                            }
                                                            print(submit_data);

                                                            if (submit_data
                                                                .isNotEmpty) {
                                                              load = true;
                                                              temp.value =
                                                                  temp.value
                                                                      ? false
                                                                      : true;
                                                              submit_service(
                                                                  i: Top_index,
                                                                  tot: tot,
                                                                  Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent: "UpcomingEvent"
                                                                  );
                                                              Navigator.pop(
                                                                  context);
                                                              // ssssssssssssssssssssss
                                                            } else {
                                                              // setState(() {
                                                              //   loading = false;
                                                              // });

                                                              Api.snack_bar(
                                                                  context:
                                                                      context,
                                                                  message:
                                                                      "pleace select services".tr);
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
                                                            alignment: Alignment
                                                                .center,
                                                            color: Color(
                                                                0xffC4A68B),
                                                            child: Text(
                                                              "Submit".tr,
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
                                                              value, child) {
                                                            return Container(
                                                              // height: 100,
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(5),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        blurRadius:
                                                                            2,
                                                                        color: Colors
                                                                            .black,
                                                                        offset: Offset(
                                                                            0,
                                                                            2))
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
                                                                          select_Facility
                                                                              .remove(index);
                                                                          select_Facility.insert(
                                                                              index,
                                                                              check.value ? false : true);
                                                                          check.value = check.value
                                                                              ? false
                                                                              : true;
                                                                          if (check
                                                                              .value) {
                                                                            submit_data.add({
                                                                              "\"Id\"": "\"${service_data[index]["Id"]}\""
                                                                            });
                                                                            save.removeAt(index);
                                                                            save.insert(index,
                                                                                true);
                                                                          } else {
                                                                            // ________________________________________________   Search element on list of map
                                                                            int element_index = submit_data.indexWhere((map) =>
                                                                                map["\"Id\""] ==
                                                                                "\"${service_data[index]["Id"].toString()}\"");
                                                                            print(element_index);
                                                                            submit_data.removeAt(element_index);
                                                                            save.removeAt(index);
                                                                            save.insert(index,
                                                                                false);
                                                                            print(submit_data);
                                                                          }
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        service_data[index]
                                                                            [
                                                                            "FacilityName"],
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "Fontmain"),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Container(
                                                                        width: (MediaQuery.of(context).size.width /
                                                                                3) -
                                                                            20,
                                                                        // color: Colors.amber,
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
                                                                            readOnly: save[index]
                                                                                ? false
                                                                                : true,
                                                                            onTap:
                                                                                () {
                                                                              // remark_focus.unfocus();
                                                                            },
                                                                            // focusNode: qt_focus,
                                                                            controller:
                                                                                Quantity_con[index],
                                                                            onChanged:
                                                                                (value) {
                                                                              if (value.isNotEmpty && value != " " && int.parse(value) > 0) {
                                                                                Total_con[index].text = (int.parse(value) * service_data[index]["Amount"]).toString();
                                                                                // submit_data.removeAt(index);
                                                                                // submit_data.insert(index, {"Id":"\"${service_data[index]["Id"]}\"","Name":"\"${service_data[index]["FacilityName"]}\"","Quantity":"\"${Quantity_con[index].text.trim()}\"","Price":"\"${price_con.text.trim()}\"","Total":"\"${total_con.text.trim()}\"","Remark":"\"${remark_con[index].text.trim()}\""});
                                                                              } else {
                                                                                Total_con[index].clear();
                                                                              }
                                                                            },
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            style:
                                                                                TextStyle(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)),
                                                                            decoration: InputDecoration(
                                                                                label: Text("Quantity".tr),
                                                                                labelStyle: TextStyle(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)),
                                                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145))),
                                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)))),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: (MediaQuery.of(context).size.width /
                                                                                3) -
                                                                            20,
                                                                        // color: Colors.amber,
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                5),
                                                                        child:
                                                                            IgnorePointer(
                                                                          ignoring:
                                                                              true,
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                price_con,
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            style:
                                                                                TextStyle(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)),
                                                                            decoration: InputDecoration(
                                                                                labelText: "price".tr,
                                                                                labelStyle: TextStyle(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)),
                                                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145))),
                                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)))),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: (MediaQuery.of(context).size.width /
                                                                                3) -
                                                                            20,
                                                                        // color: Colors.amber,
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                5),
                                                                        child:
                                                                            IgnorePointer(
                                                                          ignoring:
                                                                              true,
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                Total_con[index],
                                                                            style:
                                                                                TextStyle(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)),
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            decoration: InputDecoration(
                                                                                labelText: "Total".tr,
                                                                                labelStyle: TextStyle(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)),
                                                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145))),
                                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)))),
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
                                                                      ignoring: check
                                                                              .value
                                                                          ? false
                                                                          : true,
                                                                      child:
                                                                          TextFormField(
                                                                        readOnly: save[index]
                                                                            ? false
                                                                            : true,
                                                                        // focusNode: remark_focus,
                                                                        controller:
                                                                            remark_con[index],
                                                                        style: TextStyle(
                                                                            color: check.value
                                                                                ? const Color.fromARGB(255, 0, 0, 0)
                                                                                : const Color.fromARGB(255, 146, 145, 145)),
                                                                        decoration: InputDecoration(
                                                                            labelText:
                                                                                "remark".tr,
                                                                            labelStyle:
                                                                                TextStyle(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)),
                                                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145))),
                                                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)))),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        if (save[
                                                                            index])
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              if (Quantity_con[index].text.isNotEmpty && int.parse(Quantity_con[index].text) >= 1) {
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
                                                                                  // qt_focus.unfocus();
                                                                                  // remark_focus.unfocus();

                                                                                  save.removeAt(index);
                                                                                  save.insert(index, false);
                                                                                  temp.value = temp.value == true ? false : true;
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
                                                                                  //     qt_focus.unfocus();                                                                            qt_focus.unfocus();
                                                                                  // remark_focus.unfocus();

                                                                                  save.removeAt(index);
                                                                                  save.insert(index, false);
                                                                                  temp.value = temp.value == true ? false : true;
                                                                                }
                                                                                // submit_data.removeAt(element_index);

                                                                                // submit_data.insert(index, );
                                                                                print(remark_con[index].text);
                                                                              } else {
                                                                                Api.snack_bar(context: context, message: "Enter Quantity");
                                                                              }
                                                                            },
                                                                            child: Container(
                                                                                margin: EdgeInsets.symmetric(vertical: 10),
                                                                                height: 50,
                                                                                width: 100,
                                                                                alignment: Alignment.center,
                                                                                color: check.value ? Color(0xffC4A68B) : Color.fromARGB(139, 196, 166, 139),
                                                                                child: Text(
                                                                                  "SAVE".tr,
                                                                                  style: TextStyle(fontFamily: "Fontmain", color: Colors.white),
                                                                                )),
                                                                          )
                                                                      ])
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
                                    child: Text('ADD SERVICE'.tr,
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
                                    amount_con2.clear();
                                    Payment_remark_con2.clear();
                                     showModalBottomSheet(
                        context: context,
                        // enableDrag: true,
                        // isDismissible: true,
                        isScrollControlled: true,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  AppBar(
                                    title: Text('Add Payment'.tr,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Fontmain',
                                            fontSize: 15)),
                                    backgroundColor: Color(0xffC4A68B),
                                    centerTitle: true,
                                    leading: IconButton(
                                      icon: Icon(Icons.arrow_back),
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          child: Container(
                                            child: Column(
                                              spacing: 10,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          _data[Top_index][
                                                              "EventStartDate"],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Fontmain'),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      _data[Top_index]["CustomerName"],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Fontmain'),
                                                    ),
                                                    Text(
                                                      _data[Top_index]["EventName"],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Fontmain'),
                                                    ),
                                                    Text(
                                                      _data[Top_index]["MobileNo"],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Fontmain'),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              if (_data[Top_index][
                                                                      "TotalAmount"] !=
                                                                  null)
                                                                Text(
                                                                  "Total Amount : ₹ ${_data[Top_index]["TotalAmount"]}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Fontmain',
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              if (_data[Top_index][
                                                                      "BookingAmount"] !=
                                                                  null)
                                                                Text(
                                                                  "Advance Amount : ₹ ${_data[Top_index]["BookingAmount"]}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Fontmain',
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              if (_data[Top_index][
                                                                      "DueAmount"] !=
                                                                  null)
                                                                Text(
                                                                  "Due Amount : ₹ ${_data[Top_index]["DueAmount"]}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Fontmain',
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  child: TextFormField(
                                                    controller: amount_con2,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        hintText: "Amount".tr,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black)),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black))),
                                                  ),
                                                ),
                                                Container(
                                                  child: TextFormField(
                                                    controller:
                                                        Payment_remark_con2,
                                                    decoration: InputDecoration(
                                                        hintText: "Remark".tr,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black)),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black))),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    // Navigator.of(context).pop();
                                                    if (amount_con2
                                                        .text.isNotEmpty) {
                                                      if (int.parse(_data[Top_index]
                                                              ["DueAmount"]) >=
                                                          int.parse(amount_con2
                                                              .text
                                                              .trim())) {
                                                        // loading.value = true;
                                                        add_payment(i: Top_index,Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent: "UpcomingEvent");
                                                        Navigator.pop(context);
                                                        // Api.
                                                      } else {
                                                        Api.snack_bar(
                                                            context: context,
                                                            message:
                                                                "Invalid Amount");
                                                      }
                                                    } else {
                                                      Api.snack_bar(
                                                          context: context,
                                                          message:
                                                              "Enter the Amount");
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    color: Color(0xffC4A68B),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Save".tr,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Fontmain',
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
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
                                    child: Text('ADD PAYMENT'.tr,
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
