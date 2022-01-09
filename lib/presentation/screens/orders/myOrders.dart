import 'dart:ui';

import 'package:bruva/business_logic/myOrders/my_orders_cubit.dart';
import 'package:bruva/presentation/screens/orders/myOrdersDetails.dart';
import 'package:bruva/presentation/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    context.read<MyOrdersCubit>().getAllOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.black,title:const Text('ordering history'),),
        backgroundColor: Colors.white60,
        body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
          builder: (context, state) {
            if (state is MyOrdersLoaded) {
              return state.myOrders.isEmpty
                  ? const Center(
                child: Text('you have no orders yet'),
              )
                  : ListView.builder(
                itemCount: state.myOrders.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.black,
                              style: BorderStyle.solid,
                              width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.1,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order ${state.myOrders[index].orderId}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                state.myOrders[index].dateTime,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'quantity ${state.myOrders[index].products
                                      .length}', style: const TextStyle(
                                  fontWeight: FontWeight.w600)),
                              Text(
                                'total amount: ${state.myOrders[index]
                                    .total}', style: const TextStyle(
                                  fontWeight: FontWeight.w600),),
                            ],
                          ),
                          OutlinedButton(onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) =>
                                  MyOrdersDetails(
                                    products: state.myOrders[index].products,
                                    total: state.myOrders[index].total,orderId:state.myOrders[index].orderId,date: state.myOrders[index].dateTime ,),));
                          },
                            child: const Text('Details', style: TextStyle(
                                color: Colors.black, fontSize: 18),),
                           )

                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return loading();
            }
          },
        ));
  }
}
