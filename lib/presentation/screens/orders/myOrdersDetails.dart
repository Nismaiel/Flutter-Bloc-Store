import 'package:bruva/data/models/cart_model.dart';
import 'package:bruva/presentation/screens/orders/myOrdersItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyOrdersDetails extends StatelessWidget {
  final List<dynamic> products;
  final String total;
  final String orderId;
  final String date;

  const MyOrdersDetails(
      {required this.products,
      required this.total,
      required this.orderId,
      required this.date,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Order id:$orderId'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Total: $total',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                    Text(DateFormat.yMMMd().format(DateTime.parse(date)),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return MyOrdersItem(cartItems:  products[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
