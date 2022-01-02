// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// part 'location_event.dart';
// part 'location_state.dart';
//
// class LocationBloc extends Bloc<LocationEvent, LocationState> {
//   LocationBloc() : super(LocationInitial()) {
//     on<LocationEvent>((event, emit){
//       // TODO: implement event handler
//
//     });
//   }
//
//  Stream _mapGeolocationRequestLocation(LocationEvent event) async* {
//     Position position;
//     print('asd');
//     try {
//       if (event is GetLocation){
//         position = await Geolocator.getCurrentPosition();
//       print("RETRIEVED LOCATION"); // I CAN REACH HERE EVERYTIME.
//       yield LocationLoaded(location: position);
//     } }catch(e){
//       print(e.toString());
//     }
//   }
//
// }