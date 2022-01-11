import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'colors_state.dart';

class ColorsCubit extends Cubit<ColorsState> {
  ColorsCubit() : super(ColorsInitial());
  addColor(color)async{
    try{
      emit(ColorsAdded(colors: List.from(state.colorsList)..add(color),sizes: List.from(state.sizesList),
          subCategory: state.selectedSubCategory,gender: state.selectedGender,
          category: state.selectedCategory));
    }catch(e){debugPrint(e.toString());}
  }
  removeColor(int index)async{
    try{
      emit(ColorsAdded(colors: List.from(state.colorsList)..removeAt(index),sizes: List.from(state.sizesList),subCategory: state.selectedSubCategory,gender: state.selectedGender,
          category: state.selectedCategory));
    }catch(e){debugPrint(e.toString());}
  }
  addSize(size)async{
    try{
      emit(ColorsAdded(sizes: List.from(state.sizesList)..add(size),colors: List.from(state.colorsList),subCategory: state.selectedSubCategory,gender: state.selectedGender,
          category: state.selectedCategory));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  removeSize(size)async{
    try{
      emit(ColorsAdded(sizes: List.from(state.sizesList)..removeWhere((element) => element==size),colors: List.from(state.colorsList),subCategory: state.selectedSubCategory,gender: state.selectedGender,
          category: state.selectedCategory));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addGender(gender)async{
    try{
      emit(ColorsAdded(gender: gender,category: state.selectedCategory,sizes: List.from(state.sizesList),colors: List.from(state.colorsList)));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addCategory(String category)async{
    try{
      emit(ColorsAdded(category: category,gender: state.selectedGender,sizes: List.from(state.sizesList),colors: List.from(state.colorsList)));
    }catch(e){
      debugPrint(e.toString());
    }
  }
  addSubCategory(subCategory)async{
    try{
      emit(ColorsAdded(subCategory: subCategory,category: state.selectedCategory,gender: state.selectedGender,sizes: List.from(state.sizesList),colors: List.from(state.colorsList)));
    }catch(e){
      debugPrint(e.toString());
    }
  }

}
