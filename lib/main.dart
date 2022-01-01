import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'business_logic/auth/auth_bloc.dart';
import 'business_logic/cart/cart_bloc.dart';
import 'business_logic/favorites/favorites_bloc.dart';
import 'business_logic/orders/orders_bloc.dart';
import 'consts/app_route.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider(create: (context)=>AuthBloc()..add(CheckForLogin()));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create:(ctx)=>CartBloc()..add(StartCart())),
        BlocProvider(create:(ctx)=>FavoritesBloc()..add(StartFavorites())),
        BlocProvider(create: (context)=>OrdersBloc()..add(StartOrders())),
        BlocProvider(create: (context)=>AuthBloc()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        onGenerateRoute: widget.appRouter.generateRoute,
        // home: Register(),
      ),
    );
  }
}
