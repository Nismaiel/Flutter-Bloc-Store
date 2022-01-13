import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  void getLoc()=>getLocation();
   getLocation()async{
    Position position;
    try {
        position = await Geolocator.getCurrentPosition();
      emit(LocationLoaded(location: position));
    } catch(e){
      print(e.toString());
  }
}}
