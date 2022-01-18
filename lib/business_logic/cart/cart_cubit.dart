import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bruva/data/models/cart_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final String cartUrl =
      'https://test-33476-default-rtdb.firebaseio.com/cart.json';

  int total = 0;

  getCartItems() async {
    try {
      emit(CartLoading());
      final response = await http.get(Uri.parse(cartUrl));
      final decodedBody = json.decode(response.body);
      List<CartItems> items = [];

      if (decodedBody != null) {
        decodedBody.forEach((key, value) {

          total += int.parse(CartItems.fromJson(key,value).product.price);
          items.add(CartItems.fromJson(key,value));
        });
        emit(CartLoaded(cartItems: items));
      } else {
        emit(CartInitial());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addToCart(size, color, Product product) async {
    try {
      Map cartMap = {
        'size': size.toString(),
        'color': color,
        'product': product,
        'id': DateTime.now().microsecondsSinceEpoch.toString(),
        'userId': FirebaseAuth.instance.currentUser!.uid
      };

      await http.post(Uri.parse(cartUrl), body: json.encode(cartMap));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  removeFromCart(String cartKey) async {
    try {
     await FirebaseDatabase.instance
          .ref('cart/$cartKey').remove();


      getCartItems();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
