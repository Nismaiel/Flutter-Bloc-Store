import 'package:bruva/business_logic/location/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final TextEditingController _streetName = TextEditingController();
  final TextEditingController _building = TextEditingController();
  final TextEditingController _floor = TextEditingController();
  final TextEditingController _additionalNotes = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      // centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                _formKey.currentState!.validate();
              },
              child: const Text(
                'save',
                style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 17),
              )),
        )
      ],
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
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 2) {
                  return 'Please enter your first name';
                }
                return null;
              },
              controller: _firstName,
              textAlign: TextAlign.left,
              minLines: 1,
              maxLength: 15,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  // errorText: 'First Name should Contain 2-15 characters',
                  labelStyle: TextStyle(color: Colors.black45),
                  labelText: '*First Name'),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 2) {
                  return 'Please enter your last name';
                }
                return null;
              },
              controller: _lastName,
              textAlign: TextAlign.left,
              minLines: 1,
              maxLength: 15,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusColor: Colors.black,
                  // errorText: 'First Name should Contain 2-15 characters',
                  labelStyle: TextStyle(color: Colors.black45),
                  labelText: '*Last Name'),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 11) {
                  return 'Please enter your mobile number';
                }
                return null;
              },
              controller: _phoneNumber,
              textAlign: TextAlign.left,
              maxLength: 11,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusColor: Colors.black,
                  // errorText: 'First Name should Contain 2-15 characters',
                  labelStyle: TextStyle(color: Colors.black45),
                  labelText: '*mobile Number'),
            ),
          ],
        ),
      ),
    );
  }

  Widget address() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter street name';
                }
                return null;
              },
              controller: _streetName,
              textAlign: TextAlign.left,
              minLines: 1,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  // errorText: 'First Name should Contain 2-15 characters',
                  labelStyle: TextStyle(color: Colors.black45),
                  labelText: 'Street Name'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter building number';
                      }
                      return null;
                    },
                    controller: _building,
                    textAlign: TextAlign.left,
                    minLines: 1,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusColor: Colors.black,
                        // errorText: 'First Name should Contain 2-15 characters',
                        labelStyle: TextStyle(color: Colors.black45),
                        labelText: '*Building Number'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter floor number';
                      }
                      return null;
                    },
                    controller: _floor,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusColor: Colors.black,
                        // errorText: 'First Name should Contain 2-15 characters',
                        labelStyle: TextStyle(color: Colors.black45),
                        labelText: '*Floor/Apartment'),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _additionalNotes,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  // errorText: 'First Name should Contain 2-15 characters',
                  labelStyle: TextStyle(color: Colors.black45),
                  labelText: 'Additional notes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<LocationCubit>().getLoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      // backgroundColor: Colors.white60,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                personalInfoForm(),
                PickLocation(),
                address(),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
