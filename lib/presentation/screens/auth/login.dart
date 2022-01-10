import 'package:bruva/business_logic/auth/auth_bloc.dart';
import 'package:bruva/consts/constants.dart';
import 'package:bruva/presentation/screens/auth/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Widget registerUi(state) {
    if (state is AuthError) {
      return SimpleDialog(
        title: Text('oops'),
        children: [
          const Text('we seem to have a problem'),
          TextButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).emit(AuthInitial());
              },
              child: const Text('ok'))
        ],
      );
    }
    return ListView(

      children: [
        const Padding(
          padding: EdgeInsets.all(28.0),
          child: Text(
            'Welcome Back',
            style: TextStyle(
                color: Colors.white,
                height: 2,
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 1.1,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1.1, 1.2),
                            color: Color.fromRGBO(124, 128, 219, 1),
                            blurRadius: 2,
                            spreadRadius: 3)
                      ]),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'example.example.com',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromRGBO(124, 128, 219, 1),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Color.fromRGBO(124, 128, 219, 1)),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)))),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: '******',
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)))),
                        controller: _password,
                        keyboardType: TextInputType.streetAddress,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.black54, fontSize: 17),
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(StartLogin(_emailController.text, _password.text));
                  },
                  child: state is AuthLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width / 1.1, 60)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(124, 128, 219, 1))),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: state is AuthLoading
                        ? () {}
                        : () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(LoginWithGoogle());
                          },
                    child: Text(
                      'login with Google',
                      style: TextStyle(
                          color: state is AuthLoading
                              ? Colors.black54
                              : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )),
                TextButton(onPressed: (){
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => Register(),));
                }, child:const Text(
                  'are you new here? Register ',
                  style: TextStyle(
                      color: Colors.purple,
                      height: 2.5,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),)
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(124, 128, 219, 1),
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is LoggedIn) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, buyProducts);
          });
          return loading();
        } else {
          return registerUi(state);
        }
      }),
    );
  }
}
