import 'package:bruva/data/models/product_model.dart';

class CartItems{
  late List<Product>products;
  late double total;
  late List<String> sizes;
  late List<int> colors;
  late String id;
    CartItems({this.products=const<Product>[], this.total= 0,this.sizes=const[],this.colors=const[],this.id=''});

   CartItems.fromJson(Map<String,dynamic>json){
     products=json['products'];
     total=json['total'];
     sizes=json['sizes'];
     colors=json['colors'];
     id=json['id'];
   }

}