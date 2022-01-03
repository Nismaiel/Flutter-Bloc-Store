import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  getShippingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('shippingInfo')) {
      String encMap = prefs.getString('shippingInfo').toString();
      Map shippingInfo = json.decode(encMap);
      emit(AddedShippingData(mobileNumber: shippingInfo['mobileNumber'],
          lastName: shippingInfo['lastName'],
          firstName: shippingInfo['firstName'],
          additionalNotes: shippingInfo['additionalNotes'],
          building: shippingInfo['building'],
          floor: shippingInfo['floor'],
          apartment: shippingInfo['apartment'],
          streetName: shippingInfo['streetName']));
    }
  }
}