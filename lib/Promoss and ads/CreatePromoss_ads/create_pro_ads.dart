import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CreateProAds extends StatefulWidget {
  @override
  _CreateProAdsState createState() => _CreateProAdsState();
}

class _CreateProAdsState extends State<CreateProAds> {
  DateTime? _startDate;
  DateTime? _endDate;

  // TimeOfDay? _startTime;
  // TimeOfDay? _endTime;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Promos & Ads', style: TextStyle(color: Colors.white, fontFamily: 'Fontmain')),
        centerTitle: true,
        backgroundColor: Color(0xffC4A68B),
        elevation: 2.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white, // Change the color of the icon
          iconSize: 30.0, // Adjust the size of the icon
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
            children: [
              Container(
                height: 200,
                width: 600,
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Business Name",
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
              SizedBox(height: 15,),
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
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Address",
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
                        borderRadius: BorderRadius.circular(0)
                    ),
                    minimumSize: Size(650,45),
                  ),
                  onPressed: () {}, child: Text('SELECT BACKGROUND IMAGE', style: TextStyle(
                  color: Colors.white, fontFamily: 'Fontmain'),)),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Discount(%)",
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
                  // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
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
                  floatingLabelStyle: TextStyle(color: Colors.brown),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown, width: 2),
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
                  floatingLabelStyle: TextStyle(color: Colors.brown),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown, width: 2),
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
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffC4A68B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                    ),
                    minimumSize: Size(650,45),
                  ),
                  onPressed: () {}, child: Text('GENERATE AD', style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),)),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffC4A68B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                    ),
                    minimumSize: Size(650,45),
                  ),
                  onPressed: () {}, child: Text('UPLOAD AD', style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),))
            ],
        )
        ),
        ),
      );
  }
}