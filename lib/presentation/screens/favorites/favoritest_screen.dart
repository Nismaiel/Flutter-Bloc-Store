import 'package:bruva/business_logic/favorites/favorites_bloc.dart';
import 'package:bruva/presentation/screens/product/product_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

Bloc? bloc;

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      BlocBuilder<FavoritesBloc, FavoritesState>(builder: (context, state) {
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
                            itemCount: state.favorites.products.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(builder: (ctx)=>ProductInfo(product:state.favorites.products[index],)));
                                },
                                child: Card(
                                  child: Dismissible(

                                    key: ValueKey(state.favorites.products[index].id),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      BlocProvider.of<FavoritesBloc >(context).add(RemoveFromFavorites(product: state.favorites.products[index]));
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
                                      leading: Image.network(state.favorites.products[index].image),
                                      title: Text(state.favorites.products[index].name),
                                      subtitle:
                                      Text(state.favorites.products[index].price),
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
