import 'package:bruva/business_logic/auth/auth_bloc.dart';
import 'package:bruva/business_logic/cart/cart_bloc.dart';
import 'package:bruva/business_logic/favorites/favorites_bloc.dart';
import 'package:bruva/business_logic/orders/orders_bloc.dart';
import 'package:bruva/business_logic/products/product_bloc.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:bruva/presentation/screens/auth/landing.dart';
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
    BlocProvider.of<FavoritesBloc>(context);
    BlocProvider.of<CartBloc>(context);
    BlocProvider.of<OrdersBloc>(context);

    bloc = BlocProvider.of<ProductBloc>(context)
      ..add(GetProducts());

    super.initState();
  }

  @override
  void dispose() {
    bloc!.close();
    super.dispose();
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

  Widget buildLoadedListWidget(products) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[


              buildProductGrid(products)

        ],
      ),
    );
  }

  Widget buildProductGrid(List<Product> products) {
    return  GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:  products.length,
        gridDelegate:
     const   SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (ctx, index) {

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (ctx)=>ProductInfo(product: products[index])));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:ProductItem(product: products[index]),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

  leading: IconButton(onPressed: (){
    BlocProvider.of<AuthBloc>(context).add(SignOut());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) =>const landing(),));
    });
  }, icon:const Icon(Icons.logout_outlined)),
        actions: <Widget>[
          Stack(
            children: [

              IconButton(
                  icon:const Icon(
                    Icons.shopping_cart,color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, cartPage);
                  }),
             // BlocBuilder<CartBloc,CartState>(builder:(context, state) {
             //   if( state.cartItems.products.length!=null){
             //    return Text(state.cartItems.products.length.toString());}
             // }, )
            ],
          ),
          IconButton(
              icon:const Icon(
                Icons.favorite,color: Colors.white,
              ),
              onPressed: () {
              Navigator.pushNamed(context, favoritesPage);
              }),
        ],
        title: const Text(
          'Bruva',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: buildBlocWidget(),
    );
  }
}
