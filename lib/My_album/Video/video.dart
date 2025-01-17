import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mddmerchant/Promoss and ads/CreatePromoss_ads/create_pro_ads.dart';
import 'package:mddmerchant/api/api.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class MyVideo extends StatefulWidget {
  @override
  State<MyVideo> createState() => _MyVideoState();
}

class _MyVideoState extends State<MyVideo> {
  bool loader = false;
  List<dynamic> _data = [];
  List<dynamic> _Work_data = [];
  late List<VideoPlayerController> controllers = <VideoPlayerController>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader = true;
    _data.clear();
    _Work_data.clear();
    controllers.clear();
    Api.AccountDocument().then(
      (value) async {
        _data = value;
        for (var i = 0; i < _data.length; i++) {
          if (_data[i]["Doctype"] == 2) {
            _Work_data.add(_data[i]);
            VideoPlayerController temp = await VideoPlayerController.networkUrl(
                Uri.parse(_data[i]["ImagePath"]))
              ..initialize()
              ..setLooping(true)
              ..pause();
            controllers.add(temp);
          }
        }
        // controllers = _Work_data
        // .map((url) => VideoPlayerController.network(url)..initialize())
        // .toList();
        setState(() {
          loader = false;
        });
        print(_data);
      },
    );
  }
// void add()async{
//   _Work_data.clear();
//   for (var i = 0; i < _data.length; i++) {
//           if (_data[i]["Doctype"] == 2) {
//             _Work_data.add(_data[i]);
//             VideoPlayerController temp = await VideoPlayerController.networkUrl(
//                 Uri.parse(_data[i]["ImagePath"]))
//               ..initialize()
//               ..setLooping(true)
//               ..pause();
//             controllers.add(temp);
//           }
//         }
//         setState(() {
          
//         });
// }
  @override
  
  Widget build(BuildContext context) {
    //  add();
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'.tr,
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
          _Work_data.isEmpty
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
                    var controller = controllers[index];
                    // controller.play();
                    return GestureDetector(
                      onTap: () {
                        controller.play();
                        
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
                                      child: AspectRatio(
                                        aspectRatio:
                                            controller.value.aspectRatio,
                                        child: VideoPlayer(controller),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                          onPressed: () {
                                            controller.pause();
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
                                          vertical: 15, horizontal: 100),
                                      child: IconButton(
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
                                            // Navigator.of(context).pop();
                                          },
                                          icon: Container(
                                            height: 50,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Color(0xffC4A68B),
                                               ),
                                            child: Row(
                                              spacing: 10,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                      // fontSize: 25,
                                                      fontFamily: "Fontmain"
                                                      ),
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
                        ).then((value) {
                         controller.pause();
                        },);
                        print("object");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: Stack(
                              children: [
                                VideoPlayer(controller),
                                Row(
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
                                                title: Text("Are You Sure".tr,style: TextStyle(fontFamily: "Fontmain"),),
                                                actionsAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                content: Text(
                                                    "Do you really want to delete this Video? The same cannot be undo".tr,style: TextStyle(fontFamily: "Fontmain")),
                                                actions: [
                                                  ValueListenableBuilder(
                                                    valueListenable: delete,
                                                    builder: (context, value,
                                                        child) {
                                                      return InkWell(
                                                  onTap: (){
                                                       delete.value = true;
                                                       Navigator.of(context).pop();
                                                          setState(() {
                                                            loader = true;
                                                          });

                                                          Api.DeleteImgvideo(Id: _Work_data[index]["Id"].toString()).then((value) {
                                                            if (value) {
                                                              
                                                               Api.snack_bar2(context: context, message: "Video Deleted".tr);
                                                              _data.clear();
                                                              _Work_data.clear();
                                                              controllers.clear();
                                                              Api.AccountDocument().then(
                                                                      (value) async {
                                                                _data = value;
                                                                for (var i = 0;i <_data.length;i++) {
                                                                  if (_data[i]["Doctype"] ==2) {
                                                                    _Work_data.add(_data[i]);
                                                                    VideoPlayerController temp = await VideoPlayerController.networkUrl(Uri.parse(_data[i]["ImagePath"]))
                                                                          ..initialize()..setLooping(true)..play();
                                                                    controllers.add(temp);
                                                                  }
                                                                }

                                                                setState(() {
                                                                  loader =false;
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
                                                    },
                                                  ),
                                                  ValueListenableBuilder(
                                                    valueListenable: cancel,
                                                    builder: (context, value,
                                                        child) {
                                                      return InkWell(
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
                              ],
                            ),
                          ),
                        ),
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // spacing: 50,
        children: [
          SizedBox(width: 5,),
          Text("Max. 2 Clips can be uploaded Upto 2 MB".tr,style: TextStyle(color: Colors.black38,fontSize:13 ),),
          FloatingActionButton(
            onPressed: () {
              if (_Work_data.length<2) {
                   Api.pickImage(img: false, source: ImageSource.gallery).then(
                (value) {
                  setState(() {
                    loader=true;
                  });
                   final int fileSize = value["file"]!.lengthSync(); 
                   if (fileSize / (1024 * 1024)<=2) {
                          Api.ImageInsert(
                          DocType: "2",
                          ext: "." + value["ext"],
                          img: value["file"],
                          MemberAgreementUpload_UploadFile2: "UploadFile2",
                          context: context)
                      .then(
                    (value) {
                     
                      _data.clear();
                      _Work_data.clear();
                      controllers.clear();
                      Api.AccountDocument().then((value) async {
                        _data = value;
                        for (var i = 0; i < _data.length; i++) {
                          if (_data[i]["Doctype"] == 2) {
                            _Work_data.add(_data[i]);
                            VideoPlayerController temp = await VideoPlayerController
                                .networkUrl(Uri.parse(_data[i]["ImagePath"]))
                              ..initialize()
                              ..setLooping(true)
                              ..play();
                            controllers.add(temp);
                          }
                        }
                        setState(() {
                          loader = false;
                        });
                        Api.snack_bar(context: context, message: "Video Upload Done".tr);
                        print(_data);
                      });
                    },
                  );
            
                   }else{
                     setState(() {
                        loader = false;
                      });
                    Api.snack_bar(context: context, message: "Not select Video size more than 2 MB".tr);
                   }
                 },
              );
              
              }else{
                Api.snack_bar(context: context, message: "Storage Full on this Section".tr);
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
