import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pdf/widgets.dart' as pw;

class show_pdf extends StatefulWidget {
  pw.Document my_pdf;
  show_pdf({required this.my_pdf});

  @override
  State<show_pdf> createState() => _show_pdfState();
}

class _show_pdfState extends State<show_pdf> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    File file = File("");
    ValueNotifier<bool> temp = ValueNotifier(false);
    Future<void> get_dir() async {
      // temp.value = true;
      final directory = await getTemporaryDirectory();
      file = File(
          "${directory!.path}/MMDD${DateTime.now().millisecondsSinceEpoch}.pdf");
      file.writeAsBytes(await widget.my_pdf.save()).then(
        (value) {
          temp.value = true;
        },
      );
    }

    get_dir();
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xffC4A68B),
        title: Text("INVOICE",
            style: TextStyle(fontFamily: "Fontmain", color: Colors.white)),
      ),
      body: ValueListenableBuilder(
        valueListenable: temp,
        builder: (context, value, child) {
          return
               Stack(
                children: [
                 value? SfPdfViewer.file(file):SizedBox(),
                if (value==false)
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
              );
        },
      ),
      floatingActionButton: Row(
        children: [
          GestureDetector(
            onTap: () async{
              final result = await Share.shareXFiles([XFile(file.path)], text: '');
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 50,
              width: (MediaQuery.of(context).size.width / 2) - 10,
              color: Color(0xffC4A68B),
              child: Text(
                "Share ",
                style: TextStyle(fontFamily: "Fontmain", color: Colors.white),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              temp.value=false;
              final directory = Directory('/storage/emulated/0/Download');
              final file = File(
                  "${directory!.path}/MMDD${DateTime.now().millisecondsSinceEpoch}.pdf");
               file.writeAsBytes(await widget.my_pdf.save()).then((value) {
                  Navigator.of(context).pop();
                  temp.value=true;
              },);
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 50,
              width: (MediaQuery.of(context).size.width / 2) - 10,
              color: Color(0xffC4A68B),
              child: Text(
                "Download",
                style: TextStyle(fontFamily: "Fontmain", color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
