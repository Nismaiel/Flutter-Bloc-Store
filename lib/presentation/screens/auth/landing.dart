import 'package:bruva/business_logic/auth/auth_bloc.dart';
import 'package:bruva/consts/constants.dart';
import 'package:bruva/presentation/screens/auth/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';

class landing extends StatefulWidget {
  const landing({Key? key}) : super(key: key);

  @override
  _landingState createState() => _landingState();
}

class _landingState extends State<landing> {

  Widget LandingForm() {
    return SingleChildScrollView(

      child: Column(
        children: [
             SizedBox(height: MediaQuery.of(context).size.height/2.5,child: Image.asset("assets/logo_transparent.png")),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.7,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(124, 128, 219, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(
              children: [
                const Text(
                  'Hi There,',
                  style: TextStyle(
                      color: Colors.white,
                      height: 2,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'I,m BRUVA',
                  style: TextStyle(
                      color: Colors.white,
                      height: 2,
                      fontSize: 45,
                      fontWeight: FontWeight.w600),
                ),

                const Text(
                  'your new shopping assistant',
                  style: TextStyle(
                      color: Colors.white70,
                      height: 3,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/12,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push( CupertinoPageRoute(builder: (context) =>const Register(),));
                  },
                  child: const Text(
                    'Hi Bruva',
                    style: TextStyle(color: Color.fromRGBO(124, 128, 219, 1),fontSize: 25),
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width / 1.1, 60)), shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => Login(),));
                }, child:const Text(
                  'already have an account? Signin ',
                  style: TextStyle(
                      color: Colors.white,
                      height: 2.5,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),)
              ],
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
@override
  void initState() {
    // TODO: implement initState

  BlocProvider.of<AuthBloc>(context).add(CheckForLogin());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,
      body: BlocBuilder<AuthBloc,AuthState>(builder: (context, state) {
        if(state is LoggedIn){
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, buyProducts);
          });
          return const Center(child: CircularProgressIndicator(),);
        }else {return LandingForm();}
      },),
    );
  }
}
