import 'dart:convert';

import 'package:bruva/consts/constants.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future requestPayment(String orderId,double cartAmount) async {
    try {
      var body = json.encode({
        "profile_id":86184,
        "tran_type":"sale",
        "tran_class":"ecom",
        "cart_id":orderId,
        "cart_description":"Dummy Order 35925502061445345",
        "cart_currency": "EGP",
        "cart_amount": cartAmount,
        "card_details": {
          "pan": "4000000000000002",
          "expiry_month":     02,
          "expiry_year":   2021,
          "cvv": "123"
        }


      });


      final response = await http.post(Uri.parse(transactionApi),body: body,
          headers: {"content-type": "application/json", "authorization":serverKey});
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}



