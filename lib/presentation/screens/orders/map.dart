import 'package:bruva/business_logic/location/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({Key? key}) : super(key: key);

  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<LocationCubit>().getLoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          if (state is LocationLoaded) {
            return Stack(
              children: [
                GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            state.location.latitude, state.location.longitude),
                        zoom: 15),
                    myLocationEnabled: true,
                    buildingsEnabled: true,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true),
                Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width / 1.1,
                                  50))),
                          onPressed: () {},
                          child: const Text('Deliver here!')),
                    )),
              ],
            );
          } else if (state is LocationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: ElevatedButton(
                  onPressed: () {}, child: Text(state.toString())),
            );
          }
        },
      ),
    );
  }
}
