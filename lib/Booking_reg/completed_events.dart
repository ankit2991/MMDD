// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/main.dart';

class CompletedEvents extends StatefulWidget {
  const CompletedEvents({super.key});

  @override
  State<CompletedEvents> createState() => _CompletedEventsState();
}

class _CompletedEventsState extends State<CompletedEvents> {
  @override
  List<dynamic> _data = [];
  bool loder = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    loder = true;
    _data.clear();
    Api.EventBookingDetailsList( Is_booking: "1", Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent: "CompleteEvent").then(
      (value) {
        _data = value;
        setState(() {
          loder = false;
        });
        // print(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Events'.tr,
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
          loder?Text(""):ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
           itemCount: _data.length,
           shrinkWrap: true,
           itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(5),
             margin: EdgeInsets.symmetric(vertical: 5),
            //  height: 100,          
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(10),
               boxShadow: [BoxShadow(blurRadius: 0.5,color: const Color.fromARGB(134, 0, 0, 0),offset: Offset(1, 1))]
             ),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text(_data[index]["EventStartDate"],style: TextStyle(fontFamily: 'Fontmain'),),
              ],),
              Text(_data[index]["CustomerName"],style: TextStyle(fontFamily: 'Fontmain'),),
              Text(_data[index]["EventName"],style: TextStyle(fontFamily: 'Fontmain'),),
              Text(_data[index]["MobileNo"],style: TextStyle(fontFamily: 'Fontmain'),),
              Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if(_data[index]["TotalAmount"]!=null)
                          Text("Total Amount : ₹ ${_data[index]["TotalAmount"]}",style: TextStyle(fontFamily: 'Fontmain',fontSize: 10),),
                        if(_data[index]["BookingAmount"]!=null)
                          Text("Advance Amount : ₹ ${_data[index]["BookingAmount"]}",style: TextStyle(fontFamily: 'Fontmain',fontSize: 10),),
                        if(_data[index]["DueAmount"]!=null)
                          Text("Due Amount : ₹ ${_data[index]["DueAmount"]}",style: TextStyle(fontFamily: 'Fontmain',fontSize: 10),),
                      ],
                    ),
                  )
              ],)
             ],),
            );
          },),
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
        ],
      ),
    );
  }
}
