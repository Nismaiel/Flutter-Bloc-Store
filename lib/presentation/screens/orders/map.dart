import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class PickLocation extends StatefulWidget {
  const PickLocation({Key? key}) : super(key: key);

  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Stack(children: [
    GoogleMap(mapToolbarEnabled: true,mapType: MapType.hybrid,initialCameraPosition:CameraPosition(zoom: 12,target: LatLng(10, 10)),),
    ],) ,);
  }
}
