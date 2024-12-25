import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mddmerchant/Promoss and ads/CreatePromoss_ads/create_pro_ads.dart';
import 'package:mddmerchant/api/api.dart';

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
                                  // margin: EdgeInsets.symmetric(vertical: 100,horizontal: 50),
                                  color: const Color.fromARGB(122, 0, 0, 0),
                                  // height: 300,
                                  // width: 50,
                                  child: Container(
                                    // foregroundDecoration: BoxDecoration(image: DecorationImage(image: AssetImage("assetsimages/main/ads.png"))),

                                    child: InteractiveViewer(
                                        child: Image.network(
                                            _Work_data[index]["ImagePath"])),
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
                                            // Navigator.of(context).pop();
                                          },
                                          icon: Container(
                                            height: 50,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Color(0xffC4A68B),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
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
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                  _Work_data[index]["ImagePath"],
                                ),
                                fit: BoxFit.cover)),
                      ),
                    );
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
        onPressed: () async {
          await Api.pickImage(img: true, source: ImageSource.gallery).then(
            (value) {
              Api.ImageInsert(
                      DocType: "1", ext: "." + value["ext"], img: value["file"])
                  .then(
                (value) {
                  setState(() {
                  loader = true;                    
                  });
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
                },
              );
            },
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
