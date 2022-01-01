import 'package:bruva/business_logic/products/product_bloc.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:bruva/data/repositories/products_repo.dart';
import 'package:bruva/data/web_services/product_service.dart';
import 'package:bruva/presentation/screens/auth/landing.dart';
import 'package:bruva/presentation/screens/cart/cart_screen.dart';
import 'package:bruva/presentation/screens/favorites/favoritest_screen.dart';
import 'package:bruva/presentation/screens/product/add_product.dart';
import 'package:bruva/presentation/screens/product/buy_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';

class AppRouter {
  late ProductsRepo productsRepo;
  List<Product> products = [];

  AppRouter() {
    productsRepo = ProductsRepo(ProductService());
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case register:
      return MaterialPageRoute(builder: (context) => landing(),);

      case addProduct:
        return CupertinoPageRoute(builder: (_) {
          return BlocProvider(
            create: (ctx) => ProductBloc( ProductInitial(),productsRepo),
            child: const AddProduct(),
          );
        });

      case buyProducts:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
              create: (ctx) => ProductBloc( ProductInitial(),productsRepo),
              child: const AllProducts());
        });

      case favoritesPage:
        return CupertinoPageRoute(builder:(_){
         return const FavoritesScreen();

        });
      case cartPage:
        return CupertinoPageRoute(builder:(_){return const CartScreen();});
    }
  }
}
