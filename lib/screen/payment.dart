import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mddmerchant/api/api.dart';

class payment_screen extends StatefulWidget {
  const payment_screen({super.key});

  @override
  State<payment_screen> createState() => _payment_screenState();
}

class _payment_screenState extends State<payment_screen> {
  List<dynamic> _data = [];
  List<Widget> itms = [];
  var amount_con=TextEditingController();
  var remark_con=TextEditingController();

  bool loader = false;
  @override
  void initState() {
    loader = true;
    // TODO: implement initState
    super.initState();
    Api.SubscriptionList().then(
      (value) {
        _data = value;
        setState(() {
          loader = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    itms.clear();
     for (var i = 0; i < _data.length; i++) {
          itms.add(
            SingleChildScrollView(
              child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    margin: EdgeInsets.only(
                        bottom: (MediaQuery.of(context).size.height) - 600,
                        right: 20,
                        left: 20,
                        top: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(136, 0, 0, 0),
                              blurRadius: 5,
                              offset: Offset(2, 4))
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹ ${_data[i]["SubscriptionCharge"]}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: const Color.fromARGB(255, 13, 2, 95),
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 50,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 245, 24, 72),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                ),
                              ),
                              child: Text(
                                "${_data[i]["SubscriptionName"]}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Table(
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Normal Customer Suport",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "True",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "VIP Line Of Customer Suport",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "True",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Customised Pre Package",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "True",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Sms",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "True",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Ads Templete",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "True",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "App Listong",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "True",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Sales Push Up",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "True",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Social Media Integration",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "True",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Ads in Form Of Reels",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "True",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Software Feature",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Only Enquiry / Booking Add View",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 13, 2, 95),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              scrollControlDisabledMaxHeightRatio:
                                                          300,
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.white,
                              // isScrollControlled: ,
                              builder: (context) {
                                return Padding(
                                  // padding: const EdgeInsets.only(bottom: 0,),
                                  padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom,
                                                              ),
                                  child: Container(
                                    height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height /
                                                                    2,
                                    child: Column(
                                      spacing: 20,
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppBar(
                                          foregroundColor: Colors.white,
                                          backgroundColor:  Color(0xffC4A68B),
                                          title: Text(
                                            "Add Payment",
                                            style: TextStyle(fontFamily: "Fontmain"),
                                          ),
                                        ),
                                       Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 10,
                                          children: [
                                         Container(
                                          child: Column(
                                           
                                            children: [
                                              Text(
                                                _data[i]["SubscriptionName"],
                                                style:
                                                    TextStyle(fontFamily: "Fontmain"),
                                              ),
                                              Text(
                                                _data[i]["SubscriptionCharge"].toString(),
                                                style:
                                                    TextStyle(fontFamily: "Fontmain"),
                                              )
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                          controller: amount_con,
                                          decoration: InputDecoration(
                                              label: Text("Amount"),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black))),
                                        ),
                                        TextFormField(
                                          controller: remark_con,
                                          decoration: InputDecoration(
                                              label: Text("Remark"),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black))),
                                        ),
                                        Container(height: 60,
                                        width: double.maxFinite,
                                        color: Color(0xffC4A68B),
                                        alignment: Alignment.center,
                                        child: Text("Pay Amount",style: TextStyle(fontFamily: "Fontmain",color: Colors.white),),
                                        )
                                                                        
                                       ],),)
                                          ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 245, 24, 72),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 50),
                            child: Text(
                              "GET STARTED",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          );
        }
       
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Subscription Plan"),
          foregroundColor: Colors.white,
          backgroundColor: Color(0xffC4A68B),
        ),
        body: loader
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: AnotherCarousel(
                    overlayShadow: true,
                    autoplay: false,
                    dotBgColor: Colors.transparent,
                    dotColor: const Color.fromARGB(255, 10, 0, 100),
                    showIndicator: true,
                    dotIncreasedColor: Color.fromARGB(255, 10, 0, 100),
                    animationCurve: Curves.decelerate,
                    images: itms),
              ));
  }
}
