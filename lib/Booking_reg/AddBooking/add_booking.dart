import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mddmerchant/api/api.dart';

class AddBooking extends StatefulWidget {
  @override
  String Isbooking;
  Function refresh;
  bool update;
  Map data;
  AddBooking(
      {required String this.Isbooking,
      required this.refresh,
      required this.update,
      required this.data});
  _AddBookingState createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? selectedItem;
  String? lett;
  String? lott;
  List<String> event_cate = [
    "WEDDING",
    "BIRTHDAY",
    "RETIREMENT",
    "ANNIVERSARY",
    "OTHER"
  ];
  var name_con = TextEditingController();
  var mob_con = TextEditingController();
  var Omob_con = TextEditingController();
  var event_address_con = TextEditingController();
  var remark_con = TextEditingController();
  var eventLocation_con = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void loding(bool a) {
    setState(() {
      loader = a;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.update) {
      name_con.text = widget.data["CustomerName"];
      mob_con.text = widget.data["MobileNo"];
      _startDate = DateTime.parse(widget.data["EventStartDate"]);
      _endDate = DateTime.parse(widget.data["EventEndDate"]);
      List<String> Start_time = widget.data["EventStartTime"].split(":");
      _startTime = TimeOfDay(
        hour: int.parse(Start_time[0]),
        minute: int.parse(Start_time[1]),
      );
      List<String> End_time = widget.data["EventEndTime"].split(":");
      _endTime = TimeOfDay(
        hour: int.parse(End_time[0]),
        minute: int.parse(End_time[1]),
      );
      selectedItem = widget.data["EventName"];

// Omob_con.text=widget.data["CustomerName"];
// event_address_con.text=widget.data["CustomerName"];
      remark_con.text = widget.data["Remarks"];
      eventLocation_con.text = widget.data["CustomerName"];
    }
  }

  bool loader = false;
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? pickedDate;
    if (isStart) {
      pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
    } else {
      pickedDate = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: _startDate ?? DateTime.now(),
        lastDate: DateTime(2100),
      );
    }

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
    final TimeOfDay? pickedTime;
    if (isStart) {
      pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    } else {
      pickedTime = await showTimePicker(
        context: context,
        initialTime: _startTime ?? TimeOfDay.now(),
      );
    }
    if (pickedTime != null) {
      if (isStart) {
        setState(() {
          _startTime = pickedTime;
        });
      } else {
        if (_startDate == _endDate) {
          if (pickedTime!.hour > _startTime!.hour ||
              (pickedTime!.hour == _startTime!.hour &&
                  pickedTime!.minute >= _startTime!.minute)) {
            setState(() {
              _endTime = pickedTime;
            });
          } else {
            // Show a message if an older time is picked
            Api.snack_bar(
                context: context, message: "Please select a valid future time");
          }
        } else {
          setState(() {
            _endTime = pickedTime;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Booking'.tr,
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Other fields omitted for brevity...
                    IgnorePointer(
                      ignoring: widget.update,
                      child: TextFormField(
                        controller: name_con,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          labelText: "Name",
                          labelStyle: TextStyle(
                            color: Color(0xe5777474),
                            fontFamily: 'sub-tittle',
                            fontSize: 14,
                          ),
                          floatingLabelStyle:
                              TextStyle(color: Color(0xffC4A68B)),
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
                            color: widget.update
                                ? Color(0xe5777474)
                                : Colors.black),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\s]'))
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    IgnorePointer(
                      ignoring: widget.update,
                      child: TextFormField(
                        controller: mob_con,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Mobile Number";
                          }
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          labelText: "Mobile Number",
                          labelStyle: TextStyle(
                            color: Color(0xe5777474),
                            fontFamily: 'sub-tittle',
                            fontSize: 14,
                          ),
                          // Default label color
                          floatingLabelStyle:
                              TextStyle(color: Color(0xffC4A68B)),
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
                            color: widget.update
                                ? Color(0xe5777474)
                                : Colors.black),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly // Only numbers
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: Omob_con,
                      //   validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //   return "Please enter your name";
                      // }
                      // },
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
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
                    const SizedBox(height: 15),
                    IgnorePointer(
                      ignoring: widget.update,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Event Category',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedItem,
                        items: event_cate.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: widget.update
                                      ? Color(0xe5777474)
                                      : Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedItem = value;
                          });
                        },
                        validator: (value) => value == null
                            ? 'Please select Event Category'
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onTap: () {
                        _selectDate(context, true);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select Event Start Date";
                        }
                      },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context, true);
                          },
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
                          borderSide:
                              BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
                      controller: TextEditingController(
                        text: _startDate != null
                            ? "${_startDate!.toLocal()}".split(' ')[0]
                            : '',
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        if (_startDate == null) {
                          Api.snack_bar(
                              context: context,
                              message:
                                  "Please select Event Start Date then Select End date");
                        }
                      },
                      child: IgnorePointer(
                        ignoring: _startDate != null ? false : true,
                        child: TextFormField(
                          onTap: () {
                            _selectDate(context, false);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select Event End Date";
                            }
                          },
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _selectDate(context, false);
                              },
                            ),
                            labelText: "Event End Date",
                            labelStyle: TextStyle(
                              color: Color(0xe5777474),
                              fontFamily: 'sub-tittle',
                              fontSize: 14,
                            ),
                            floatingLabelStyle:
                                TextStyle(color: Color(0xffC4A68B)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffC4A68B), width: 2),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'sub-tittle',
                            fontSize: 16.0,
                          ),
                          controller: TextEditingController(
                            text: _endDate != null
                                ? "${_endDate!.toLocal()}".split(' ')[0]
                                : '',
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onTap: () => _selectTime(context, true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select Event Start Time";
                        }
                      },
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.timer),
                          onPressed: () {
                            _selectTime(context, true);
                          },
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
                          borderSide:
                              BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
                      controller: TextEditingController(
                        text: _startTime != null
                            ? _startTime!.format(context)
                            : '',
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        if (_startDate == null && _endDate == null) {
                          Api.snack_bar(
                              context: context,
                              message: "please select Start Date & End Date");
                        } else if (_startTime == null) {
                          Api.snack_bar(
                              context: context,
                              message: "please select Start Time");
                        }
                      },
                      child: IgnorePointer(
                        ignoring: _startDate != null && _endDate != null ||
                                _startTime != null
                            ? false
                            : true,
                        child: TextFormField(
                          onTap: () => _selectTime(context, false),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select Event End Time";
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.timer),
                              onPressed: () {
                                _selectTime(context, false);
                              },
                            ),
                            labelText: "Event End Time",
                            labelStyle: TextStyle(
                              color: Color(0xe5777474),
                              fontFamily: 'sub-tittle',
                              fontSize: 14,
                            ),
                            floatingLabelStyle:
                                TextStyle(color: Color(0xffC4A68B)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffC4A68B), width: 2),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'sub-tittle',
                            fontSize: 16.0,
                          ),
                          controller: TextEditingController(
                            text: _endTime != null
                                ? _endTime!.format(context)
                                : '',
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Event Address";
                        }
                      },
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
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          loader = true;
                        });
                        print("object");
                        try {
                          Api.get_loc(context, loding).then(
                            (value) {
                              print("----------------------");
                              log("${value.latitude}");
                              print("----------------------");
                              log("${value.longitude}");
                              print("----------------------");
                              lett = value.latitude.toString();
                              lott = value.longitude.toString();
                              String address =
                                  "${value.latitude},${value.longitude}";
                              eventLocation_con.text = address;
                              setState(() {
                                loader = false;
                              });
                            },
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: IgnorePointer(
                        ignoring: true,
                        child: TextFormField(
                          controller: eventLocation_con,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Tap this field and get location";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Set Your Bussiness Location",
                            labelStyle: TextStyle(
                              color: Color(0xe5777474),
                              fontFamily: 'sub-tittle',
                              fontSize: 14,
                            ),
                            floatingLabelStyle:
                                TextStyle(color: Color(0xffC4A68B)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffC4A68B)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffC4A68B), width: 2),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'sub-tittle',
                            fontSize: 16.0,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z\s]'))
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(widget.update)
                        GestureDetector(
                          onTap: (){
                               if (_formKey.currentState!.validate()) {
                              if (widget.update) {
                                Api.EventBooking(
                                  IsBooking: "0",
                                  BookingAmount: "",
                                  DueAmount: "",
                                  EventEndDate:
                                      "${_endDate!.toLocal()}".split(' ')[0],
                                  EventStartDate:
                                      "${_startDate!.toLocal()}".split(' ')[0],
                                  EventId: widget.data["id"].toInt().toString(),
                                  EventEndTime:
                                      "${_endTime!.hour}:${_endTime!.minute}",
                                  EventStartTime:
                                      "${_startTime!.hour}:${_startTime!.minute}",
                                  TotalAmount: "",
                                  Remarks: remark_con.text,
                                ).then(
                                (value) {
                                  if (value) {
                                    widget.refresh();
                                    Navigator.of(context).pop();
                                  } else {
                                    name_con.clear();
                                    mob_con.clear();
                                    Omob_con.clear();
                                    event_address_con.clear();
                                    remark_con.clear();
                                    eventLocation_con.clear();
                                  }
                                },
                              );
                            }
                          }},
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                            alignment: Alignment.center,
                            width: (MediaQuery.of(context).size.width/2)-20,
                            decoration: BoxDecoration(color: Color(0xffC4A68B),),
                          
                          
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Fontmain'),
                            ),
                          ),
                        ),
                    
                        GestureDetector(
                          onTap: (){
                                if (_formKey.currentState!.validate()) {
                              if (widget.update) {
                                Api.EventBooking(
                                  IsBooking: "1",
                                  BookingAmount: "",
                                  DueAmount: "",
                                  EventEndDate:
                                      "${_endDate!.toLocal()}".split(' ')[0],
                                  EventStartDate:
                                      "${_startDate!.toLocal()}".split(' ')[0],
                                  EventId: widget.data["id"].toInt().toString(),
                                  EventEndTime:
                                      "${_endTime!.hour}:${_endTime!.minute}",
                                  EventStartTime:
                                      "${_startTime!.hour}:${_startTime!.minute}",
                                  TotalAmount: "",
                                  Remarks: remark_con.text,
                                ).then(
                                (value) {
                                  if (value) {
                                    widget.refresh();
                                    Navigator.of(context).pop();
                                  } else {
                                    name_con.clear();
                                    mob_con.clear();
                                    Omob_con.clear();
                                    event_address_con.clear();
                                    remark_con.clear();
                                    eventLocation_con.clear();
                                  }
                                },
                              );
                              }else{
                              Api.CustomerRegistration(
                                      Isbooking: widget.Isbooking,
                                      BookingAmount: "",
                                      CName: name_con.text,
                                      DueAmount: "",
                                      Email: "",
                                      EventAddress: event_address_con.text,
                                      EventEndDate:
                                          "${_endDate!.toLocal()}".split(' ')[0],
                                      EventStartDate:
                                          "${_startDate!.toLocal()}".split(' ')[0],
                                      EventStartTime:
                                          "${_startTime!.hour}:${_startTime!.minute}",
                                      EventEndTime:
                                          "${_endTime!.hour}:${_endTime!.minute}",
                                      EventName: selectedItem ?? "",
                                      Latitude: lett ?? "",
                                      Longitude: lott ?? "",
                                      Mobile: mob_con.text,
                                      Remarks: remark_con.text,
                                      TotalAmount: "",
                                      context: context)
                                  .then(
                                (value) {
                                  if (value) {
                                    widget.refresh();
                                    Navigator.of(context).pop();
                                  } else {
                                    name_con.clear();
                                    mob_con.clear();
                                    Omob_con.clear();
                                    event_address_con.clear();
                                    remark_con.clear();
                                    eventLocation_con.clear();
                                  }
                                },
                              );
                            }}
                         
                          },
                          child: Container(
                             padding: EdgeInsets.symmetric(vertical: 10,horizontal: 4),
                            alignment: Alignment.center,
                            width: (MediaQuery.of(context).size.width/2)-20,
                            decoration: BoxDecoration(color: Color(0xffC4A68B),),
                          
                            child: Text(
                              'CONFIRM BOOKING',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Fontmain'),
                            ),
                          ),
                        ),
                    
                      ],
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
