import 'package:bruva/business_logic/favorites/favorites_bloc.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersItem extends StatelessWidget {
  final  product;

  const MyOrdersItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: ListTile(
        leading: Image.network(product['image']),
        title: Text(product['name'],style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
        subtitle:
        Text(product['price'],style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
      ),
    );
  }
}
