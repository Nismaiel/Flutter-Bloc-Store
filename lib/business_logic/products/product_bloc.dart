// ignore: unused_import
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:bruva/data/repositories/products_repo.dart';
import 'package:bruva/data/web_services/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
          emit(ProductsLoaded(products: products));
        } catch (e) {
          emit(ErrorState(message: e.toString()));
        }
      }
      if (event is AddNewProduct) {
        emit(LoadingState());
        try {
          await ProductService().addProduct(
              event.images,
              event.name,
              event.price,
              event.beforeDiscount,
              event.description,
              event.colors,
              event.sizes,
              event.gender,
              event.category,event.subCategory
          );
          emit(ProductInitial());
        } catch (e) {
          debugPrint(e.toString());
        }      }
    });
  }

  addNewProduct(AddNewProduct event) async {

  }
}
