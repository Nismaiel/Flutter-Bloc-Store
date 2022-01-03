import 'dart:ui';

import 'package:bruva/business_logic/checkout/checkout_cubit.dart';
import 'package:bruva/business_logic/location/location_cubit.dart';
import 'package:bruva/business_logic/orders/orders_bloc.dart';
import 'package:bruva/presentation/screens/orders/shipping_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderNowScreen extends StatefulWidget {
  const OrderNowScreen({Key? key}) : super(key: key);

  @override
  _OrderNowScreenState createState() => _OrderNowScreenState();
}

class _OrderNowScreenState extends State<OrderNowScreen> {
  final _paymentKey = GlobalKey();
  final _shippingKey = GlobalKey();
  bool triggerPaymentAlert = false;
  int? val = 0;

  Widget confirmationBody(OrdersState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              if (state is AddedShippingData) {
                return shippingInfo(state);
              } else {
                return addShippingInfo();
              }
            },
          ),
          paymentMethod(),
          shoppingBag(state),
          priceRecipt(state),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 5.0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )),
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'checkout',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget addShippingInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => LocationCubit(),
                      ),
                      BlocProvider(
                        create: (context) => CheckoutCubit(),
                      ),
                    ],
                    child: const ShippingAddress(),
                  )));
        },
        child: Container(
          key: _shippingKey,
          height: MediaQuery.of(context).size.height / 5,
          color: Colors.white,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'add shipping info',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Icon(Icons.add),
            ],
          ),
        ),
      ),
    );
  }

  Widget shippingInfo(AddedShippingData state) {
    return Container(
      height: MediaQuery.of(context).size.height / 9,
      color: Colors.white60,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${state.firstName} ${state.lastName}',
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                state.mobileNumber,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Text('${state.building} ${state.streetName}',style: TextStyle(fontSize: 18),),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(' floor number ${state.floor}',style: const TextStyle(fontSize: 18),),
              const SizedBox(width: 15,),
              Text('apartment ${state.apartment}',style: const TextStyle(fontSize: 18),)
            ],
          ),
        ],
      ),
    );
  }

  Widget paymentMethod() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        key: _paymentKey,
        color: Colors.white,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12.0, top: 5),
              child: Text(
                'payment method',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Row(children: [
              Radio<int>(
                  value: 1,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              const Icon(
                Icons.credit_card,
                color: Colors.purple,
              ),
              const Text(
                ' pay with credit card',
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
            ]),
            const Divider(
              color: Colors.black26,
            ),
            Row(
              children: [
                Radio<int>(
                    value: 2,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    }),
                const Icon(
                  Icons.money,
                  color: Colors.green,
                ),
                const Text(
                  ' pay on delivery',
                  style: TextStyle(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const Divider(
              color: Colors.black26,
            ),
            Visibility(
                visible: triggerPaymentAlert,
                child: const Text(
                  'please select a peyment method',
                  style: TextStyle(color: Colors.red),
                )),
          ],
        ),
      ),
    );
  }

  Widget shoppingBag(state) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Shopping Bag',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 7,
              child: ListView.builder(
                itemCount: state.orders.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      state.orders.products[index].image,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget priceRecipt(state) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 8,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Retail Price:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    state.orders.total.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'subtotal Price:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    state.orders.total.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Shipping fee:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '50',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomNavigationBar(OrdersState state) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(1.5, 1.6),
            )
          ],
          border: Border.all(color: Colors.black26)),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text(
                'Total:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Text(
                state.orders.total.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // PaymentService().requestPayment(state.orders.orderId.toString(), state.orders.total);
                //
                //  Navigator.of(context).push(   MaterialPageRoute(
                //      builder: (BuildContext context) => PaypalPayment(
                //        onFinish: (number) async {
                //
                //          // payment done
                //          print('order id: '+number);
                //
                //        },
                //      )));

                final targetContext = _paymentKey.currentContext;
                if (targetContext != null) {
                  Scrollable.ensureVisible(targetContext);
                }
              },
              child: const Text(
                'PLACE ORDER',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  fixedSize: MaterialStateProperty.all(Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height / 20))),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<CheckoutCubit>().getShippingData();

    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoaded) {
          return Scaffold(
            appBar: appBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: confirmationBody(state),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: bottomNavigationBar(state),
            ),
          );
        } else if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
