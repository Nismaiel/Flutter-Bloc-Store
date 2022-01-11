import 'package:bruva/business_logic/colors/colors_cubit.dart';
import 'package:bruva/business_logic/myOrders/my_orders_cubit.dart';
import 'package:bruva/business_logic/products/product_bloc.dart';
import 'package:bruva/data/repositories/products_repo.dart';
import 'package:bruva/data/web_services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'business_logic/Order/checkout_cubit.dart';
import 'business_logic/auth/auth_bloc.dart';
import 'business_logic/cart/cart_bloc.dart';
import 'business_logic/favorites/favorites_bloc.dart';
import 'business_logic/checkout/checkOut_bloc.dart';
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
  Widget build(BuildContext context) {
    ProductsRepo productsRepo=ProductsRepo(ProductService());
    return MultiBlocProvider(
      providers:[
        BlocProvider(create:(ctx)=>CartBloc()..add(StartCart())),
        BlocProvider(create:(ctx)=>FavoritesBloc()..add(StartFavorites())),
        BlocProvider(create: (context)=>CheckOutBloc()..add(StartOrders())),
        BlocProvider(create: (context)=>AuthBloc()),
        BlocProvider(create: (context)=>ProductBloc(ProductInitial(),productsRepo)),
        BlocProvider(create: (context)=>checkoutCubit()),
        BlocProvider(create: (context)=>MyOrdersCubit()),
        BlocProvider(create: (context)=>ColorsCubit()),


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
