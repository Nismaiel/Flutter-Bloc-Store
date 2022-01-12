import 'package:bruva/business_logic/Order/checkout_cubit.dart';
import 'package:bruva/business_logic/cart/cart_bloc.dart';
import 'package:bruva/business_logic/checkout/checkOut_bloc.dart';
import 'package:bruva/presentation/screens/checkout/order_now.dart';
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
      backgroundColor: Color.fromRGBO(248, 240, 227, 1),
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
                                BlocProvider.of<CheckOutBloc>(context).add(
                                    AddOrder(
                                        products: state.cartItems.products,
                                        cartTotal: state.cartItems.total,
                                        orderId: DateTime.now()
                                            .millisecondsSinceEpoch));
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => BlocProvider(
                                            create: (context) => checkoutCubit(),
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
                      child: CartItem(product: state.cartItems.products[index],color: state.cartItems.colors[index],size: state.cartItems.sizes[index],),
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
