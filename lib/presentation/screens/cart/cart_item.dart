import 'package:bruva/business_logic/cart/cart_bloc.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
  final Product product;
final String size;
final int color;
  const CartItem({Key? key, required this.product,required this.size,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(

        key: ValueKey(product.id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          BlocProvider.of<CartBloc >(context).add(RemoveFromCart(product: product));
        },
        background: Container(
          color: Colors.red,
          child:const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding:const EdgeInsets.only(right: 20),
          margin:const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
        ),
        child: ListTile(
          leading: Image.network(product.images.first),
          title: Text(product.name),
          subtitle:
          Text(product.price),
        ),
      ),
    );
  }
}
