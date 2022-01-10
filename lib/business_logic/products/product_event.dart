part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  @override
  List<Object>get props=>[];
}
class GetProducts extends ProductEvent{}
class AddImage extends ProductEvent{
  final  image;
  AddImage({required this.image});
}
class AddColor extends ProductEvent{
  final int colorVal;
  AddColor(this.colorVal);
}


class DeleteImage extends ProductEvent{
  final int index;
  DeleteImage(this.index);
}

class DeleteColor extends ProductEvent{
  final int index;
  DeleteColor(this.index);
}