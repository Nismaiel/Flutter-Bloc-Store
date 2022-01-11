part of 'colors_cubit.dart';

@immutable
abstract class ColorsState {
  List get colorsList => [];

  List get sizesList => [];

  get selectedGender => '';

  get selectedCategory => '';

  get selectedSubCategory => '';
}

class ColorsInitial extends ColorsState {}

class ColorsAdded extends ColorsState {
  final List colors;
  final List sizes;
  final gender;
  final category;
  final subCategory;

  ColorsAdded(
      {this.colors = const [],
      this.sizes = const [],
      this.gender,
      this.category,
      this.subCategory});

  @override
  // TODO: implement colorsList
  get colorsList => colors;

  @override
  // TODO: implement colorsList
  get sizesList => sizes;

  @override
  // TODO: implement colorsList
  get selectedGender => gender;

  @override
  // TODO: implement colorsList
  get selectedCategory => category;

  @override
  // TODO: implement colorsList
  get selectedSubCategory => subCategory;
}
