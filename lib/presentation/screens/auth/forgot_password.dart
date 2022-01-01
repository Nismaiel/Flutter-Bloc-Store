import 'dart:ui';

import 'package:bruva/business_logic/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(builder: (context, state) {
      if(state is AuthLoading){
        return const Center(child:CircularProgressIndicator());
      }else if(state is ResetCodeSent){
        return const Center(child:CircularProgressIndicator());
      }else{return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email), hintText: 'example@example.com'),
                controller: _emailController,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            TextButton(onPressed: (){
            BlocProvider.of<AuthBloc>(context).add(ResetPassword(_emailController.text));
            }, child:const Text('send reset code',style: TextStyle(color: Colors.green),))
          ],
        ),
      );}
    },);
  }
}
