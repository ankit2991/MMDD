// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:mddmerchant/api/api.dart';

class QualityAss extends StatefulWidget {
  @override
  State<QualityAss> createState() => _QualityAssState();
}

class _QualityAssState extends State<QualityAss> {
  bool loader = false;
  // String? selectedOption;
  List op_ans = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader = true;
    Api.Service_Question_List().then(
      (value) {
        setState(() {
          loader = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Questions',
            style: TextStyle(color: Colors.white, fontFamily: 'Fontmain'),
          ),
          centerTitle: true,
          backgroundColor: Color(0xffC4A68B),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: loader
                  ? Center(
                      child: Text("No Data Available"),
                    )
                  : ListView.builder(
                      itemCount: Api.H_Questions["Table1"].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        op_ans.add(null);

                        return Container(
                            margin:
                                EdgeInsets.only(top: 10, right: 10, left: 10),
                            padding: EdgeInsets.all(10),
                            // height: 600,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: const Color.fromARGB(66, 0, 0, 0),
                                    offset: Offset(0, 0),
                                  )
                                ]),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    utf8.decode(Api
                                        .H_Questions["Table1"][index]
                                            ["Question"]
                                        .runes
                                        .toList()),
                                    style: TextStyle(
                                        fontFamily: "hindi-font",
                                        fontSize: 20)),
                                if (Api.H_Questions["Table1"][index]
                                        ["QuestionType"] ==
                                    "Signal Optional")
                                  Container(
                                    padding: EdgeInsets.only(bottom: 20),
                                    // color: Colors.blue,
                                    child: ListView.builder(
                                      itemExtent: 30,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: Api
                                          .H_Questions["Table1"][index].length,
                                      itemBuilder: (context, index1) {
                                        if (Api.H_Questions["Table1"][index]
                                                ["Option" + "${index1 + 1}"] !=
                                            null) {
                                          return RadioListTile<String>(
                                            title: Text(
                                                utf8.decode(Api
                                                    .H_Questions["Table1"]
                                                        [index]["Option" +
                                                            "${index1 + 1}"]
                                                    .runes
                                                    .toList()),
                                                style: TextStyle(
                                                    fontFamily: "hindi-font",
                                                    fontSize: 10)),
                                            value: utf8.decode(Api
                                                .H_Questions["Table1"][index]
                                                    ["Option" + "${index1 + 1}"]
                                                .runes
                                                .toList()),
                                            // style: GoogleFonts.notoSansDevanagari(fontSize: 20),
                                            groupValue: op_ans[index],
                                            onChanged: (value) {
                                              setState(() {
                                                op_ans.removeAt(index);
                                                op_ans.insert(index, value);
                                                // selectedOption =
                                                //     value; // Update the selected value
                                              });
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                   if (Api.H_Questions["Table1"][index]
                                        ["QuestionType"] ==
                                    "Input Type")
                                    TextFormField(
                                      maxLines: 3,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                        labelText: "Answer",
                                        hintText: "Answer",
                                        
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(color: const Color.fromARGB(255, 21, 0, 139),))
                                        ,disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(color: const Color.fromARGB(255, 21, 0, 139),))
                                        ,enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0),))
                                      ),
                                    ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print(op_ans);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2 *
                                                1.7,
                                        color: Color(0xffC4A68B),
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          'Questions',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Fontmain'),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ));
                      },
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
        )
        //  Center(
        //   child: Text('No Data Available', style: TextStyle(fontFamily: 'Fontmain', color: Color(0xe5777474)),),
        // ),
        );
  }
}
