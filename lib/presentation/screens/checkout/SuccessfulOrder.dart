import 'package:bruva/consts/constants.dart';
import 'package:bruva/presentation/screens/product/buy_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessfulOrder extends StatefulWidget {
  final String orderNumber;
  final String userName;

  const SuccessfulOrder(
      {required this.userName, required this.orderNumber, Key? key})
      : super(key: key);

  @override
  _SuccessfulOrderState createState() => _SuccessfulOrderState();
}

class _SuccessfulOrderState extends State<SuccessfulOrder>
    with TickerProviderStateMixin {
  late AnimationController scaleController = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);
  late Animation<double> scaleAnimation =
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(
      duration: const Duration(milliseconds: 400), vsync: this);
  late Animation<double> checkAnimation =
      CurvedAnimation(parent: checkController, curve: Curves.linear);

  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  double circleSize = 140;
  double iconSize = 108;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                alignment: Alignment.center,
                scale: scaleAnimation,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: circleSize,
                  width: circleSize,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: SizeTransition(
                      sizeFactor: checkAnimation,
                      axis: Axis.horizontal,
                      axisAlignment: -1,
                      child: Icon(Icons.check,
                          color: Colors.lightBlueAccent, size: iconSize)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Hey ${widget.userName.toString()},',
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 22),
          ),
          const Text(
            'your order is confirmed',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 27),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'we will contact you as soon as your order is ready to go',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 19),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'your order id is "${widget.orderNumber}",',
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(buyProducts, (Route<dynamic> route) => false);            },
            child: const Text(
              'continue shopping',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w400),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width / 1.3, 40)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),side: const BorderSide(style: BorderStyle.solid,color: Colors.white)))),
          )
        ],
      ),
    );
  }
}
