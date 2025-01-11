import 'dart:developer';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mddmerchant/App_bar/OurService/our_service.dart';
import 'package:mddmerchant/Booking_reg/up_coming_events.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/constrans.dart';
import 'package:mddmerchant/Due_register/due_register.dart';
import 'package:mddmerchant/Enquiry/enquiry.dart';
import 'package:mddmerchant/My_album/my_album.dart';
import 'package:mddmerchant/Promoss and ads/promoss_ads.dart';
import 'package:mddmerchant/Q&A/quality_assurance.dart';
import 'package:mddmerchant/Booking_reg/booking_regi.dart';
import 'package:mddmerchant/App_bar/user_acc.dart';
import 'package:mddmerchant/localization/app_localization.dart';
import 'package:mddmerchant/screen/subdcription_plan.dart';

// import 'package:carousel_slider/carousel_slider.dart';
import 'package:mddmerchant/screen/spalashscreen.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

import 'package:mddmerchant/show_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Api.local_dataBase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    print(Api.prefs.getBool('login'));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MDD Merchant',
      translations: AppTranslations(), // Your translations
      locale: Locale('en', 'US'), // Default locale
      fallbackLocale: Locale('en', 'US'), // Fallback locale
      supportedLocales: [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
      ],
      localizationsDelegates: [
        // const InfosLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: ThemeData(
        fontFamily: 'Fontmain',
        scaffoldBackgroundColor: kBackgrundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: Splashscreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool loading = false;

List<dynamic> _banners_data = [];
List<Widget> _banners_images = [];
List<dynamic> _data = [];
List<dynamic> service_data = [];
List<Map<String, dynamic>> submit_data = [];
List<bool> select_Facility = [];
List<bool> save = [];
List<TextEditingController> Quantity_con = [];
List<TextEditingController> remark_con = [];
// List<TextEditingController> price_con=[];
List<TextEditingController> Total_con = [];
var amount_con = TextEditingController();
var amount_con2 = TextEditingController();
var Payment_remark_con = TextEditingController();
var Payment_remark_con2 = TextEditingController();
bool service_data_loder = false;
// var prefs;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void ref(bool a) {
    setState(() {
      loading = a;
    });
  }

  List<Widget> today_event = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (Api.prefs.getInt("is_Hindi") == 0) {
          Get.updateLocale(Locale('en', 'US'));
        } else {
          Get.updateLocale(Locale('hi', 'IN'));
        }
      },
    );

    Api.BannerReport().then(
      (value) {
        _banners_data.clear();
        _banners_images.clear();
        _banners_data = value;
        for (var i = 0; i < _banners_data.length; i++) {
          String temp = _banners_data[i]["ImgName"].split(",").last;
          try {
            final file = base64Decode(temp);
            _banners_images.add(Image.memory(
              file,
              fit: BoxFit.cover,
            ));
          } catch (e) {
            _banners_images.add(Image.asset(
              "assets/images/main/img.jpg",
              fit: BoxFit.cover,
            ));
          }
        }
        _banners_images.add(GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => send_enquiry(
                    service_name: "Advertisement Template",
                  ),
                ));
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/main/addImage.png"))),
          ),
        ));
        Api.EventBookingDetailsList(
                Is_booking: "1",
                Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                    "TodayEvent")
            .then(
          (value) {
            _data = value;

            Api.Service_Question_List().then(
              (value) {
                Api.get_Merchent_Trem_And_Condition().then(
                  (value) {
                    Api.getLogo(url: Api.User_info["Table"][0]["LogoImg"]).then((value) {
                    setState(() {
                      loading = false;
                    });
                      
                    },);
                  },
                );
              },
            );

            // print(value);
          },
        );
      },
    );
  }
    bool add_booking=false;
