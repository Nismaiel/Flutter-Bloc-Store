import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'colors_state.dart';

class ColorsCubit extends Cubit<ColorsState> {
  ColorsCubit() : super(ColorsInitial());
  addColor(color){
    try{
      emit(ColorsAdded(colors: List.from(state.colorsList)..add(color),sizes: List.from(state.sizesList),
          subCategory: state.selectedSubCategory,gender: state.selectedGender,images: state.imagesList,
          category: state.selectedCategory));
    }catch(e){debugPrint(e.toString());}
  }
  removeColor(int index){
    try{
      emit(ColorsAdded(colors: List.from(state.colorsList)..removeAt(index),sizes: List.from(state.sizesList),subCategory: state.selectedSubCategory,gender: state.selectedGender,
          category: state.selectedCategory,images: state.imagesList));
    }catch(e){debugPrint(e.toString());}
  }
  addSize(size){
    try{
      emit(ColorsAdded(sizes: List.from(state.sizesList)..add(size),colors: List.from(state.colorsList),subCategory: state.selectedSubCategory,gender: state.selectedGender,
          category: state.selectedCategory,images: state.imagesList));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  removeSize(size){
    try{
      emit(ColorsAdded(sizes: List.from(state.sizesList)..removeWhere((element) => element==size),colors: List.from(state.colorsList),subCategory: state.selectedSubCategory,gender: state.selectedGender,
          category: state.selectedCategory,images: state.imagesList));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addGender(gender){
    try{
      emit(ColorsAdded(gender: gender,category: state.selectedCategory,sizes: List.from(state.sizesList),colors: List.from(state.colorsList),images: state.imagesList,subCategory: state.selectedSubCategory));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addCategory(String category){
    try{
      emit(ColorsAdded(category: category,gender: state.selectedGender,sizes: List.from(state.sizesList),colors: List.from(state.colorsList),subCategory: state.selectedSubCategory,images: state.imagesList));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addSubCategory(subCategory){
    try{
      emit(ColorsAdded(subCategory: subCategory,category: state.selectedCategory,
          gender: state.selectedGender,sizes:[],images: state.imagesList,
          colors: List.from(state.colorsList)));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addImage(File image){
    try {
      emit(ColorsAdded(images: List.from(state.imagesList)..add(image),subCategory: state.selectedSubCategory,category: state.selectedCategory,
          gender: state.selectedGender,sizes: List.from(state.sizesList),
          colors: List.from(state.colorsList)));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  deleteImage(index){
    try{
      emit(ColorsAdded(images: List.from(state.imagesList)..removeAt(index),subCategory: state.selectedSubCategory,category: state.selectedCategory,
          gender: state.selectedGender,sizes: List.from(state.sizesList),
          colors: List.from(state.colorsList)));
    }catch(e){
      debugPrint(e.toString());
    }
  }


}
