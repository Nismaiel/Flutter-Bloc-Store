import 'package:bruva/business_logic/cart/cart_bloc.dart';
import 'package:bruva/business_logic/checkout/checkout_cubit.dart';
import 'package:bruva/business_logic/orders/orders_bloc.dart';
import 'package:bruva/presentation/screens/orders/order_now.dart';
import 'package:bruva/presentation/screens/product/product_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CartLoaded) {
          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Total',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Chip(
                        label: Text(
                          state.cartItems.total.toString(),
                          style: const TextStyle(color: Colors.white70),
                        ),
                        backgroundColor: Colors.black,
                      ),
                      TextButton(
                        child: const Text(
                          'ORDER NOW',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        onPressed: state.cartItems.products.isEmpty
                            ? () {}
                            : () {
                                BlocProvider.of<OrdersBloc>(context).add(
                                    AddOrder(
                                        products: state.cartItems.products,
                                        cartTotal: state.cartItems.total,
                                        orderId: DateTime.now()
                                            .millisecondsSinceEpoch));
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => BlocProvider(
                                            create: (context) => CheckoutCubit(),
                                            child: const OrderNowScreen())));
                              },
                      )
                    ],
                  ),
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.cartItems.products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ProductInfo(
                                    product: state.cartItems.products[index])));
                      },
                      child: CartItem(product: state.cartItems.products[index]),
                    );
                  }),
            ],
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
