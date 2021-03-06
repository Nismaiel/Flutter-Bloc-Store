import 'package:bruva/business_logic/Order/checkout_cubit.dart';
import 'package:bruva/business_logic/cart/cart_cubit.dart';
import 'package:bruva/business_logic/cart/cart_state.dart';
import 'package:bruva/business_logic/checkout/checkOut_bloc.dart';
import 'package:bruva/data/models/cart_model.dart';
import 'package:bruva/presentation/screens/checkout/order_now.dart';
import 'package:bruva/presentation/screens/product/product_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_item.dart';
import 'package:http/http.dart'as http;
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int total=0;
  @override
  void initState() {
    // TODO: implement initState
    context.read<CartCubit>().getCartItems();

    total=context.read<CartCubit>().total;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 240, 227, 1),
      body:


          // ListView.builder(
          //     physics: const NeverScrollableScrollPhysics(),
          //     shrinkWrap: true,
          //     itemCount: state.cartItems.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //               context,
          //               CupertinoPageRoute(
          //                   builder: (context) => ProductInfo(
          //                       product: state.cartItems[index].product)));
          //         },
          //         // child: CartItem(product: state.cartItems[index].product,color: state.cartItems[index].color,size: state.cartItems[index].size,id: state.cartItems[index].id,),
          //       child: CartItem(cartItems: state.cartItems[index]),
          //       );
          //     }),

      BlocBuilder<CartCubit, CartState>(builder: (context, state) {
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
                        label: Text(context.read<CartCubit>().total.toString(),
                          // state.cartItems.total.toString(),
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
                        onPressed: state.cartItems.isEmpty
                            ? () {}
                            : () {
                                BlocProvider.of<CheckOutBloc>(context).add(
                                    AddOrder(
                                        products: state.cartItems,
                                        // cartTotal: state.cartItems.total,
                                        cartTotal: total.toString(),
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
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ProductInfo(
                                    product: state.cartItems[index].product)));
                      },
                      // child: CartItem(product: state.cartItems[index].product,color: state.cartItems[index].color,size: state.cartItems[index].size,id: state.cartItems[index].id,),
                    child: CartItem(cartItems: state.cartItems[index]),
                    );
                  }),
            ],
          );
        }else if(state is CartInitial){
          return const Center(child: Text('your cart is empty!!'),);
        } else{
          return const SizedBox();
        }
      }),
    );
  }
}
