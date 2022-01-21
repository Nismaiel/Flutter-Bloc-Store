import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bruva/data/models/cart_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final String cartUrl =
      'https://test-33476-default-rtdb.firebaseio.com/cart.json';

  int total = 0;
  List<CartItems> items = [];

  getCartItems() async {
    try {
      emit(CartLoading());
items=[];
        FirebaseFirestore.instance
            .collection('cart')
            .get()
            .then((value) => value.docs.forEach((element) {
                  items.add(CartItems(product: element['product'],color: element['color'],size: element['size'],id: element.id));
                  emit(CartLoaded(cartItems:items ));
                }));

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addToCart(size, color, Product product) async {
    try {
      String docId = DateTime.now().microsecondsSinceEpoch.toString();
      Map<String, dynamic> cartMap = {
        'size': size.toString(),
        'color': color,
        'product': product.toJson(),
        'id': docId,
        'userId': FirebaseAuth.instance.currentUser!.uid
      };
      FirebaseFirestore.instance.collection('cart').add(cartMap);
    } catch (e) {
      emit(CartError(message: e.toString()));
      debugPrint(e.toString());
    }
  }

  removeFromCart(String cartKey) async {
    try {
FirebaseFirestore.instance.collection('cart').doc(cartKey).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
