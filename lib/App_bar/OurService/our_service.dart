import 'package:flutter/material.dart';
// import 'package:mddmerchant/constrans.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OurService(),
    );
  }
}

class OurService extends StatelessWidget {
  final Color mainColor = Colors.brown; // Example main color, adjust as needed.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My AddOn",
          style: TextStyle(color: Colors.white, fontFamily: 'Fontmain',),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffC4A68B),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                ProfileOption(title: "Business Category", page: BusiNessCare()),
                ProfileOption(title: "SMS Package", page: SmsPckage()),
                ProfileOption(
                    title: "Advertisement Template", page: AdverTiseMent()),
                ProfileOption(title: "Catalogue Service", page: CataLoGue()),
                ProfileOption(
                    title: "Terms And Conditions", page: TermsCondi()),
                ProfileOption(title: "Accounting Service", page: AccoSerVice()),
                ProfileOption(title: "GST Registration", page: GstRegis()),
                ProfileOption(title: "FSSAI Registration", page: FssaIregi()),
                ProfileOption(title: "Nagar Nigam Registration", page: NagarNigamReg()),
                ProfileOption(title: "Shop Registration", page: ShopRegi()),
                ProfileOption(title: "CA Consulting", page: CaConsult()),
                ProfileOption(title: "Website Service", page: WebsiteService()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String title;
  final Widget page;

  const ProfileOption({
    required this.title,
    required this.page,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(fontFamily: 'Fontmain',)),
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            // ),
            builder: (BuildContext context) {
              return Container(
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: page,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BusiNessCare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Busines Category',
          style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
        ),
        backgroundColor: Color(0xffC4A68B),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(child: Text('Busines Category')),
    );
  }
}

class SmsPckage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Busines Category',
          style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
        ),
        backgroundColor: Color(0xffC4A68B),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(child: Text('Busines Category')),
    );
  }
}

