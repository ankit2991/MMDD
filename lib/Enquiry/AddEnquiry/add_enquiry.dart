import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEnquiry extends StatefulWidget {
  @override
  _AddEnquiryState createState() => _AddEnquiryState();
}

class _AddEnquiryState extends State<AddEnquiry> {
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

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
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Event Category",
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Set Event Location On Map",
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
              TextFormField(
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