void update_booking(bool a){
  add_booking=a;
}
  @override
  Widget build(BuildContext context) {
    print("${Api.prefs.getInt("is_Hindi")}");
    today_event.clear();
    for (var i = 0; i < _data.length; i++) {
      today_event.add(Container(
        padding: EdgeInsets.only(top: 5, right: 5, left: 5, bottom: 15),
        margin: EdgeInsets.only(top: 5, right: 5, left: 5, bottom: 10),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width) - 40,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _data[i]["EventStartDate"],
                    style: TextStyle(fontFamily: 'Fontmain'),
                  ),
                ],
              ),
            ),
            Text(
              _data[i]["CustomerName"],
              style: TextStyle(fontFamily: 'Fontmain'),
            ),
            Text(
              _data[i]["EventName"],
              style: TextStyle(fontFamily: 'Fontmain'),
            ),
            Text(
              _data[i]["MobileNo"],
              style: TextStyle(fontFamily: 'Fontmain'),
            ),
            Container(
              width: (MediaQuery.of(context).size.width) - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (_data[i]["TotalAmount"] != null)
                          Text(
                            "Total Amount : ₹ ${_data[i]["TotalAmount"]}",
                            style:
                                TextStyle(fontFamily: 'Fontmain', fontSize: 10),
                          ),
                        if (_data[i]["BookingAmount"] != null)
                          Text(
                            "Advance Amount : ₹ ${_data[i]["BookingAmount"]}",
                            style:
                                TextStyle(fontFamily: 'Fontmain', fontSize: 10),
                          ),
                        if (_data[i]["DueAmount"] != null)
                          Text(
                            "Due Amount : ₹ ${_data[i]["DueAmount"]}",
                            style:
                                TextStyle(fontFamily: 'Fontmain', fontSize: 10),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width) - 40,
              child: Row(
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
                          ValueNotifier<bool> load = ValueNotifier(false);
                          
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
                                        title: Text('Add Service',
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
                                        child: ListView.builder(
                                          // physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: service_data.length + 1,
                                          itemBuilder: (context, index) {
                                            save.add(true);

                                            select_Facility.add(false);
                                            Quantity_con.add(
                                                TextEditingController());
                                            remark_con
                                                .add(TextEditingController());
                                            Total_con.add(
                                                TextEditingController());

                                            ValueNotifier<bool> check =
                                                ValueNotifier(
                                                    select_Facility[index]);
                                            var price_con =
                                                TextEditingController();
                                                //  FocusNode qt_focus=FocusNode();
                                                //  FocusNode remark_focus=FocusNode();
                                            if (service_data.length > index) {
                                              price_con.text =
                                                  service_data[index]["Amount"]
                                                      .toString();
                                            }

                                            // var quentity_con =
                                            //     TextEditingController();
                                            // var remark_con =
                                            //     TextEditingController();
                                            // var total_con =
                                            // TextEditingController();
                                            // bool check=false;
                                            return service_data.length <= index
                                                ? GestureDetector(
                                                    onTap: () async {
                                                      load.value = true;
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
                                                              .removeAt(i);
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
                                                        if (Total_con[i].text !=
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
                                                        await Api.RecipitFacilityInsert(
                                                                Amount: tot
                                                                    .toString(),
                                                                EventId: _data[
                                                                        i]["id"]
                                                                    .toString(),
                                                                Remarks: _data[
                                                                            i][
                                                                        "Remarks"]
                                                                    .toString(),
                                                                serviceAdd:
                                                                    submit_data)
                                                            .then(
                                                          (value) {
                                                            if (value) {
                                                              _data.clear();
                                                              Api.EventBookingDetailsList(
                                                                      Is_booking:
                                                                          "1",
                                                                      Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                                                                          "TodayEvent")
                                                                  .then(
                                                                (value) {
                                                                  _data = value;
                                                                  Api.createPdf(
                                                                          Total: tot
                                                                              .toString(),
                                                                          comp_mob_no: Api.User_info["Table"][0][
                                                                              "MobileNo"],
                                                                          compny_name: Api.User_info["Table"][0]
                                                                              [
                                                                              "OrgName"],
                                                                          now_Date:
                                                                              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                                                          cust_mob_no: _data[i]
                                                                              [
                                                                              "MobileNo"],
                                                                          cust_name: _data[i]
                                                                              [
                                                                              "CustomerName"],
                                                                          event_date:
                                                                              _data[i]["EventStartDate"],
                                                                          event_name: _data[i]["EventName"],
                                                                          data: submit_data,
                                                                          add_service: true)
                                                                      .then(
                                                                    (value) async {
                                                                      ref(false);
                                                                      load.value =
                                                                          false;
                                                                      // final directory = await getTemporaryDirectory();
                                                                      // final file = File("${directory!.path}/${DateTime.now().millisecondsSinceEpoch}.pdf");
                                                                      // await file.writeAsBytes(await value.save());
                                                                      // showDialog(
                                                                      //   context: context,
                                                                      //   builder: (context) {
                                                                      //     return Container(
                                                                      //       height: double.maxFinite,
                                                                      //       width: double.maxFinite,
                                                                      //       color: Colors.amber,
                                                                      //       margin: EdgeInsets.all(20),
                                                                      //       child: SfPdfViewer.file(file),
                                                                      //     );
                                                                      //   },
                                                                      // );
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                              MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                show_pdf(
                                                                          my_pdf:
                                                                              value,
                                                                        ),
                                                                      ));
                                                                    },
                                                                  );

                                                                  // print(value);
                                                                },
                                                              );
                                                            }
                                                          },
                                                        );
                                                      } else {
                                                        setState(() {
                                                          loading = false;
                                                        });

                                                        Api.snack_bar(
                                                            context: context,
                                                            message:
                                                                "palce select services");
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      alignment:
                                                          Alignment.center,
                                                      color: Color(0xffC4A68B),
                                                      child: Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "Fontmain"),
                                                      ),
                                                    ),
                                                  )
                                                : ValueListenableBuilder(
                                                    valueListenable: check,
                                                    builder: (context, value,
                                                        child) {
                                                      return Container(
                                                        // height: 100,
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 2,
                                                                  color: Colors
                                                                      .black,
                                                                  offset:
                                                                      Offset(
                                                                          0, 2))
                                                            ]),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Checkbox(
                                                                  value: value,
                                                                  onChanged:
                                                                      (value) {
                                                                    select_Facility
                                                                        .remove(
                                                                            index);
                                                                    select_Facility.insert(
                                                                        index,
                                                                        check.value
                                                                            ? false
                                                                            : true);
                                                                    check
                                                                        .value = check
                                                                            .value
                                                                        ? false
                                                                        : true;
                                                                    if (check
                                                                        .value) {
                                                                      submit_data
                                                                          .add({
                                                                        "\"Id\"":
                                                                            "\"${service_data[index]["Id"]}\""
                                                                      });
                                                                      save.removeAt(
                                                                          index);
                                                                      save.insert(
                                                                          index,
                                                                          true);
                                                                    } else {
                                                                      // ________________________________________________   Search element on list of map
                                                                      int element_index = submit_data.indexWhere((map) =>
                                                                          map["\"Id\""] ==
                                                                          "\"${service_data[index]["Id"].toString()}\"");
                                                                      print(
                                                                          element_index);
                                                                      submit_data
                                                                          .removeAt(
                                                                              element_index);
                                                                      save.removeAt(
                                                                          index);
                                                                      save.insert(
                                                                          index,
                                                                          false);
                                                                      print(
                                                                          submit_data);
                                                                    }
                                                                  },
                                                                ),
                                                                Text(
                                                                  service_data[
                                                                          index]
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
                                                                  width: (MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3) -
                                                                      20,
                                                                  // color: Colors.amber,
                                                                  margin: EdgeInsets
                                                                      .only(
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
                                                                          readOnly: save[index]?false:true,
                                                                          onTap: (){
                                                                            // remark_focus.unfocus();
                                                                          },
                                                                          // focusNode: qt_focus,
                                                                      controller:
                                                                          Quantity_con[
                                                                              index],
                                                                      onChanged:
                                                                          (value) {
                                                                        if (value.isNotEmpty &&
                                                                            value !=
                                                                                " " &&
                                                                            int.parse(value) >
                                                                                0) {
                                                                          Total_con[index].text =
                                                                              (int.parse(value) * service_data[index]["Amount"]).toString();
                                                                          // submit_data.removeAt(index);
                                                                          // submit_data.insert(index, {"Id":"\"${service_data[index]["Id"]}\"","Name":"\"${service_data[index]["FacilityName"]}\"","Quantity":"\"${Quantity_con[index].text.trim()}\"","Price":"\"${price_con.text.trim()}\"","Total":"\"${total_con.text.trim()}\"","Remark":"\"${remark_con[index].text.trim()}\""});
                                                                        } else {
                                                                          Total_con[index]
                                                                              .clear();
                                                                        }
                                                                      },
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      style: TextStyle(
                                                                          color: check.value
                                                                              ? const Color.fromARGB(255, 0, 0, 0)
                                                                              : const Color.fromARGB(255, 146, 145, 145)),
                                                                      decoration: InputDecoration(
                                                                          label: Text(
                                                                              "Quantity"),
                                                                          labelStyle:
                                                                              TextStyle(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)),
                                                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145))),
                                                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)))),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: (MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3) -
                                                                      20,
                                                                  // color: Colors.amber,
                                                                  margin: EdgeInsets
                                                                      .only(
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
                                                                          TextInputType
                                                                              .number,
                                                                      style: TextStyle(
                                                                          color: check.value
                                                                              ? const Color.fromARGB(255, 0, 0, 0)
                                                                              : const Color.fromARGB(255, 146, 145, 145)),
                                                                      decoration: InputDecoration(
                                                                          labelText:
                                                                              "price",
                                                                          labelStyle:
                                                                              TextStyle(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)),
                                                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145))),
                                                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color:  check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)))),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: (MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3) -
                                                                      20,
                                                                  // color: Colors.amber,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              5),
                                                                  child:
                                                                      IgnorePointer(
                                                                    ignoring:
                                                                        true,
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          Total_con[
                                                                              index],
                                                                      style: TextStyle(
                                                                          color: check.value
                                                                              ? const Color.fromARGB(255, 0, 0, 0)
                                                                              : const Color.fromARGB(255, 146, 145, 145)),
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      decoration: InputDecoration(
                                                                          labelText:
                                                                              "Total",
                                                                          labelStyle:
                                                                              TextStyle(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)),
                                                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color:  check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145))),
                                                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color:  check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145)))),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          5),
                                                              child:
                                                                  IgnorePointer(
                                                                ignoring:
                                                                    check.value
                                                                        ? false
                                                                        : true,
                                                                child:
                                                                    TextFormField(
                                                                       
                                                                          readOnly: save[index]?false:true,
                                                                      // focusNode: remark_focus,
                                                                  controller:
                                                                      remark_con[
                                                                          index],
                                                                  style: TextStyle(
                                                                      color: check
                                                                              .value
                                                                          ? const Color.fromARGB(255, 0, 0, 0)
                                                                          : const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              146,
                                                                              145,
                                                                              145)),
                                                                  decoration: InputDecoration(
                                                                      labelText:
                                                                          "remark",
                                                                      labelStyle: TextStyle(
                                                                          color: check.value
                                                                              ? const Color.fromARGB(255, 0, 0, 0)
                                                                              : const Color.fromARGB(255, 146, 145,
                                                                                  145)),
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              5),
                                                                          borderSide:
                                                                              BorderSide(color: check.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 146, 145, 145))),
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
                                                                      onTap: (){
                                                                        
                                                                            if (Quantity_con[index].text.isNotEmpty &&
                                                                                int.parse(Quantity_con[index].text) >= 1) {
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
                                                                            }else{
                                                                              Api.snack_bar(context: context, message: "Enter Quantity");
                                                                            }
                                                                      },
                                                                      child: Container(
                                                                          margin: EdgeInsets.symmetric(
                                                                              vertical:
                                                                                  10),
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              100,
                                                                          alignment:
                                                                              Alignment
                                                                                  .center,
                                                                          color: check.value
                                                                              ? Color(
                                                                                  0xffC4A68B)
                                                                              : Color.fromARGB(
                                                                                  139,
                                                                                  196,
                                                                                  166,
                                                                                  139),
                                                                          child:
                                                                              Text("SAVE",style:TextStyle(fontFamily: "Fontmain", color: Colors.white),
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
                      ).then((value) {
                        // save.clear();
                      },);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5, top: 5),
                      height: 45,
                      width: (MediaQuery.of(context).size.width / 2) - 30,
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
                      ValueNotifier<bool> loading = ValueNotifier(false);
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
                                  ValueListenableBuilder(
                                    valueListenable: loading,
                                    builder: (context, value, child) {
                                      return loading.value
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : Padding(
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
                                                                _data[i][
                                                                    "EventStartDate"],
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Fontmain'),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            _data[i][
                                                                "CustomerName"],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Fontmain'),
                                                          ),
                                                          Text(
                                                            _data[i]
                                                                ["EventName"],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Fontmain'),
                                                          ),
                                                          Text(
                                                            _data[i]
                                                                ["MobileNo"],
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
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    if (_data[i]
                                                                            [
                                                                            "TotalAmount"] !=
                                                                        null)
                                                                      Text(
                                                                        "Total Amount : ₹ ${_data[i]["TotalAmount"]}",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Fontmain',
                                                                            fontSize:
                                                                                10),
                                                                      ),
                                                                    if (_data[i]
                                                                            [
                                                                            "BookingAmount"] !=
                                                                        null)
                                                                      Text(
                                                                        "Advance Amount : ₹ ${_data[i]["BookingAmount"]}",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Fontmain',
                                                                            fontSize:
                                                                                10),
                                                                      ),
                                                                    if (_data[i]
                                                                            [
                                                                            "DueAmount"] !=
                                                                        null)
                                                                      Text(
                                                                        "Due Amount : ₹ ${_data[i]["DueAmount"]}",
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
                                                          controller:
                                                              amount_con2,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  "Amount",
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderSide: BorderSide(
                                                                      color: Colors
                                                                          .black)),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.black))),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: TextFormField(
                                                          controller:
                                                              Payment_remark_con2,
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  "Remark",
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderSide: BorderSide(
                                                                      color: Colors
                                                                          .black)),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.black))),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          // Navigator.of(context).pop();
                                                          loading.value = true;
                                                          await Api.RecipitInsert(
                                                                  Amount:
                                                                      amount_con2
                                                                          .text
                                                                          .trim(),
                                                                  Remark:
                                                                      Payment_remark_con2
                                                                          .text
                                                                          .trim(),
                                                                  Event_id: _data[
                                                                              i]
                                                                          ["id"]
                                                                      .toInt()
                                                                      .toString())
                                                              .then(
                                                            (value) {
                                                              Api.EventBookingDetailsList(
                                                                      Is_booking:
                                                                          "1",
                                                                      Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                                                                          "TodayEvent")
                                                                  .then(
                                                                (value) {
                                                                  _data.clear();
                                                                  _data = value;
                                                                  Api.createPdf(
                                                                          Total: _data[i]
                                                                              [
                                                                              "TotalAmount"],
                                                                          comp_mob_no: Api.User_info["Table"][0]
                                                                              [
                                                                              "MobileNo"],
                                                                          compny_name: Api.User_info["Table"][0]
                                                                              [
                                                                              "OrgName"],
                                                                          now_Date:
                                                                              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                                                          cust_mob_no: _data[i]
                                                                              [
                                                                              "MobileNo"],
                                                                          cust_name:
                                                                              _data[i]["CustomerName"],
                                                                          event_date: _data[i]["EventStartDate"],
                                                                          event_name: _data[i]["EventName"],
                                                                          data: [],
                                                                          add_service: false,
                                                                          Amount: amount_con2.text,
                                                                          Du_Amount: _data[i]["DueAmount"],
                                                                          remark: Payment_remark_con2.text,
                                                                          Advance_Amount: _data[i]["BookingAmount"] ?? "")
                                                                      .then((value) {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    setState(
                                                                        () {
                                                                      loading.value =
                                                                          false;
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                            MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              show_pdf(
                                                                        my_pdf:
                                                                            value,
                                                                      ),
                                                                    ));
                                                                  });

                                                                  // print(value);
                                                                },
                                                              );
                                                            },
                                                          );
                                                          amount_con.clear();
                                                          remark_con.clear();

                                                          // Api.
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          color:
                                                              Color(0xffC4A68B),
                                                          alignment:
                                                              Alignment.center,
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
                                            );
                                    },
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
                      width: (MediaQuery.of(context).size.width / 2) - 30,
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
              ),
            )
          ],
        ),
      ));
    }

    // var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading: false,
          elevation: 2.0,
          // centerTitle: true,
          title: Text(Api.User_info["Table"][0]["MemberName"],
              style: TextStyle(
                // fontWeight: FontWeight.w700,
                color: Colors.white,
                fontFamily: 'Fontmain',
              )),
          // centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                if (Api.prefs.getInt('is_Hindi') == 0) {
                  await Api.prefs.setInt('is_Hindi', 1);
                  Get.updateLocale(Locale('hi', 'IN'));
                } else {
                  await Api.prefs.setInt('is_Hindi', 0);
                  Get.updateLocale(Locale('en', 'US'));
                }
                Api.Service_Question_List().then(
                  (value) {
                    setState(() {
                      loading = false;
                    });
                  },
                );
                print(Api.prefs.getInt('is_Hindi'));
              },
              icon: Icon(Icons.g_translate_rounded,
                  color: Colors.white, size: 30),
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
            ), // Custom home icon
          ]),
      body: Stack(children: <Widget>[
        SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 00),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      if (_banners_data.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height:
                                (MediaQuery.of(context).size.height / 3) - 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: AnotherCarousel(
                              images: _banners_images,
                              dotSize: 5.0,
                              dotSpacing: 15.0,
                              dotColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              indicatorBgPadding: 5.0,
                              dotBgColor: const Color.fromARGB(0, 0, 0, 0),
                              dotVerticalPadding: 10,
                              // animationCurve: Curves.decelerate,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(bottom: 10),
                          shrinkWrap: true,
                          children: [
                            if (_data.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height:
                                      (MediaQuery.of(context).size.height / 3) -
                                          20,
                                  width: double.infinity,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(0, 184, 181, 181),
                                    // boxShadow: [BoxShadow(
                                    //                   blurRadius: 0.5,
                                    //                   color: const Color.fromARGB(
                                    //                       134, 0, 0, 0),
                                    //                   offset: Offset(1, 1))]
                                  ),
                                  child: AnotherCarousel(
                                    images: today_event,
                                    autoplay: false,
                                    dotSize: 5.0,
                                    dotSpacing: 15.0,
                                    dotIncreasedColor: Colors.black,
                                    dotColor:
                                        const Color.fromARGB(255, 0, 0, 0),
                                    indicatorBgPadding: 5.0,
                                    dotBgColor:
                                        const Color.fromARGB(1, 0, 0, 0),
                                    dotVerticalPadding: 10,
                                    // animationCurve: Curves.decelerate,
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              crossAxisCount: 2,
                              childAspectRatio: .84,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              // childAspectRatio: 2,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Your onTap functionality here
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyAlbum()),
                                    ).then(
                                      (value) {
                                        print("object");
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 100, // Set your desired width
                                    height: 100, // Set your desired height
                                    padding: EdgeInsets.all(
                                        12), // Adds padding around the contents
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.3), // Shadow color
                                          spreadRadius:
                                              2, // Spread of the shadow
                                          blurRadius:
                                              2, // Blur radius of the shadow
                                          offset: Offset(
                                              0, 2), // Position of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Image.asset(
                                          "assets/images/main/myalbum.png",
                                          width:
                                              100, // Adjust the width as needed
                                          height:
                                              100, // Adjust the height as needed
                                          fit: BoxFit
                                              .cover, // Optional: Adjusts how the image is fitted
                                        ),
                                        Spacer(),
                                        Text(
                                          "Album".tr,
                                          // "My Album",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Fontmain',
                                            // fontWeight: FontWeight.w400
                                          ), // Slightly reduced font size
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 0,
                                // ),
                                InkWell(
                                  onTap: () {
                                    if (((Api.User_info["Table"][0]
                                                ["IsQuestionSubmited"] !=
                                            null) &&
                                        (Api.User_info["Table"][0]
                                                ["IsQuestionSubmited"] ==
                                            true))) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                subscription_plan(
                                                  ref: ref,
                                                )),
                                      );
                                    } else {
                                      // Navigator.of(context).push(co)
                                      //    Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => MyAlbum()),
                                      // );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QualityAss(
                                                  ref: ref,
                                                )),
                                      );
                                      // Your onTap functionality here
                                      print("Q&A clicked!");
                                    }
                                  },
                                  child: Container(
                                    width: 100, // Set your desired width
                                    height: 100, // Set your desired height
                                    padding: EdgeInsets.all(
                                        12), // Adds padding around the contents
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.3), // Shadow color
                                          spreadRadius:
                                              2, // Spread of the shadow
                                          blurRadius:
                                              2, // Blur radius of the shadow
                                          offset: Offset(
                                              0, 2), // Position of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Image.asset(
                                          "assets/images/main/q&a.png",
                                          width:
                                              100, // Adjust the width as needed
                                          height:
                                              100, // Adjust the height as needed
                                          fit: BoxFit
                                              .cover, // Optional: Adjusts how the image is fitted
                                        ),
                                        Spacer(),
                                        Api.H_Questions.isNotEmpty
                                            ? ((Api.User_info["Table"][0][
                                                            "IsQuestionSubmited"] !=
                                                        null) &&
                                                    (Api.User_info["Table"][0][
                                                            "IsQuestionSubmited"] ==
                                                        true))
                                                ? Text(
                                                    "Social Accounts".tr,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Fontmain',
                                                      // fontWeight: FontWeight.w700
                                                    ), // Slightly reduced font size
                                                  )
                                                : Text(
                                                    "Q&A".tr,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Fontmain',
                                                      // fontWeight: FontWeight.w700
                                                    ), // Slightly reduced font size
                                                  )
                                            : Text("Q&A".tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Fontmain',
                                                )),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyBoking(add_booking: update_booking,)),
                                    ).then(
                                      (value) {
                                        if(add_booking){
                                          setState(() {
                                          loading = true;
                                        });
                                        Api.EventBookingDetailsList(
                                                Is_booking: "1",
                                                Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:
                                                    "TodayEvent")
                                            .then(
                                          (value) {
                                            _data = value;

                                            Api.Service_Question_List().then(
                                              (value) {
                                                Api.get_Merchent_Trem_And_Condition()
                                                    .then(
                                                  (value) {
                                                    setState(() {
                                                      loading = false;
                                                      add_booking=false;
                                                    });
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
                                  },
                                  child: Container(
                                    width: 100, // Set your desired width
                                    height: 100, // Set your desired height
                                    padding: EdgeInsets.all(
                                        12), // Adds padding around the contents
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.3), // Shadow color
                                          spreadRadius:
                                              2, // Spread of the shadow
                                          blurRadius:
                                              2, // Blur radius of the shadow
                                          offset: Offset(
                                              0, 2), // Position of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Image.asset(
                                          "assets/images/main/bookingregister.png",
                                          width:
                                              100, // Adjust the width as needed
                                          height:
                                              100, // Adjust the height as needed
                                          fit: BoxFit
                                              .cover, // Optional: Adjusts how the image is fitted
                                        ),
                                        Spacer(),
                                        Text(
                                          "Booking Register".tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Fontmain',
                                            // fontWeight: FontWeight.w700
                                          ), // Slightly reduced font size
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyEnquiry()),
                                    );
                                  },
                                  child: Container(
                                    width: 100, // Set your desired width
                                    height: 100, // Set your desired height
                                    padding: EdgeInsets.all(
                                        12), // Adds padding around the contents
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.3), // Shadow color
                                          spreadRadius:
                                              2, // Spread of the shadow
                                          blurRadius:
                                              2, // Blur radius of the shadow
                                          offset: Offset(
                                              0, 2), // Position of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Image.asset(
                                          "assets/images/main/enquiry.png",
                                          width:
                                              100, // Adjust the width as needed
                                          height:
                                              100, // Adjust the height as needed
                                          fit: BoxFit
                                              .cover, // Optional: Adjusts how the image is fitted
                                        ),
                                        Spacer(),
                                        Text(
                                          "Enquiry".tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Fontmain',
                                            // fontWeight: FontWeight.w700
                                          ), // Slightly reduced font size
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Your onTap functionality here
                                    // print("Container clicked!");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PromissAds()),
                                    );
                                  },
                                  child: Container(
                                    width: 100, // Set your desired width
                                    height: 100, // Set your desired height
                                    padding: EdgeInsets.all(
                                        12), // Adds padding around the contents
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.3), // Shadow color
                                          spreadRadius:
                                              2, // Spread of the shadow
                                          blurRadius:
                                              2, // Blur radius of the shadow
                                          offset: Offset(
                                              0, 2), // Position of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Image.asset(
                                          "assets/images/main/ads.png",
                                          width:
                                              100, // Adjust the width as needed
                                          height:
                                              100, // Adjust the height as needed
                                          fit: BoxFit
                                              .cover, // Optional: Adjusts how the image is fitted
                                        ),
                                        Spacer(),
                                        Text(
                                          "Promos & Ads".tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Fontmain',
                                            // fontWeight: FontWeight.w700
                                          ), // Slightly reduced font size
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpComingEvents(
                                                prev: true,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    width: 100, // Set your desired width
                                    height: 100, // Set your desired height
                                    padding: EdgeInsets.all(
                                        12), // Adds padding around the contents
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.3), // Shadow color
                                          spreadRadius:
                                              2, // Spread of the shadow
                                          blurRadius:
                                              2, // Blur radius of the shadow
                                          offset: Offset(
                                              0, 2), // Position of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        Image.asset(
                                          "assets/images/main/duereg.png",
                                          width:
                                              100, // Adjust the width as needed
                                          height:
                                              100, // Adjust the height as needed
                                          fit: BoxFit
                                              .cover, // Optional: Adjusts how the image is fitted
                                        ),
                                        Spacer(),
                                        Text(
                                          "Due Register".tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Fontmain',
                                            // fontWeight: FontWeight.w700
                                          ), // Slightly reduced font size
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               subscription_plan()),
                                //     );
                                //   },
                                //   child: Container(
                                //     width: 100, // Set your desired width
                                //     height: 100, // Set your desired height
                                //     padding: EdgeInsets.all(
                                //         12), // Adds padding around the contents
                                //     decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(8),
                                //       boxShadow: [
                                //         BoxShadow(
                                //           color: Colors.grey
                                //               .withOpacity(0.3), // Shadow color
                                //           spreadRadius:
                                //               2, // Spread of the shadow
                                //           blurRadius:
                                //               2, // Blur radius of the shadow
                                //           offset: Offset(
                                //               0, 2), // Position of the shadow
                                //         ),
                                //       ],
                                //     ),
                                //     child: Column(
                                //       children: [
                                //         Spacer(),
                                //         Image.asset(
                                //           "assets/images/main/duereg.png",
                                //           width:
                                //               100, // Adjust the width as needed
                                //           height:
                                //               100, // Adjust the height as needed
                                //           fit: BoxFit
                                //               .cover, // Optional: Adjusts how the image is fitted
                                //         ),
                                //         Spacer(),
                                //         Text(
                                //           "Social Accounts".tr,
                                //           textAlign: TextAlign.center,
                                //           style: TextStyle(
                                //             fontSize: 15,
                                //             fontFamily: 'Fontmain',
                                //             // fontWeight: FontWeight.w700
                                //           ), // Slightly reduced font size
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]))),
        if (loading || service_data_loder)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: SpinKitCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
      ]),
    );
  }
}
