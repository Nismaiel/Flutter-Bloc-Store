import 'package:bruva/business_logic/favorites/favorites_bloc.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bruva/business_logic/cart/cart_cubit.dart';
import 'package:bruva/business_logic/cart/cart_state.dart';


Widget favoritesButtonInfo(Product product) {
  return BlocBuilder<FavoritesBloc, FavoritesState>(builder: (context, state) {
    return GestureDetector(
      onTap: (){
       state.favorites.products.contains(product) ?
        BlocProvider.of<FavoritesBloc>(context).add(RemoveFromFavorites(product: product)):
        BlocProvider.of<FavoritesBloc>(context).add(AddToFavorites(product: product));

      },
      child: Card(
        color: state.favorites.products.contains(product)
            ? const Color(0xFFFFFFFF)
            : Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 10.0,
        child: SizedBox(
          width: 60,
          height: 60,
          child: Center(
            child: Icon(
              Icons.favorite,
              color: state.favorites.products.contains(product)
                  ? Colors.red
                  : const Color(0xFFFFFFFF),
              size: 30,
            ),
          ),
        ),
      ),
    );
  });
}

Widget favoritesButton(Product product) {
  return BlocBuilder<FavoritesBloc, FavoritesState>(
    builder: (context, state) {
      if (state.favorites!.products != null &&
          state.favorites.products.contains(product)) {
        return IconButton(
          onPressed: () {
            BlocProvider.of<FavoritesBloc>(context)
                .add(RemoveFromFavorites(product: product));
          },
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          splashRadius: .3,
        );
      } else {
        return IconButton(
          onPressed: () {
            BlocProvider.of<FavoritesBloc>(context)
                .add(AddToFavorites(product: product));
          },
          icon: const Icon(
            Icons.favorite_outline,
            color: Colors.red,
          ),
          splashRadius: .3,
        );
      }
    },
  );
}

Widget cartButton(Product product,String size,int color,bool enabled) {
  return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextButton(
              onPressed:!state.cartItems.products.contains(product)&&!enabled?(){}: () {
                state.cartItems.products.contains(product)
                    ? context.read<CartCubit>().removeFromCart(state.cartItems.id)
                    :context.read<CartCubit>().addToCart( size, color, product);
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                decoration: BoxDecoration(
                  color: state.cartItems.products.contains(product)
                      ?Colors.white: Colors.black,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(.5),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child:  Center(
                  child: Text(
                    state.cartItems.products.contains(product)
                        ?'Remove from cart': 'Add to cart',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      letterSpacing: 0.0,
                      color: state.cartItems.products.contains(product)
                          ?Colors.black:const Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}

Widget backArrow(context) {
  return Padding(
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    child: SizedBox(
      width: AppBar().preferredSize.height,
      height: AppBar().preferredSize.height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    ),
  );
}

Widget loading(){
  return const Center(child: CircularProgressIndicator(),);
}