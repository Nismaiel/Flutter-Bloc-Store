import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;

import 'package:bruva/consts/constants.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ProductService {
  late Dio dio;

  ProductService() {
    BaseOptions options = BaseOptions(
      baseUrl: productUrl,
      receiveTimeout: 20 * 1000,
      sendTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future addProduct(
      List<File> images,
      String name,
      String price,
      String beforeDiscount,
      String description,
      List colors,
      List sizes,
      String gender,
      String category,
      String subCategory) async {
    String prodId =const Uuid().v4();

     List imageUrlList=[] ;

    imageUrlList=await Future.wait(images.map((image) => uploadFile( image)));
for (int i=0;i<images.length;i++){}
    Map<String, dynamic> prod = {
      'id': prodId,
      'name': name,
      'price': price,
      'beforeDiscount': beforeDiscount,
      'description': description,
      'images': imageUrlList,
      'colors': colors,
      'sizes': sizes,
      'gender': gender,
      'category': category,
      'subCategory': subCategory,
      'sellerId': FirebaseAuth.instance.currentUser!.uid
    };
    String url =
        'https://test-33476-default-rtdb.firebaseio.com/products.json';
    http.post(Uri.parse(url),body: json.encode(prod));
  }

  Future <String> uploadFile(File image) async {

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products')
        .child('${DateTime.now().microsecondsSinceEpoch}.jpg');
     return  ref.putFile(image).then((p0) =>ref.getDownloadURL());


  }

  Future getAllProducts() async {
    try {
      var response = await dio.get(productUrl);
      return response.data;
    } catch (e) {
      print(e);

      return [];
    }
  }
}
