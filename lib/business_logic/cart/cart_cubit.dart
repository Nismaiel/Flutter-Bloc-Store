import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bruva/data/models/cart_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart'as http;

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final String cartUrl=
      'https://test-33476-default-rtdb.firebaseio.com/cart/${FirebaseAuth.instance.currentUser!.uid}.json';

 Stream<CartItems> getCart() async* {
    emit(CartLoading());
    try {
      await Future.delayed(const Duration(seconds: 5));
      final res =await http.get(Uri.parse(cartUrl));
      print(res.body);
      emit(CartLoaded());
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  addToCart(size,color,Product product) async {
    try {

      Map cartMap = {
        'size': size.toString(),
        'color':color,
        'product':product,
        'id':DateTime.now().microsecondsSinceEpoch.toString()
      };

      await http.post(Uri.parse(cartUrl),body: json.encode(cartMap));

    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  removeFromCart(String id) async {
    try {
      // http.delete(url)
      // emit(CartLoaded(
      //     cartItems: CartItems(
      //         products: List.from(state.cartItems.products)
      //           ..remove(product),
      //         total: state.cartItems.total - int.parse(event.product.price))));
     } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
