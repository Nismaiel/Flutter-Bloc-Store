import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'colors_state.dart';

class ColorsCubit extends Cubit<ColorsState> {
  ColorsCubit() : super(ColorsInitial());
  addColor(color){
    try{
      emit(ColorsAdded(color: color,sizes: List.from(state.selectedSize),
          subCategory: state.selectedSubCategory,gender: state.selectedGender,images: state.imagesList,
          category: state.selectedCategory));
    }catch(e){debugPrint(e.toString());}
  }
  removeColor(int index){
    try{
      emit(ColorsAdded(color: '',sizes: List.from(state.selectedSize),subCategory: state.selectedSubCategory,gender: state.selectedGender,
          category: state.selectedCategory,images: state.imagesList));
    }catch(e){debugPrint(e.toString());}
  }
  addSize(size){
    try{
      emit(ColorsAdded(sizes: List.from(state.selectedSize)..add(size),color:state.selectedColor,subCategory: state.selectedSubCategory,gender: state.selectedGender,
          category: state.selectedCategory,images: state.imagesList));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  removeSize(size){
    try{
      emit(ColorsAdded(sizes: List.from(state.selectedSize)..removeWhere((element) => element==size),color: state.selectedColor,subCategory: state.selectedSubCategory,gender: state.selectedGender,
          category: state.selectedCategory,images: state.imagesList));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addGender(gender){
    try{
      emit(ColorsAdded(gender: gender,category: state.selectedCategory,sizes: List.from(state.selectedSize),color: state.selectedColor,images: state.imagesList,subCategory: state.selectedSubCategory));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addCategory(String category){
    try{
      emit(ColorsAdded(category: category,gender: state.selectedGender,sizes: List.from(state.selectedSize),color: state.selectedColor,subCategory: state.selectedSubCategory,images: state.imagesList));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addSubCategory(subCategory){
    try{
      emit(ColorsAdded(subCategory: subCategory,category: state.selectedCategory,
          gender: state.selectedGender,sizes:[],images: state.imagesList,
          color: state.selectedColor));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addImage(File image){
    try {
      emit(ColorsAdded(images: List.from(state.imagesList)..add(image),subCategory: state.selectedSubCategory,category: state.selectedCategory,
          gender: state.selectedGender,sizes: state.selectedSize,
          color:state.selectedColor));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  deleteImage(index){
    try{
      emit(ColorsAdded(images: List.from(state.imagesList)..removeAt(index),subCategory: state.selectedSubCategory,category: state.selectedCategory,
          gender: state.selectedGender,sizes: state.selectedSize,
          color:  state.selectedColor));
    }catch(e){
      debugPrint(e.toString());
    }
  }

  addCartColor(int color){
    emit(ColorsAdded(color:color ,sizes: state.selectedSize));
  }
  addCartSize(String size){
    emit(ColorsAdded(sizes:size,color:state.selectedColor ));
  }


}
