import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:pdf/widgets.dart' as pw;

class show_pdf extends StatefulWidget {
 PdfDocument my_pdf; 
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
     File file=File("");
      Future<void> get_dir()async{
   final directory =await getTemporaryDirectory();
   file = File("${directory!.path}/${DateTime.now().millisecondsSinceEpoch}.pdf");    
    await file.writeAsBytes(await widget.my_pdf.save());
}
    return Scaffold(
      body: SfPdfViewer.file(file),
    );
  }
}