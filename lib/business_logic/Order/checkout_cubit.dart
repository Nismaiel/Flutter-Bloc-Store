import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bruva/consts/constants.dart';
import 'package:bruva/data/models/myOrdersModel.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'checkoutCubitState.dart';

class checkoutCubit extends Cubit<checkOutCubitState> {
  checkoutCubit() : super(checkoutCubitInitial());

  getShippingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('shippingInfo')) {
      String encMap = prefs.getString('shippingInfo').toString();
      Map shippingInfo = json.decode(encMap);
      emit(AddedShippingData(
        mobileNumber: shippingInfo['mobileNumber'],
        lastName: shippingInfo['lastName'],
        firstName: shippingInfo['firstName'],
        additionalNotes: shippingInfo['additionalNotes'],
        building: shippingInfo['building'],
        floor: shippingInfo['floor'],
        apartment: shippingInfo['apartment'],
        streetName: shippingInfo['streetName'],
        lat: shippingInfo['lat'],
        long: shippingInfo['long'],
      ));
    }
  }

  placeOrder(
      String orderId,
      List<Product> products,
      String userId,
      bool onlinePayment,
      String total,
      String subtotal,
      String retailPrice,
      String shippingFee) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('shippingInfo')) {
      String encMap = prefs.getString('shippingInfo').toString();
      Map shippingInfo = json.decode(encMap);

      try {
        List prodList=[];
        for (var element in products) {prodList.add(element.toJson());}

        var order = {
          'orderId': orderId,
          'userId': userId,
          'dateTime': DateTime.now().toString(),
          'shippingInfo': shippingInfo,
          'products':prodList,
          'onlinePayment': onlinePayment,
          'total': total,
          'subtotal': subtotal,
          'retailPrice': retailPrice,
          'shippingFee': shippingFee,
        };
        emit(CheckoutCubitLoading());
        http.Response res=await http.post(Uri.parse(ordersUrl), body: json.encode(order));
        debugPrint(res.body);
        if(res.statusCode==200){
        emit(OrderPlaced(orderNumber: orderId,userName: shippingInfo['firstName']));}else{
          getShippingData();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
