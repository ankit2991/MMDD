import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mddmerchant/Booking_reg/AddBooking/add_booking.dart';
import 'package:mddmerchant/Enquiry/AddEnquiry/add_enquiry.dart';
import 'package:mddmerchant/api/api.dart';


class MyEnquiry extends StatefulWidget {
  @override
  State<MyEnquiry> createState() => _MyEnquiryState();
}
class _MyEnquiryState extends State<MyEnquiry> {
  @override
  List<dynamic> _data = [];
  bool loder=false;
  void refresh(){
  Api.EventBookingDetailsList(Is_booking: "0",Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:"UpcomingEvent" ).then((value) {
      _data=value;
      print(_data);
       setState(() {
          loder = false;
        });
    },);
  }
  void initState() {
    // TODO: implement initState
    loder=true;
    super.initState();
    Api.EventBookingDetailsList(Is_booking: "0",Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent:"UpcomingEvent" ).then((value) {
      _data=value;
      print(_data);
       setState(() {
          loder = false;
        });
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquiry'.tr, style: TextStyle(color: Colors.white, fontFamily: 'Fontmain')),
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
      body: 
      
      Stack(
        children: [
         _data.isEmpty? Center(
            child: Text('No Data Available', style: TextStyle(fontFamily: 'Fontmain', color: Color(0xe5777474)),),
          ):ListView.builder(
            padding: EdgeInsets.all(10),
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
                        if(_data[index]["TotalAmount"]!=null&& _data[index]["TotalAmount"]!="0")
                          Text("Total Amount : ₹ ${_data[index]["TotalAmount"]}",style: TextStyle(fontFamily: 'Fontmain',fontSize: 10),),
                        if(_data[index]["BookingAmount"]!=null&& _data[index]["TotalAmount"]!="0")
                          Text("Advance Amount : ₹ ${_data[index]["BookingAmount"]}",style: TextStyle(fontFamily: 'Fontmain',fontSize: 10),),
                        if(_data[index]["DueAmount"]!=null&& _data[index]["TotalAmount"]!="0")
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBooking(Isbooking: "0",refresh: refresh,)),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Adjust the value for desired radius
        ),
        backgroundColor: Color(0xffC4A68B),
      ),
    );
  }
}
