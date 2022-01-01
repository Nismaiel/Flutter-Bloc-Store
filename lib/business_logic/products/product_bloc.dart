// ignore: unused_import
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:bruva/data/repositories/products_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductsRepo productsRepo;

  ProductBloc(ProductState productState, this.productsRepo)
      : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {

      if (event is GetProducts) {
        emit(LoadingState());
        try {
          var products = await productsRepo.getAllProducts();
          print(products);
          emit(ProductsLoaded(products: products));
        } catch (e) {
          print(e.toString());
          emit(ErrorState(message: e.toString()));
        }
      }
    });
  }

  addProduct(){
    productsRepo.addProduct();
    return[];
  }

}
