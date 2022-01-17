
import 'package:bruva/data/models/product_model.dart';

class CartItems{
  late Product product;
  late String size;
  late int color;
  late String id;
    CartItems({required this.product,this.size='',this.color=0,this.id=''});

   CartItems.fromJson(Map<String,dynamic>json){
     product=Product.fromJson(json['product']);
     size=json['size'];
     color=json['color'];
     id=json['id'];
   }

  Map<String, dynamic> toJson() =>
  {    'product':product,
    'size':size,
    'color':color,
    'id':id
  };

}