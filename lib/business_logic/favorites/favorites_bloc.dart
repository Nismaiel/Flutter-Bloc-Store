import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bruva/data/models/favorites_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is StartFavorites) {
      _mapStartFavorites();
      } else if (event is AddToFavorites) {
       _mapAddToFavorites(event, state);
      } else if (event is RemoveFromFavorites) {
        _mapRemoveFromFavorites(event, state);
      }
    });
  }

   _mapStartFavorites() async {
    emit(FavoritesLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(FavoritesLoaded());
    } catch (e) {
      FavoritesError(message: e.toString());
    }
  }

  _mapAddToFavorites(AddToFavorites event, FavoritesState state) async {
    try {
      emit(FavoritesLoaded(
          favorites: Favorites(
              products: List.from(state.favorites.products)
                ..add(event.product))));
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  _mapRemoveFromFavorites(
      RemoveFromFavorites event, FavoritesState state) async {
    if (state is FavoritesLoaded) {
      try {
        emit(FavoritesLoaded(
            favorites: Favorites(
                products: List.from(state.favorites.products)
                  ..remove(event.product))));
      } catch (e) {
        emit(FavoritesError(message: e.toString()));
      }
    }
  }
}
