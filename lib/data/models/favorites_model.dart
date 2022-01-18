import 'package:bruva/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Favorites {
  late Product product;
  late String favKey;
Favorites({required this.product,this.favKey=''});
  Favorites.fromJson(String key,Map<String,dynamic>json){
    favKey=key;
    product=Product.fromJson(json['product']);
  }
}
