import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bruva/data/models/favorites_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'favorites_state.dart';
import 'package:http/http.dart'as http;
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final String favoritesUrl =
      'https://test-33476-default-rtdb.firebaseio.com/favorites.json';

  getFavorites() async {
    emit(FavoritesLoading());
    try {
     var res=await http.get(Uri.parse(favoritesUrl));
     final decodedBody = json.decode(res.body);
     List<Favorites> items = [];
     decodedBody.forEach((key,value){
       items.add(Favorites.fromJson(key, value));
     });
      emit(FavoritesLoaded(favorites: items));
    } catch (e) {
     print(e.toString());
    }
  }

  addToFavorites(Product product, state,String key) async {
    try {

      Map fav={
        'product':product,
      'userId':FirebaseAuth.instance.currentUser!.uid
      };
      await http.post(Uri.parse(favoritesUrl),body: json.encode(fav));

      emit(FavoritesLoaded(favorites: List.from(state.favorites)..add(Favorites(product: product,favKey: key))));
    } catch (e) {
     print(e.toString());
    }
  }

  removeFromFavorites(
       FavoritesState state,String favKey,Product prod) async {
      try {
        await FirebaseDatabase.instance
            .ref('favorites/$favKey').remove();
        emit(FavoritesLoaded(
            favorites:List.from(state.favoritesList)..remove(Favorites(product: prod,favKey: favKey))));
      } catch (e) {
       print(e.toString());
      }

  }
}


