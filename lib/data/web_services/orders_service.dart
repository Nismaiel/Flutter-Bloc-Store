import 'dart:convert';

import 'package:bruva/data/models/myOrdersModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrdersService {
  Future<List<MyOrdersModel>> getMyOrders() async {
    final url =
        'https://test-33476-default-rtdb.firebaseio.com/checkout.json?orderBy="userId"&equalTo="${FirebaseAuth.instance.currentUser!.uid.toString()}"';
    List<MyOrdersModel> myOrders = [];
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      data.values.forEach((element) {
        myOrders.add(MyOrdersModel.fromJson(element));
      });
      return myOrders;
    } catch (e) {
      debugPrint(e.toString());
      return myOrders;
    }
  }
}