class AdverTiseMent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with BoxShadow
          Container(
            decoration: BoxDecoration(
              color: Color(0xffC4A68B),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Offset for shadow
                ),
              ],
            ),
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Removes the default shadow
                title: Text(
                  'Service Enquiry',
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          // Body content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "Advertise Template",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Service Name",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontSize: 14,
                          fontFamily: 'sub-tittle',
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe5777474)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xe5777474)),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                        color: Colors.grey, // Set the initialValue color to gray
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
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
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey), // Default border
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC4A68B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SEND ENQUIRY',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Fontmain',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CataLoGue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with BoxShadow
          Container(
            decoration: BoxDecoration(
              color: Color(0xffC4A68B),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Offset for shadow
                ),
              ],
            ),
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Removes the default shadow
                title: Text(
                  'Service Enquiry',
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          // Body content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "Catalogue Services",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Service Name",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontSize: 14,
                          fontFamily: 'sub-tittle',
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe5777474)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xe5777474)),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                        color: Colors.grey, // Set the initialValue color to gray
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
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
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey), // Default border
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC4A68B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SEND ENQUIRY',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Fontmain',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TermsCondi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with BoxShadow
          Container(
            decoration: BoxDecoration(
              color: Color(0xffC4A68B),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Offset for shadow
                ),
              ],
            ),
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Removes the default shadow
                title: Text(
                  'Service Enquiry',
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          // Body content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "Terms & Conditions",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Service Name",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontSize: 14,
                          fontFamily: 'sub-tittle',
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe5777474)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xe5777474)),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                        color: Colors.grey, // Set the initialValue color to gray
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
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
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey), // Default border
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC4A68B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SEND ENQUIRY',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Fontmain',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccoSerVice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with BoxShadow
          Container(
            decoration: BoxDecoration(
              color: Color(0xffC4A68B),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Offset for shadow
                ),
              ],
            ),
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Removes the default shadow
                title: Text(
                  'Service Enquiry',
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          // Body content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "Accounting Services",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Service Name",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontSize: 14,
                          fontFamily: 'sub-tittle',
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe5777474)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xe5777474)),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                        color: Colors.grey, // Set the initialValue color to gray
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
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
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey), // Default border
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC4A68B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SEND ENQUIRY',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Fontmain',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GstRegis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with BoxShadow
          Container(
            decoration: BoxDecoration(
              color: Color(0xffC4A68B),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Offset for shadow
                ),
              ],
            ),
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Removes the default shadow
                title: Text(
                  'Service Enquiry',
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          // Body content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "GST Registration",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Service Name",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontSize: 14,
                          fontFamily: 'sub-tittle',
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe5777474)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xe5777474)),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                        color: Colors.grey, // Set the initialValue color to gray
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
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
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey), // Default border
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC4A68B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SEND ENQUIRY',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Fontmain',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FssaIregi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with BoxShadow
          Container(
            decoration: BoxDecoration(
              color: Color(0xffC4A68B),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Offset for shadow
                ),
              ],
            ),
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Removes the default shadow
                title: Text(
                  'Service Enquiry',
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          // Body content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "FSSAI Registration",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Service Name",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontSize: 14,
                          fontFamily: 'sub-tittle',
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe5777474)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xe5777474)),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                        color: Colors.grey, // Set the initialValue color to gray
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
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
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey), // Default border
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC4A68B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SEND ENQUIRY',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Fontmain',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NagarNigamReg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with BoxShadow
          Container(
            decoration: BoxDecoration(
              color: Color(0xffC4A68B),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Offset for shadow
                ),
              ],
            ),
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Removes the default shadow
                title: Text(
                  'Service Enquiry',
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          // Body content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "Nagar Nigam Registration",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Service Name",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontSize: 14,
                          fontFamily: 'sub-tittle',
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe5777474)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xe5777474)),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                        color: Colors.grey, // Set the initialValue color to gray
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
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
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey), // Default border
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC4A68B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SEND ENQUIRY',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Fontmain',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShopRegi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with BoxShadow
          Container(
            decoration: BoxDecoration(
              color: Color(0xffC4A68B),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Offset for shadow
                ),
              ],
            ),
            child: SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Removes the default shadow
                title: Text(
                  'Service Enquiry',
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          // Body content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "Shop Registration",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Service Name",
                        labelStyle: TextStyle(
                          color: Color(0xe5777474),
                          fontSize: 14,
                          fontFamily: 'sub-tittle',
                        ),
                        floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe5777474)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xe5777474)),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                        color: Colors.grey, // Set the initialValue color to gray
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          borderSide:
                          BorderSide(color: Color(0xffC4A68B), width: 2),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'sub-tittle',
                        fontSize: 16.0,
                      ),
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
                        floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey), // Default border
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC4A68B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {},
                      child: Text(
                        'SEND ENQUIRY',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Fontmain',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CaConsult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensures the page adjusts when the keyboard opens
      appBar: AppBar(
        backgroundColor: Color(0xffC4A68B),
        elevation: 2,
        title: Text(
          'Service Enquiry',
          style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                initialValue: "CA Consulting",
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Service Name",
                  labelStyle: TextStyle(
                    color: Color(0xe5777474),
                    fontSize: 14,
                    fontFamily: 'sub-tittle',
                  ),
                  floatingLabelStyle: TextStyle(color: Color(0xe5777474)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xe5777474)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xe5777474)),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'sub-tittle',
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 15),
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
                    borderSide: BorderSide(
                        color: Color(0xffC4A68B), width: 2),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'sub-tittle',
                  fontSize: 16.0,
                ),
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
                  floatingLabelStyle: TextStyle(color: Color(0xffC4A68B)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xffC4A68B),
                        width: 2),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'sub-tittle',
                  fontSize: 16.0,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffC4A68B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: Text(
                  'SEND ENQUIRY',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Fontmain',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebsiteService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensures the page adjusts when the keyboard opens
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar with BoxShadow
            Container(
              decoration: BoxDecoration(
                color: Color(0xffC4A68B),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Offset for shadow
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0, // Removes the default shadow
                title: Text(
                  'Service Enquiry',
                  style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            // Body content
            Expanded(
              child: SingleChildScrollView(
               child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: "Website Services",
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Service Name",
                          labelStyle: TextStyle(
                            color: Color(0xe5777474),
                            fontSize: 14,
                            fontFamily: 'sub-tittle',
                          ),
                          floatingLabelStyle:
                          TextStyle(color: Color(0xe5777474)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xe5777474)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xe5777474)),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'sub-tittle',
                          fontSize: 16.0,
                          color: Colors.grey, // Set the initialValue color to gray
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
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
                            borderSide: BorderSide(
                                color: Color(0xffC4A68B), width: 2),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'sub-tittle',
                          fontSize: 16.0,
                        ),
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
                          floatingLabelStyle:
                          TextStyle(color: Color(0xffC4A68B)),
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey), // Default border
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffC4A68B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: () {},
                        child: Text(
                          'SEND ENQUIRY',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Fontmain',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

