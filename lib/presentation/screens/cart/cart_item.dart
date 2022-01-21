import 'package:bruva/business_logic/cart/cart_cubit.dart';
import 'package:bruva/data/models/cart_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
final CartItems cartItems;
const CartItem({Key? key,required this.cartItems}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(

        key: ValueKey(cartItems.id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context.read<CartCubit>().removeFromCart(cartItems.id);

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
          leading: Image.network(cartItems.product["images"][0]),
          title: Text(cartItems.product["name"]),
          subtitle:
          Text(cartItems.product["price"]),
          trailing: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('size:${cartItems.size}'),
              CircleAvatar(maxRadius: 15,backgroundColor: Color(cartItems.color),)
            ],
          ),

        ),
      ),
    );
  }
}
