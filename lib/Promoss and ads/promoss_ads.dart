import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mddmerchant/Promoss and ads/CreatePromoss_ads/create_pro_ads.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PromissAds extends StatefulWidget {
  @override
  State<PromissAds> createState() => _PromissAdsState();
}

class _PromissAdsState extends State<PromissAds> {
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
          if (_data[i]["Doctype"] == 3) {
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

  void refresh() {
    setState(() {
      loader = true;
    });
    Api.AccountDocument().then(
      (value) {
        _data = value;
        for (var i = 0; i < _data.length; i++) {
          if (_data[i]["Doctype"] == 3) {
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
        title: Text('Promos & Ads'.tr,
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
                    'No Data Available',
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
                                          return Container(
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
                                            vertical: 15, horizontal: 80),
                                        child: IconButton(
                                            onPressed: () {
                                              print("object");
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
                                              // Navigator.of(context).pop();
                                            },
                                            icon: Container(
                                              height: 50,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffC4A68B),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.share,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "Share",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                                  )
                                                ],
                                              ),
                                            )),
                                      )),
                                  // IconButton(onPressed: (){}, icon: Container(child: Text("Share")))
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            ValueNotifier<bool> delete =
                                                ValueNotifier(false);
                                            ValueNotifier<bool> cancel =
                                                ValueNotifier(false);
                                            return AlertDialog(
                                              title: Text("Are You Sure"),
                                              actionsAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              content: Text(
                                                  "Do you really went to delete these Item? This process cannot be undo"),
                                              actions: [
                                                ValueListenableBuilder(
                                                  valueListenable: delete,
                                                  builder:
                                                      (context, value, child) {
                                                    return ElevatedButton(
                                                      onPressed: () {
                                                        delete.value = true;
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                             Api.snack_bar(context: context, message: "Item Deleted");
                                                            _data.clear();
                                                            _Work_data.clear();
                                                            Api.AccountDocument()
                                                                .then((value) {
                                                              _data = value;
                                                              for (var i = 0;i <_data.length;i++) {
                                                                if (_data[i]["Doctype"] ==3) {
                                                                  _Work_data.add(_data[i]);
                                                                }
                                                              }
                                                              setState(() {
                                                                loader = false;
                                                              });
                                                            });
                                                          }
                                                        });
                                                      },
                                                      child: Text("Delete"),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(value
                                                                      ? Colors
                                                                          .white
                                                                      : Color(
                                                                          0xffC4A68B)),
                                                          foregroundColor:
                                                              WidgetStateProperty
                                                                  .all(value
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white)),
                                                    );
                                                  },
                                                ),
                                                ValueListenableBuilder(
                                                  valueListenable: cancel,
                                                  builder:
                                                      (context, value, child) {
                                                    return ElevatedButton(
                                                      onPressed: () {
                                                        cancel.value = true;
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Cancel"),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(value
                                                                      ? Colors
                                                                          .white
                                                                      : Color(
                                                                          0xffC4A68B)),
                                                          foregroundColor:
                                                              WidgetStateProperty
                                                                  .all(value
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white)),
                                                    );
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Color(0xffC4A68B)))
                                ],
                              ),
                            );
                          },
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                    showDialog(
                                          context: context,
                                          builder: (context) {
                                            ValueNotifier<bool> delete =
                                                ValueNotifier(false);
                                            ValueNotifier<bool> cancel =
                                                ValueNotifier(false);
                                            return AlertDialog(
                                              title: Text("Are You Sure"),
                                              actionsAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              content: Text(
                                                  "Do you really went to delete these Item? This process cannot be undo"),
                                              actions: [
                                                ValueListenableBuilder(
                                                  valueListenable: delete,
                                                  builder:
                                                      (context, value, child) {
                                                    return ElevatedButton(
                                                      onPressed: () {
                                                        delete.value = true;
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                             Api.snack_bar(context: context, message: "Item Deleted");
                                                            _data.clear();
                                                            _Work_data.clear();
                                                            Api.AccountDocument()
                                                                .then((value) {
                                                              _data = value;
                                                              for (var i = 0;i <_data.length;i++) {
                                                                if (_data[i]["Doctype"] ==3) {
                                                                  _Work_data.add(_data[i]);
                                                                }
                                                              }
                                                              setState(() {
                                                                loader = false;
                                                              });
                                                            });
                                                          }
                                                        });
                                                      },
                                                      child: Text("Delete"),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(value
                                                                      ? Colors
                                                                          .white
                                                                      : Color(
                                                                          0xffC4A68B)),
                                                          foregroundColor:
                                                              WidgetStateProperty
                                                                  .all(value
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white)),
                                                    );
                                                  },
                                                ),
                                                ValueListenableBuilder(
                                                  valueListenable: cancel,
                                                  builder:
                                                      (context, value, child) {
                                                    return ElevatedButton(
                                                      onPressed: () {
                                                        cancel.value = true;
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Cancel"),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(value
                                                                      ? Colors
                                                                          .white
                                                                      : Color(
                                                                          0xffC4A68B)),
                                                          foregroundColor:
                                                              WidgetStateProperty
                                                                  .all(value
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white)),
                                                    );
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        );      
                                      },
                                      icon: Icon(Icons.delete,color:  Color(0xffC4A68B)))
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateProAds(
                      refresh: refresh,
                    )),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(44), // Adjust the value for desired radius
        ),
        backgroundColor: Color(0xffC4A68B),
      ),
    );
  }
}
