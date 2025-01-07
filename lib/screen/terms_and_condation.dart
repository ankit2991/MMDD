import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mddmerchant/constrans.dart';
import 'package:webview_flutter/webview_flutter.dart';

class read_TermsAndConditation extends StatefulWidget {
  const read_TermsAndConditation({super.key});

  @override
  State<read_TermsAndConditation> createState() => _read_TermsAndConditationState();
}

class _read_TermsAndConditationState extends State<read_TermsAndConditation> {
  @override
      late final WebViewController _controller;
      bool _isLoading=true;
  void initState() {
    // TODO: implement initState
    super.initState();
      _controller = WebViewController()
      ..loadRequest(Uri.parse('https://makemydreamday.in/TermsAndConditions.aspx')) // Load a URL
      ..setJavaScriptMode(JavaScriptMode.unrestricted)  ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (_) {
            setState(() {
              _isLoading = false;
            });
          },
        ),); // Enable JavaScript
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms & Conditions",style: TextStyle(fontFamily: "Fontmain"),),backgroundColor: mainColor,foregroundColor: Colors.white,),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller
          ),
          if(_isLoading)
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
