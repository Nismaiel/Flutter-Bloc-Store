
import 'package:bruva/business_logic/auth/auth_bloc.dart';
import 'package:bruva/consts/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();
  Widget registerUi(state){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Padding(
          padding:  EdgeInsets.all(28.0),
          child:  Text(
            'Welcome Back',
            style: TextStyle(
                color: Colors.white,
                height: 2,
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 1.5,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow( offset: Offset(1.1, 1.2),
                            color: Color.fromRGBO(124, 128, 219, 1),
                            blurRadius: 2,spreadRadius: 3)
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
                                borderSide: BorderSide(style: BorderStyle.solid,
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
                  child: TextButton(onPressed: (){}, child:const Text('Forgot password?',style: TextStyle(color: Colors.black54,fontSize: 17),)),
                ),

                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(StartLogin(_emailController.text,_password.text));
                  },
                  child:state is AuthLoading?const CircularProgressIndicator(color: Colors.white,): const Text(
                    'Login',
                    style: TextStyle(color:Colors.white,fontSize: 20),
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width / 1.1, 60)), shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(const Color.fromRGBO(124, 128, 219, 1))),
                ),
                const SizedBox(height: 30,),

                TextButton(onPressed:state is AuthLoading?(){}: (){BlocProvider.of<AuthBloc>(context).add(LoginWithGoogle());}, child: Text('login with Google',style: TextStyle(color: state is AuthLoading?Colors.black54: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),))



              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget loading(){
    return const Center(child: CircularProgressIndicator(),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const  Color.fromRGBO(124, 128, 219, 1),
      body:BlocBuilder<AuthBloc,AuthState>(builder: (context, state) {
       if (state is LoggedIn){
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, buyProducts);
          });
          return loading();
        }else if(state is AuthError){
          return ErrorWidget(state.message);
        }else {
         print(state);
          return registerUi(state);
        }
      }),
    );
  }
}
