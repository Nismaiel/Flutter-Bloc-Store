import 'package:bruva/business_logic/location/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({Key? key}) : super(key: key);

  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoaded) {
            return Text(state.location.toString());
          } else if (state is LocationLoading) {
            return const CircularProgressIndicator();
          }else{return Center(child: Text(state.toString()),);}
        },
      ),
    );
  }
}
