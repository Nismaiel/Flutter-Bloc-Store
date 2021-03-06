import 'dart:async';

import 'package:bruva/business_logic/location/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickLocation extends StatelessWidget {
  PickLocation({Key? key}) : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
saveLoc(String lat,String long)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString('lat', lat);
    prefs.setString('long', long);
}
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 250,
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is LocationLoaded) {
              saveLoc(state.location.latitude.toString(), state.location.longitude.toString());
              return GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          state.location.latitude, state.location.longitude),
                      zoom: 15),
                  myLocationEnabled: true,
                  buildingsEnabled: true,
                  zoomGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  mapType: MapType.normal,
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: true);
            } else if (state is LocationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(
                child:CircularProgressIndicator()
              );
            }
          },
        ),
      ),
    );
  }
}
