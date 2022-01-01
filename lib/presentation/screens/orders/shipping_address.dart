

import 'package:bruva/business_logic/location/location_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'map.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({Key? key}) : super(key: key);

  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

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
          'Shipping Address',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget personalInfoForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,

        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              textAlign: TextAlign.left,
              minLines: 1, maxLength: 15,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusColor: Colors.black,
                  // errorText: 'First Name should Contain 2-15 characters',
                  labelStyle: TextStyle(color: Colors.black45),
                  labelText: '*First Name'),
            ),
            TextFormField(
              textAlign: TextAlign.left,
              minLines: 1, maxLength: 15,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusColor: Colors.black,
                  // errorText: 'First Name should Contain 2-15 characters',
                  labelStyle: TextStyle(color: Colors.black45),
                  labelText: '*Last Name'),
            ),
            TextFormField(
              textAlign: TextAlign.left,
              maxLength: 11, keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusColor: Colors.black,
                  // errorText: 'First Name should Contain 2-15 characters',
                  labelStyle: TextStyle(color: Colors.black45),
                  labelText: '*Phone Number'),
            ),
          ],
        ),
      ),
    );
  }

@override
  void initState() {
    // TODO: implement initState
  BlocProvider.of<LocationBloc>(context).add(GetLocation());
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      // backgroundColor: Colors.white60,
      body: Column(
        children: [
          personalInfoForm(),
          Padding(padding: EdgeInsets.only(top: 8.0),
            child: ElevatedButton(onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) {return BlocProvider(create: (context) => LocationBloc(),child:const PickLocation(),);},));
            }, child: Text('Pick Location')),),
        ],
      ),
    );
  }
}
