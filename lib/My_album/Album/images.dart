import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:mddmerchant/Promoss and ads/CreatePromoss_ads/create_pro_ads.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:share_plus/share_plus.dart';

class MyImage extends StatefulWidget {
  @override
  State<MyImage> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  bool loader = false;
  List<dynamic> _data = [];
  List<dynamic> _Work_data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader = true;
    _data.clear();
    _Work_data.clear();
    Api.AccountDocument().then(
      (value) {
        _data = value;
        for (var i = 0; i < _data.length; i++) {
          if (_data[i]["Doctype"] == 1) {
            _Work_data.add(_data[i]);
          }
        }
        setState(() {
          loader = false;
        });
        print(_data);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'.tr,
            style: TextStyle(color: Colors.white, fontFamily: 'Fontmain')),
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
          _data.isEmpty
              ? Center(
                  child: Text(
                    'No Data Available'.tr,
                    style: TextStyle(
                        fontFamily: 'Fontmain', color: Color(0xe5777474)),
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    mainAxisExtent:
                        (MediaQuery.of(context).size.height / 2) * 0.5,
                  ),
                  padding: EdgeInsets.all(15),
                  itemCount: _Work_data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    color: const Color.fromARGB(122, 0, 0, 0),
                                    child: Container(
                                      child: CachedNetworkImage(
                                        progressIndicatorBuilder:
                                            (context, url, progress) {
                                          return Center(
                                              child:
                                                  CupertinoActivityIndicator());
                                        },
                                        errorWidget: (context, url, error) {
                                          Navigator.pop(context);                                          return Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/main/img.jpg"),
                                            )),
                                          );
                                        },
                                        imageUrl: _Work_data[index]
                                            ["ImagePath"],
                                        imageBuilder: (context, imageProvider) {
                                          return InteractiveViewer(
                                              child:
                                                  Image(image: imageProvider));
                                        },
                                      ),
                                    ),
                                  ),
                                  // TextButton(onPressed: (){}, child: ),
                                  
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              size: 30,
                                              color: Colors.white,
                                            )),
                                      )),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                    Api.UpdateProfileImg(img:_Work_data[index]["ImagePath"] ).then((value) {
                                                Api.Mpin_check(mob_no: Api.prefs.getString("mobile_no")??"", Mpin: Api.prefs.getString("mpin")??"");
                                             },).then((value) {
                                              Navigator.pop(context);
                                               Api.snack_bar2(context: context, message: "Done Set As Profile");
                                             },);
                                                },
                                                icon: Container(
                                                  height: 50,
                                                  width: ((MediaQuery.of(context).size.width)*0.5)-20,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffC4A68B),
                                                      // borderRadius:
                                                      //     BorderRadius.circular(
                                                      //         10)
                                                              ),
                                                  child:Text("Set As Profile".tr,style: TextStyle(
                                                            color: Colors.white,
                                                            // fontSize: 25
                                                            fontFamily: "Fontmain"
                                                            ),)
                                                )),
                                        
                                            IconButton(
                                                onPressed: () {
                                                  Api.downloadAndSaveImage(
                                                          _Work_data[index]
                                                                  ["ImagePath"]
                                                              .toString())
                                                      .then(
                                                    (value) async {
                                                      final result =
                                                          await Share.shareXFiles(
                                                              [XFile(value)],
                                                              text: '');
                                                    },
                                                  );
                                                },
                                                icon: Container(
                                                  height: 50,
                                                  width: ((MediaQuery.of(context).size.width)*0.5)-20,
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffC4A68B),
                                                      ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        spacing: 10,
                                                    children: [
                                                      Icon(
                                                        Icons.share,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        "Share".tr,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            // fontSize: 25
                                                            fontFamily: "Fontmain"
                                                            ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                        
                                          ],
                                        ),
                                      )),
                                  // // IconButton(onPressed: (){}, icon: Container(child: Text("Share")))
                                  // ElevatedButton.icon(onPressed: (){}, label: Text("Share"))
                                ],
                              );
                            },
                          );
                          print("object");
                        },
                        child: CachedNetworkImage(
                          imageUrl: _Work_data[index]["ImagePath"],
                          progressIndicatorBuilder: (context, url, progress) {
                            return CupertinoActivityIndicator();
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/main/img.jpg"),
                                      fit: BoxFit.cover)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                         showDialog(
                                          context: context,
                                          builder: (context) {
                                            ValueNotifier<bool>delete =ValueNotifier(false);
                                            ValueNotifier<bool>cancel =ValueNotifier(false);
                                            return AlertDialog(
                                              title: Text("Are You Sure".tr,style: TextStyle(fontFamily: "Fontmain"),),
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              content: Text(
                                                  "Do you really want to delete this image? The same cannot be undo".tr,style: TextStyle(fontFamily: "Fontmain")),
                                              actions: [
                                               ValueListenableBuilder(valueListenable: delete, builder: (context, value, child) {
                                                 return    InkWell(
                                                  onTap: (){
                                                      delete.value=true;
                                                       Navigator.of(context).pop();
                                                      setState(() {
                                                        loader = true;
                                                      });
                                                       
                                                      Api.DeleteImgvideo(
                                                              Id: _Work_data[
                                                                          index]
                                                                      ["Id"]
                                                                  .toString())
                                                          .then((value) {
                                                        if (value) {
                                                        
                                                          
                                                          _data.clear();
                                                          _Work_data.clear();
                                                          Api.AccountDocument()
                                                              .then((value) {
                                                            _data = value;
                                                            for (var i = 0;
                                                                i <
                                                                    _data
                                                                        .length;
                                                                i++) {
                                                              if (_data[i][
                                                                      "Doctype"] ==
                                                                  1) {
                                                                _Work_data.add(
                                                                    _data[i]);
                                                              }
                                                            }
                                                            Api.snack_bar2(context: context, message: "Image Deleted".tr);
                                                            setState(() {
                                                              loader = false;
                                                            });
                                                          });
                                                        }
                                                      });
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal:  20),
                                                    decoration: BoxDecoration(
                                                      color: value? Colors.white: Color(0xffC4A68B)
                                                  
                                                    ),
                                                    child: Text("Delete".tr,style: TextStyle(color: value?Colors.black:Colors.white,fontFamily: "Fontmain"),),
                                                  ),
                                                );
                                               },),
                                              ValueListenableBuilder(valueListenable:cancel , builder: (context, value, child) {
                                                return     InkWell(
                                                  onTap: (){
                                                       cancel.value=true;
                                                      Navigator.of(context)
                                                          .pop();
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal:  20),
                                                    decoration: BoxDecoration(
                                                      color: value? Colors.white: Color(0xffC4A68B)
                                                  
                                                    ),
                                                    child: Text("Cancel".tr,style: TextStyle(color: value?Colors.black:Colors.white,fontFamily: "Fontmain"),),
                                                  ),
                                                );
                                              },) ],
                                            );
                                          },
                                        );
                                  
                                      },
                                      icon: Container(
                                     alignment: Alignment.center,
                                    height: 30,
                                        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 1),
                                        
                                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(3),boxShadow: [BoxShadow(blurRadius: 5,color: const Color.fromARGB(117, 0, 0, 0),offset: Offset(0, 0))]),
                                      
                                        // padding: EdgeInsets.all(20),
                                        // color: Colors.white,
                                        child: Icon(Icons.delete,color:  Color(0xffC4A68B),)))
                                ],
                              ),
                            );
                          },
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.contain)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            ValueNotifier<bool>delete =ValueNotifier(false);
                                            ValueNotifier<bool>cancel =ValueNotifier(false);
                                            return AlertDialog(
                                              title: Text("Are You Sure".tr,style: TextStyle(fontFamily: "Fontmain"),),
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              content: Text(
                                                  "Do you really want to delete this image? The same cannot be undo".tr,style: TextStyle(fontFamily: "Fontmain")),
                                              actions: [
                                               ValueListenableBuilder(valueListenable: delete, builder: (context, value, child) {
                                                 return    InkWell(
                                                  onTap: (){
                                                      delete.value=true;
                                                       Navigator.of(context).pop();
                                                      setState(() {
                                                        loader = true;
                                                      });
                                                       
                                                      Api.DeleteImgvideo(
                                                              Id: _Work_data[
                                                                          index]
                                                                      ["Id"]
                                                                  .toString())
                                                          .then((value) {
                                                        if (value) {
                                                        
                                                          
                                                          _data.clear();
                                                          _Work_data.clear();
                                                          Api.AccountDocument()
                                                              .then((value) {
                                                            _data = value;
                                                            for (var i = 0;
                                                                i <
                                                                    _data
                                                                        .length;
                                                                i++) {
                                                              if (_data[i][
                                                                      "Doctype"] ==
                                                                  1) {
                                                                _Work_data.add(
                                                                    _data[i]);
                                                              }
                                                            }
                                                            Api.snack_bar2(context: context, message: "Image Deleted".tr);
                                                            setState(() {
                                                              loader = false;
                                                            });
                                                          });
                                                        }
                                                      });
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal:  20),
                                                    decoration: BoxDecoration(
                                                      color: value? Colors.white: Color(0xffC4A68B)
                                                  
                                                    ),
                                                    child: Text("Delete".tr,style: TextStyle(color: value?Colors.black:Colors.white,fontFamily: "Fontmain"),),
                                                  ),
                                                );
                                               },),
                                              ValueListenableBuilder(valueListenable:cancel , builder: (context, value, child) {
                                                return     InkWell(
                                                  onTap: (){
                                                       cancel.value=true;
                                                      Navigator.of(context)
                                                          .pop();
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal:  20),
                                                    decoration: BoxDecoration(
                                                      color: value? Colors.white: Color(0xffC4A68B)
                                                  
                                                    ),
                                                    child: Text("Cancel".tr,style: TextStyle(color: value?Colors.black:Colors.white,fontFamily: "Fontmain"),),
                                                  ),
                                                );
                                              },) ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 1),
                                        
                                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(3),boxShadow: [BoxShadow(blurRadius: 5,color: const Color.fromARGB(117, 0, 0, 0),offset: Offset(0, 0))]),
                                        child: Icon(Icons.delete,color:  Color(0xffC4A68B),)),)
                                ],
                              ),
                            );
                          },
                        ));
                  },
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 5,),
          Text("Max.10 images can be uploaded".tr,style: TextStyle(color: Colors.black38),),
          FloatingActionButton(
            onPressed: () async {
          
             if(_Work_data.length<10){
               await Api.pickImage(img: true, source: ImageSource.gallery).then(
                (value) {
                   setState(() {
                        loader = true;
                      });
                 if(value["file"]!=""){
                   Api.ImageInsert(
                          MemberAgreementUpload_UploadFile2: "UploadFile2",
                          DocType: "1",
                          ext: "." + value["ext"],
                          img: value["file"],
                          context: context)
                      .then(
                    (value) {
                     
                      _data.clear();
                      _Work_data.clear();
                      Api.AccountDocument().then(
                        (value) {
                          _data = value;
                          for (var i = 0; i < _data.length; i++) {
                            if (_data[i]["Doctype"] == 1) {
                              _Work_data.add(_data[i]);
                            }
                          }
                         Api.snack_bar2(context: context, message: "Image Upload Done".tr);
                          setState(() {
                            loader = false;
                          });
                          print(_data);
                        },
                      );
                    },
                  );
                 }else{
                    setState(() {
                            loader = false;
                          });
                 }
                },
              );
             }else{
              Api.snack_bar(context: context, message: "Storage full on this section");
             }
            },
            child: Icon(Icons.add, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(44), // Adjust the value for desired radius
            ),
            backgroundColor: Color(0xffC4A68B),
          ),
        ],
      ),
    );
  }
}
