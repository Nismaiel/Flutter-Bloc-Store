// ignore: unused_import
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:bruva/data/repositories/products_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
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
      }else if(event is AddImage){
        addImage(event, state);
      }else if(event is DeleteImage){
        deleteImage(event, state);
      }
    });
  }


addImage(AddImage event,ProductState state){
  try {
    emit(ImagesAdded(images: List.from(state.imagesList)..add(event.image)));
  } catch (e) {
    emit(ErrorState(message: e.toString()));
  }
}

deleteImage(DeleteImage event,ProductState state){
  try{
    emit(ImagesAdded(images: List.from(state.imagesList)..removeAt(event.index)));
  }catch(e){
    emit(ErrorState(message: e.toString()));
  }
}



  addProduct() {
    productsRepo.addProduct();
    return [];
  }
}
