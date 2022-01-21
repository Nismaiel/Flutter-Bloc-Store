import 'dart:async';
import 'dart:convert';

import 'package:bruva/business_logic/favorites/favorites_cubit.dart';
import 'package:bruva/business_logic/favorites/favorites_state.dart';
import 'package:bruva/presentation/screens/product/product_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../widgets.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}


class _FavoritesScreenState extends State<FavoritesScreen> {

@override
  void initState() {

  context.read<FavoritesCubit>().getFavorites();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      BlocBuilder<FavoritesCubit, FavoritesState>(builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red,),
          );
        } else if (state is FavoritesLoaded) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading:backArrow(context),
                backgroundColor: Colors.red,
                expandedHeight: MediaQuery.of(context).size.height / 3,
                centerTitle: true,
                pinned: true,
                floating: false,
                flexibleSpace:const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Favorites'),
                ),
              ),
              SliverFillRemaining(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                            physics:const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.favoritesList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(builder: (ctx)=>ProductInfo(product:state.favorites[index].product,)));
                                },
                                child: Card(
                                  child: Dismissible(

                                    key: ValueKey(state.favoritesList[index].product.id),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      // BlocProvider.of<FavoritesBloc >(context).add(RemoveFromFavorites(product: state.favorites.products[index]));
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      child:const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      alignment: Alignment.centerRight,
                                      padding:const EdgeInsets.only(right: 20),
                                      margin:const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 4,
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: Image.network(state.favoritesList[index].product.images.first),
                                      title: Text(state.favoritesList[index].product.name),
                                      subtitle:
                                      Text(state.favoritesList[index].product.price),
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
