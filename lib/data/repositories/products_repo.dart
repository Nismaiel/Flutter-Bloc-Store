

import 'package:bruva/data/models/product_model.dart';
import 'package:bruva/data/web_services/product_service.dart';

class ProductsRepo{
final ProductService productService;
ProductsRepo(this.productService);

Future<dynamic> addProduct()async{
 productService.addProduct;
return[];
}
Future<List<Product>> getAllProducts()async{
List<Product> products=[];
 try{
   final  response=await productService.getAllProducts();
  response.forEach((key, value) {products.add(Product.fromJson(value));});
   return products;

 }catch(e){
   return[];
 }
}


}