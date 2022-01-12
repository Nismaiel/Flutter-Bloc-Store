import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bruva/business_logic/products/product_bloc.dart';
import 'package:bruva/data/models/cart_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:bruva/presentation/screens/cart/cart_item.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) async{
      if (event is StartCart) {
        _mapStartCart();
      } else if (event is AddToCart ) {
        _mapAddToCart(event, state);
      } else if (event is RemoveFromCart) {
        _mapRemoveFromCart(event, state);
      }
    });
  }

  _mapStartCart() async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(CartLoaded());
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  _mapAddToCart(AddToCart event, CartState state) async {
    try {
      emit(CartLoaded(
          cartItems: CartItems(sizes:List.from(state.cartItems.sizes)..add(event.size),colors:List.from(state.cartItems.colors)..add(event.color),
              products: List.from(state.cartItems.products)
                ..add(event.product,),total: state.cartItems.total+int.parse(event.product.price))));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  _mapRemoveFromCart(RemoveFromCart event, CartState state) async {
    try {
      emit(CartLoaded(
          cartItems: CartItems(
              products: List.from(state.cartItems.products)
                ..remove(event.product),total: state.cartItems.total-int.parse(event.product.price))));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

}