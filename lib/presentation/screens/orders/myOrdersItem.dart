import 'package:bruva/business_logic/favorites/favorites_bloc.dart';
import 'package:bruva/data/models/cart_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersItem extends StatelessWidget {
  final   cartItems;

  const MyOrdersItem({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: ListTile(
        leading: Image.network(cartItems["product"]['images'][0]),
        title: Text(cartItems["product"]['name'],style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
        subtitle:
        Text(cartItems["product"]['price'],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
      ),
    );
  }
}
