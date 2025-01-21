import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map_Screen extends StatefulWidget {
  const map_Screen({super.key});

  @override
  State<map_Screen> createState() => _map_ScreenState();
}

class _map_ScreenState extends State<map_Screen> {
   final Completer<GoogleMapController> _controller =Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition:_kGooglePlex ,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        ),
    
    );
  }
}