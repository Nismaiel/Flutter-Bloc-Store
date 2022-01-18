import 'package:flutter/material.dart';

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
