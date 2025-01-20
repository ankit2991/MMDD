// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:mddmerchant/main.dart';

class QualityAss extends StatefulWidget {
  Function ref;
  QualityAss({required this.ref});
  @override
  State<QualityAss> createState() => _QualityAssState();
}

class _QualityAssState extends State<QualityAss> {
  bool loader = false;
  // String? selectedOption;
  List op_ans = [];
  List<String> Text_answer = [];
  List<int> op_ans_index = [];
  List check_box_ans_bool = <List<bool?>>[];
  List check_box_ans = <List<String>>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (Api.H_Questions.isEmpty) {}
    // loader = true;
    // Api.Service_Question_List().then(
    //   (value) {
    //     setState(() {
    //       loader = false;
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (Api.H_Questions["Table1"].isEmpty) {
      Api.Mpin_check(
              mob_no: Api.prefs.getString("mobile_no") ?? "",
              Mpin: Api.prefs.getString("mpin") ?? "")
          .then(
        (value) {
          loader = false;
          Navigator.pop(context);
          widget.ref(false);
        },
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Questions'.tr,
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
                      child: Text(
                        "No Data Available".tr,
                        style: TextStyle(fontFamily: 'Fontmain'),
                      ),
                    )
                  : ListView.builder(
                      itemCount: Api.H_Questions["Table1"].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        op_ans.add(null);
                        op_ans_index.add(-1);
                        check_box_ans_bool.add([false]);
                        check_box_ans.add([""]);
                        Text_answer.add("");

                        return Container(
                            margin:
                                EdgeInsets.only(top: 10, right: 0, left: 0),
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
                                    style: Api.prefs.getInt("is_Hindi") == 0
                                        ? TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Fontmain')
                                        : TextStyle(
                                            fontFamily: "hindi-font",
                                            fontSize: 20)),
                                if (Api.H_Questions["Table1"][index]
                                        ["QuestionType"] ==
                                    "Signal Optional")
                                  Container(
                                    padding: EdgeInsets.only(bottom: 20),
                                    // color: Colors.blue,
                                    child: GridView.builder(
                                      padding: EdgeInsets.all(0),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              // childAspectRatio: 3,
                                              crossAxisSpacing: 0,
                                              mainAxisSpacing: 0,
                                              mainAxisExtent: 75),

                                      // itemExtent: 30,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: Api
                                          .H_Questions["Table1"][index].length,
                                      itemBuilder: (context, index1) {
                                        if (Api.H_Questions["Table1"][index]
                                                ["Option" + "${index1 + 1}"] !=
                                            null) {
                                          return Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Radio(                                                  
                                                      value: utf8.decode(Api
                                                          .H_Questions["Table1"]
                                                              [index]["Option" +
                                                                  "${index1 + 1}"]
                                                          .runes
                                                          .toList()),
                                                      groupValue: op_ans[index],
                                                      onChanged: (value) {
                                                        print(index1);
                                                        setState(() {
                                                          op_ans.removeAt(index);
                                                          op_ans_index
                                                              .removeAt(index);
                                                          op_ans.insert(
                                                              index, value);
                                                          op_ans_index.insert(
                                                              index, index1);
                                                          // selectedOption =
                                                          //     value; // Update the selected value
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 110,
                                                  child: Text(
                                                      utf8.decode(Api
                                                          .H_Questions["Table1"]
                                                              [index]["Option" +
                                                                  "${index1 + 1}"]
                                                          .runes
                                                          .toList()),
                                                      textAlign: TextAlign.left,
                                                      style: Api.prefs.getInt(
                                                                  "is_Hindi") ==
                                                              0
                                                          ? TextStyle(
                                                              fontSize: 11,
                                                              fontFamily:
                                                                  'Fontmain')
                                                          : TextStyle(
                                                              fontFamily:
                                                                  "hindi-font",
                                                              fontSize: 15)),
                                                ),
                                              ],
                                            ),
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
                                    onChanged: (value) {
                                      Text_answer.removeAt(index);
                                      Text_answer.insert(index, value);
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Answer",
                                        hintText: "Answer",
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: const Color.fromARGB(
                                                  255, 21, 0, 139),
                                            )),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: const Color.fromARGB(
                                                  255, 21, 0, 139),
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                            ))),
                                  ),
                                if (Api.H_Questions["Table1"][index]
                                        ["QuestionType"] ==
                                    "Multipal Optional")
                                  GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 5,
                                    ),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 7,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index2) {
                                      // check_box_ans[index].removeAt(index2);
                                      check_box_ans_bool[index].add(false);
                                      check_box_ans[index].add("");
                                      if (Api.H_Questions["Table1"][index]
                                              ["Option" + "${index2 + 1}"] !=
                                          null) {
                                        return CheckboxListTile(
                                          title: Text(
                                              utf8.decode(
                                                  (Api.H_Questions["Table1"]
                                                              [index]
                                                          ["Option" +
                                                              "${index2 + 1}"])
                                                      .runes
                                                      .toList()),
                                              style: Api.prefs
                                                          .getInt("is_Hindi") ==
                                                      0
                                                  ? TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'Fontmain')
                                                  : TextStyle(
                                                      fontFamily: "hindi-font",
                                                      fontSize: 10)),
                                          value: check_box_ans_bool[index]
                                              [index2],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              check_box_ans_bool[index]
                                                  .removeAt(index2);
                                              check_box_ans[index]
                                                  .removeAt(index2);
                                              check_box_ans_bool[index]
                                                  .insert(index2, value);

                                              check_box_ans[index].insert(
                                                  index2,
                                                  utf8.decode((Api.H_Questions[
                                                              "Table1"][index][
                                                          "Option" +
                                                              "${index2 + 1}"])
                                                      .runes
                                                      .toList()));
                                              // selectedOption =
                                              //     value; // Update the selected value
                                            });
                                          },
                                        );
                                      }
                                    },
                                  ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          loader = true;
                                        });
                                        print(op_ans_index[index]);
                                        print(op_ans[index]);
                                        print(check_box_ans_bool[index]);
                                        print(check_box_ans[index]);
                                        print(Text_answer[index]);
                                        if (Api.H_Questions["Table1"][index]
                                                ["QuestionType"] ==
                                            "Signal Optional") {
                                          if (op_ans[index] != null) {
                                            if (op_ans_index[index] == 0) {
                                              await Api.MerchantAnswareInsert(
                                                      Question: utf8.decode(Api
                                                          .H_Questions["Table1"]
                                                              [index]
                                                              ["Question"]
                                                          .runes
                                                          .toList()),
                                                      Q_id: Api.H_Questions[
                                                              "Table1"][index]
                                                          ["Id"],
                                                      Answer1: op_ans[index])
                                                  .then(
                                                (value) {
                                                  setState(() {
                                                    loader = false;
                                                  });
                                                },
                                              );
                                            }
                                            if (op_ans_index[index] == 1) {
                                              await Api.MerchantAnswareInsert(
                                                      Question: utf8.decode(Api
                                                          .H_Questions["Table1"]
                                                              [index]
                                                              ["Question"]
                                                          .runes
                                                          .toList()),
                                                      Q_id: Api.H_Questions[
                                                              "Table1"][index]
                                                          ["Id"],
                                                      Answer2: op_ans[index])
                                                  .then(
                                                (value) {
                                                  for(int i=0;i<op_ans.length;i++){
                                                    if(op_ans[i]!=null){
                                                      op_ans[i]=null;
                                                    }
                                                  }
                                                  setState(() {
                                                    loader = false;
                                                  });
                                                },
                                              );
                                            }
                                            if (op_ans_index[index] == 2) {
                                              await Api.MerchantAnswareInsert(
                                                      Question: utf8.decode(Api
                                                          .H_Questions["Table1"]
                                                              [index]
                                                              ["Question"]
                                                          .runes
                                                          .toList()),
                                                      Q_id: Api.H_Questions[
                                                              "Table1"][index]
                                                          ["Id"],
                                                      Answer3: op_ans[index])
                                                  .then(
                                                (value) {
                                                  for(int i=0;i<op_ans.length;i++){
                                                    if(op_ans[i]!=null){
                                                      op_ans[i]=null;
                                                    }
                                                  }
                                                  setState(() {
                                                    loader = false;
                                                  });
                                                },
                                              );
                                            }
                                            if (op_ans_index[index] == 3) {
                                              await Api.MerchantAnswareInsert(
                                                      Question: utf8.decode(Api
                                                          .H_Questions["Table1"]
                                                              [index]
                                                              ["Question"]
                                                          .runes
                                                          .toList()),
                                                      Q_id: Api.H_Questions[
                                                              "Table1"][index]
                                                          ["Id"],
                                                      Answer4: op_ans[index])
                                                  .then(
                                                (value) {
                                                  for(int i=0;i<op_ans.length;i++){
                                                    if(op_ans[i]!=null){
                                                      op_ans[i]=null;
                                                    }
                                                  }
                                                  setState(() {
                                                    loader = false;
                                                  });
                                                },
                                              );
                                            }
                                            if (op_ans_index[index] == 4) {
                                              await Api.MerchantAnswareInsert(
                                                      Question: utf8.decode(Api
                                                          .H_Questions["Table1"]
                                                              [index]
                                                              ["Question"]
                                                          .runes
                                                          .toList()),
                                                      Q_id: Api.H_Questions[
                                                              "Table1"][index]
                                                          ["Id"],
                                                      Answer5: op_ans[index])
                                                  .then(
                                                (value) {
                                                  for(int i=0;i<op_ans.length;i++){
                                                    if(op_ans[i]!=null){
                                                      op_ans[i]=null;
                                                    }
                                                  }
                                                  setState(() {
                                                    loader = false;
                                                  });
                                                },
                                              );
                                            }
                                            if (op_ans_index[index] == 5) {
                                              await Api.MerchantAnswareInsert(
                                                      Question: utf8.decode(Api
                                                          .H_Questions["Table1"]
                                                              [index]
                                                              ["Question"]
                                                          .runes
                                                          .toList()),
                                                      Q_id: Api.H_Questions[
                                                              "Table1"][index]
                                                          ["Id"],
                                                      Answer6: op_ans[index])
                                                  .then(
                                                (value) {
                                                  for(int i=0;i<op_ans.length;i++){
                                                    if(op_ans[i]!=null){
                                                      op_ans[i]=null;
                                                    }
                                                  }
                                                  setState(() {
                                                    loader = false;
                                                  });
                                                },
                                              );
                                            }
                                            if (op_ans_index[index] == 6) {
                                              await Api.MerchantAnswareInsert(
                                                      Question: utf8.decode(Api
                                                          .H_Questions["Table1"]
                                                              [index]
                                                              ["Question"]
                                                          .runes
                                                          .toList()),
                                                      Q_id: Api.H_Questions[
                                                              "Table1"][index]
                                                          ["Id"],
                                                      Answer7: op_ans[index])
                                                  .then(
                                                (value) {
                                                  for(int i=0;i<op_ans.length;i++){
                                                    if(op_ans[i]!=null){
                                                      op_ans[i]=null;
                                                    }
                                                  }
                                                  setState(() {
                                                    loader = false;
                                                  });
                                                },
                                              );
                                            }
                                          } else {
                                            setState(() {
                                              loader = false;
                                              Api.snack_bar(
                                                  context: context,
                                                  message:
                                                      "Select one Option".tr);
                                            });
                                          }
                                          print(op_ans);
                                        } else if (Api.H_Questions["Table1"]
                                                [index]["QuestionType"] ==
                                            "Multipal Optional") {
                                          if (check_box_ans[index]
                                                      [0]
                                                  .isNotEmpty ||
                                              check_box_ans[index]
                                                      [2]
                                                  .isNotEmpty ||
                                              check_box_ans[index]
                                                      [3]
                                                  .isNotEmpty ||
                                              check_box_ans[index]
                                                      [4]
                                                  .isNotEmpty ||
                                              check_box_ans[index][5]
                                                  .isNotEmpty ||
                                              check_box_ans[index][6]
                                                  .isNotEmpty) {
                                            Api.MerchantAnswareInsert(
                                                    Question: utf8.decode(Api
                                                        .H_Questions["Table1"]
                                                            [index]["Question"]
                                                        .runes
                                                        .toList()),
                                                    Q_id:
                                                        Api.H_Questions["Table1"]
                                                            [index]["Id"],
                                                    Answer1:
                                                        check_box_ans[index][0],
                                                    Answer2:
                                                        check_box_ans[index][1],
                                                    Answer3:
                                                        check_box_ans[index][2],
                                                    Answer4:
                                                        check_box_ans[index][3],
                                                    Answer5:
                                                        check_box_ans[index][4],
                                                    Answer6: check_box_ans[index][5],
                                                    Answer7: check_box_ans[index][6])
                                                .then(
                                              (value) {
                                                setState(() {
                                                  loader = false;
                                                });
                                              },
                                            );
                                          } else {
                                            setState(() {
                                              loader = false;
                                            });
                                            Api.snack_bar(
                                                context: context,
                                                message: "select option".tr);
                                          }
                                        } else if (Api.H_Questions["Table1"]
                                                [index]["QuestionType"] ==
                                            "Input Type") {
                                          if (Text_answer[index].isNotEmpty) {
                                            Api.MerchantAnswareInsert(
                                                    Question: utf8.decode(Api
                                                        .H_Questions["Table1"]
                                                            [index]["Question"]
                                                        .runes
                                                        .toList()),
                                                    Q_id: Api.H_Questions[
                                                        "Table1"][index]["Id"],
                                                    Answer1: Text_answer[index])
                                                .then(
                                              (value) {
                                                setState(() {
                                                  loader = false;
                                                });
                                              },
                                            );
                                          } else {
                                            Api.snack_bar(
                                                context: context,
                                                message: "field Empty".tr);
                                            setState(() {
                                              loader = false;
                                            });
                                          }
                                        }
                                      },
                                      child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width)-20 ,
                                                // 2 *
                                                // 1.7,
                                        color: Color(0xffC4A68B),
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          'Submit'.tr,
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
