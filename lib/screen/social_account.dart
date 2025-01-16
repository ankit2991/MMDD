import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mddmerchant/api/api.dart';

class social_account extends StatefulWidget {
  const social_account({super.key});

  @override
  State<social_account> createState() => _social_accountState();
}

class _social_accountState extends State<social_account> {
  var insta_con =TextEditingController();
  var youtub_con =TextEditingController();
  var Facebook_con =TextEditingController();
  bool loader=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Api.User_info["Table"][0]["InstagramLink"]!=null){
      insta_con.text=Api.User_info["Table"][0]["InstagramLink"];
    }
    if(Api.User_info["Table"][0]["FacebookLink"]!=null){
      Facebook_con.text=Api.User_info["Table"][0]["FacebookLink"];

    }
    if(Api.User_info["Table"][0]["YouTudeLink"]!=null){
      youtub_con.text=Api.User_info["Table"][0]["YouTudeLink"];

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Social Account',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontmain',
          ),
        ),
        backgroundColor: Color(0xffC4A68B),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 10,
              children: [
              TextFormField(
                        controller: insta_con,
                        decoration: InputDecoration(
                          labelText: "Instagram",
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
                        // inputFormatters: [
                        //   // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                        // ],
                      ),
           
              TextFormField(
                        controller: Facebook_con,
                        decoration: InputDecoration(
                          labelText: "Facebook",
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
                        // inputFormatters: [
                        //   // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                        // ],
                      ),
           
              TextFormField(
                
                        controller: youtub_con,
                        decoration: InputDecoration(
                          // prefix:,
                          labelText: "YouTube",
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
                        // inputFormatters: [
                        //   // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                        // ],
                      ),
          SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          try {
                            if(insta_con.text.isNotEmpty||Facebook_con.text.isNotEmpty||youtub_con.text.isNotEmpty){
                              setState(() {
                              loader=true;
                            });
                          Api.AddSocialAccount(FacebookLink: Facebook_con.text.trim(),InstagramLink: insta_con.text.trim(),YouTudeLink: youtub_con.text.trim()).then((value) {
                             Api.Mpin_check(
                                            mob_no: Api.prefs
                                                    .getString("mobile_no") ??
                                                "",
                                            Mpin: Api.prefs.getString("mpin") ??
                                                "").then((value) {
                                                    setState(() {
                            Api.snack_bar(context: context, message: "Save Done");

                              loader=false;
                            });
                                                },);
                            
                          },);
                            }else{

                            Api.snack_bar(context: context, message: "enter some data");
                            }
                            
                          } catch (e) {
                            Api.snack_bar(context: context, message: "Somthing went Wrong");
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                          decoration: BoxDecoration(color:  Color(0xffC4A68B)),
                          child: Text("Save",style: TextStyle(fontFamily: "Fontmain",color: Colors.white,fontSize: 20),),),
                      )
           
            ],),
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