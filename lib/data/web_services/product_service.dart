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

  Future<dynamic> addProduct(
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
    String prodId = Uuid().v4();

    final imageUrlList = await uploadFile(prodId, images);

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

  Future uploadFile(String prodId, List<File> images) async {
    List<String> downloadUrls = [];
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products')
        .child('${DateTime.now().microsecondsSinceEpoch.toString()}.jpg');
    for (var element in images) {
      await ref.putFile(element);
      final tempDownloadUrl = await ref.getDownloadURL();
      downloadUrls.add(tempDownloadUrl);
    }
    return downloadUrls;
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
