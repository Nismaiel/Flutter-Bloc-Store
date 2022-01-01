import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
      if(event is GetLocation){
        print('asldj');
        _mapGeolocationRequestLocation();
      }
    });
  }
}
Stream _mapGeolocationRequestLocation() async* {
  Position position;
  position = await Geolocator.getCurrentPosition();
  print("RETRIEVED LOCATION"); // I CAN REACH HERE EVERYTIME.
yield LocationLoaded(location: position);
}