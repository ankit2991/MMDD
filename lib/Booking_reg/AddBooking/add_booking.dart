import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mddmerchant/api/api.dart';

class AddBooking extends StatefulWidget {
  @override
  String Isbooking;
  Function refresh;
  AddBooking({required String this.Isbooking,required this.refresh});
  _AddBookingState createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String?selectedItem;
  String? lett;
  String? lott;
  List<String> event_cate=["WEDDING","BIRTHDAY","RETIREMENT","ANNIVERSARY","OTHER"];
  var name_con=TextEditingController();
  var mob_con=TextEditingController();
  var Omob_con=TextEditingController();
  var event_address_con=TextEditingController();
  var remark_con=TextEditingController();
  var eventLocation_con=TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStart) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Booking',
          style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
          iconSize: 30.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              // Other fields omitted for brevity...
              TextFormField(
                controller: name_con,
                decoration: InputDecoration(
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
                style: TextStyle(fontFamily: 'sub-tittle', fontSize: 16.0,),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
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
                style: TextStyle(fontFamily: 'sub-tittle', fontSize: 16.0,),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly // Only numbers
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: Omob_con,
                decoration: InputDecoration(
                  labelText: "Optional Mobile Number",
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
                style: TextStyle(fontFamily: 'sub-tittle', fontSize: 16.0,),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly // Only numbers
                ],
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Event Category',
                  border: OutlineInputBorder(),
                ),
                value: selectedItem,
                items: event_cate.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a fruit' : null,
              ),
              // TextFormField(
              
              //   decoration: InputDecoration(
              //     labelText: "Event Category",
              //     labelStyle: TextStyle(
              //       color: Color(0xe5777474),
              //       fontFamily: 'sub-tittle',
              //       fontSize: 14,
              //     ),
              //     floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xffC4A68B)),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
              //     ),
              //   ),
              //   style: TextStyle(fontFamily: 'sub-tittle', fontSize: 16.0,),
              //   inputFormatters: [
              //     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
              //   ],
              // ),
             
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, true),
                  ),
                  labelText: "Event Start Date",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(fontFamily: 'sub-tittle', fontSize: 16.0,),
                controller: TextEditingController(
                  text: _startDate != null
                      ? "${_startDate!.toLocal()}".split(' ')[0]
                      : '',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, false),
                  ),
                  labelText: "Event End Date",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(fontFamily: 'sub-tittle', fontSize: 16.0,),
                controller: TextEditingController(
                  text: _endDate != null
                      ? "${_endDate!.toLocal()}".split(' ')[0]
                      : '',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () => _selectTime(context, true),
                  ),
                  labelText: "Event Start Time",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(fontFamily: 'sub-tittle', fontSize: 16.0,),
                controller: TextEditingController(
                  text: _startTime != null
                      ? _startTime!.format(context)
                      : '',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () => _selectTime(context, false),
                  ),
                  labelText: "Event End Time",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontFamily: 'sub-tittle',
                    fontSize: 14,
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(fontFamily: 'sub-tittle', fontSize: 16.0,),
                controller: TextEditingController(
                  text: _endTime != null
                      ? _endTime!.format(context)
                      : '',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: event_address_con,
                decoration: InputDecoration(
                  labelText: "Event Address",
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
                style: TextStyle(fontFamily: 'sub-tittle', fontSize: 16.0,),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                    onTap: () {
                      print("object");
                      Api.get_loc().then(
                        (value) {
                          print("----------------------");
                          log("${value.latitude}");
                          print("----------------------");
                          log("${value.longitude}");
                          print("----------------------");
                          lett = value.latitude.toString();
                          lott = value.longitude.toString();
                          String address = "${value.latitude},${value.longitude}";
                          eventLocation_con.text = address;
                        },
                      );
                    },
                    child: IgnorePointer(
                      ignoring: true,
                      child: TextFormField(
                        controller: eventLocation_con,
                        decoration: InputDecoration(
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
                controller: remark_con,
                decoration: InputDecoration(
                  labelText: "Remark",
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
                style: TextStyle(fontFamily: 'sub-tittle', fontSize: 16.0,),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffC4A68B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  minimumSize: Size(650, 50),
                ),
                onPressed: () {
                  Api.CustomerRegistration(Isbooking: widget.Isbooking ,BookingAmount: "",CName: name_con.text,DueAmount: "",Email: "",EventAddress: event_address_con.text,EventEndDate:"${_endDate!.toLocal()}".split(' ')[0],EventStartDate: "${_startDate!.toLocal()}".split(' ')[0],EventStartTime: _startTime!.format(context),EventEndTime: _endTime!.format(context),EventName: selectedItem??"",Latitude: lett??"",Longitude: lott??"",Mobile: mob_con.text,Remarks: remark_con.text,TotalAmount: "" ).then((value) {
                    if (value) {
                      widget.refresh();
                      Navigator.of(context).pop();
                    }
                  },);
                  // Handle booking confirmation
                },
                child: Text(
                  'CONFIRM BOOKING',
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
