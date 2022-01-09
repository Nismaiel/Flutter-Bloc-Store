import 'dart:collection';
import 'dart:convert';

import 'package:bruva/consts/constants.dart';
import 'package:bruva/data/models/myOrdersModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:dio/dio.dart';
class OrdersService{

 Future<List<MyOrdersModel>> getMyOrders()async{
   late Dio dio;

   BaseOptions options = BaseOptions(
     baseUrl: productUrl,
     receiveTimeout: 20 * 1000,
     sendTimeout: 20 * 1000,
     receiveDataWhenStatusError: true,
   );
   dio = Dio(options);

   List<MyOrdersModel> myOrders=[];
   try{
     final response=await http.get(Uri.parse(ordersUrl));
     final data=json.decode(response.body);

     data.values.forEach((element) {myOrders.add(MyOrdersModel.fromJson(element));});
      return myOrders;
    }catch(e){
      debugPrint(e.toString());
      return myOrders;
    }
  }
}