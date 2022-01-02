import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

   setLocation(Position loc)=>setLoc(loc);

  setLoc(Position loc){
   try{
     emit(LocationAdded(location: loc));
   }catch(e){    debugPrint(e.toString());
   }
  }

}
