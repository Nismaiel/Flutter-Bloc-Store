part of 'colors_cubit.dart';

@immutable
abstract class ColorsState {
   get selectedColor => 0;
   get selectedSize => '';
  List<File> get imagesList => <File>[];

  get selectedGender => '';

  get selectedCategory => '';

  get selectedSubCategory => '';
}

class ColorsInitial extends ColorsState {}

class ColorsAdded extends ColorsState {
  final  color;
  final  sizes;
  final List<File> images;
  final gender;
  final category;
  final subCategory;

  ColorsAdded(
      {this.color = 0,
      this.sizes = '',
        this.images=const<File>[],
      this.gender,
      this.category,
      this.subCategory});

  @override
  // TODO: implement colorsList
  get selectedColor => this.color;

  @override
  // TODO: implement colorsList
  get selectedSize => sizes;
  @override
  // TODO: implement colorsList
  get imagesList => images;

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
