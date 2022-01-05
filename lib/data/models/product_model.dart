class Product{
  late int id;
  late String name;
  late String description;
  late String price;
  late String image;


  Product.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    description=json['description'];
    price=json['price'];
    image=json['image'];
  }

  Map<String, dynamic> toJson() =>
      {
       'id':id,
        'name':name,
        'description':description,
        'price':price,
        'image':image,
      };

}