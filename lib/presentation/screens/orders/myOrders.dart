import 'package:bruva/business_logic/myOrders/my_orders_cubit.dart';
import 'package:bruva/presentation/widgets.dart';
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
    return Scaffold(
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
                            color: Colors.black26,
                            padding: const EdgeInsets.all(8.0),
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: MediaQuery.of(context).size.height / 5,
                            child: Column(
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
                                        'quantity ${state.myOrders[index].products.length}'),
                                    Text(
                                        'total amount: ${state.myOrders[index].total}'),
                                  ],
                                ),
                              OutlinedButton(onPressed: (){}, child: Text('Details'))
                                
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
