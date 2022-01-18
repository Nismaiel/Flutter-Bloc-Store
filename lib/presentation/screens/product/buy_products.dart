import 'package:bruva/business_logic/auth/auth_bloc.dart';
import 'package:bruva/business_logic/cart/cart_cubit.dart';
import 'package:bruva/business_logic/cart/cart_state.dart';
import 'package:bruva/business_logic/checkout/checkOut_bloc.dart';
import 'package:bruva/business_logic/products/product_bloc.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:bruva/presentation/screens/auth/landing.dart';
import 'package:bruva/presentation/screens/orders/myOrders.dart';
import 'package:bruva/presentation/screens/product/add_product.dart';
import 'package:bruva/presentation/screens/product/product_info.dart';
import 'package:bruva/presentation/screens/product/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../consts/constants.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  Bloc? bloc;

  @override
  void initState() {
    BlocProvider.of<CheckOutBloc>(context);

    bloc = BlocProvider.of<ProductBloc>(context)
      ..add(GetProducts());

    super.initState();
  }


  Widget? buildBlocWidget() {
    return BlocBuilder<ProductBloc, ProductState>(builder: (ctx, state) {
      if (state is ProductInitial) {
        return const Center(
            child: CircularProgressIndicator(color: Colors.blue));
      } else if (state is LoadingState) {
        return const Center(
            child: CircularProgressIndicator(color: Colors.green));
      } else if (state is ProductsLoaded) {
        return buildLoadedListWidget(state.products);
      } else if (state is ErrorState) {
        return ErrorWidget(state.message);
      } else {
        return const Center(
            child: CircularProgressIndicator(color: Colors.yellow));
      }
    });
  }

  Widget buildLoadedListWidget(List<Product> products) {
    return SingleChildScrollView(
        child: SizedBox(height: MediaQuery
            .of(context)
            .size
            .height,
          child: buildProductGrid(products),));
  }

  Widget buildProductGrid(List<Product> products) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (ctx) => ProductInfo(product: products[index])));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductItem(product: products[index]),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(248, 240, 227,0.9),

        appBar: AppBar(

        leading: IconButton(onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(SignOut());
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const landing(),));
          });
        }, icon: const Icon(Icons.logout_outlined)),
        actions: <Widget>[
          IconButton(onPressed: () {
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => const MyOrders(),));
          }, icon:const Icon(Icons.history)),
          Stack(
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.shopping_cart, color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, cartPage);
                  }),
              BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                if (state.cartItems != null &&
                    state.cartItems.isNotEmpty) {
                  return Text(state.cartItems.length.toString());
                } else {
                  return const SizedBox();
                }
              },)
            ],
          ),
          IconButton(
              icon: const Icon(
                Icons.favorite, color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, favoritesPage);
              }),
          IconButton(
              icon: const Icon(
                Icons.shop, color: Colors.white,
              ),
              onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AddProduct(),));
              }),
        ],
        title: const Text(
          'BRUVA',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: buildBlocWidget(),
    );
  }
}