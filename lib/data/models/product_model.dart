class Product {
  late String id;
  late String name;
  late String description;
  late String price;
  late String beforeDiscount;
  late String category;
  late String subCategory;
  late String gender;
  late List images;
  late List sizes;
  late List colors;
  late String sellerId;

   Product(
      {this.id = '',
      this.name = '',
      this.description = '',
      this.price = '',
      this.beforeDiscount = '',
      this.category = '',
      this.subCategory = '',
      this.gender = '',
      this.images = const [],
      this.sizes = const [],
      this.colors = const [],
      this.sellerId=''});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    images = json['images'];
    sellerId = json['sellerId'];
    beforeDiscount = json['beforeDiscount'];
    category = json['category'];
    subCategory = json['subCategory'];
    gender = json['gender'];
    sizes = json['sizes'];
    colors = json['colors'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'images': images,
        'sellerId': sellerId,
        "colors": colors,
        'beforeDiscount': beforeDiscount,
        'category': category,
        'subCategory': subCategory,
        'gender': gender,
        'sizes': sizes
      };
}
