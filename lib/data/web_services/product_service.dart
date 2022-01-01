import 'dart:convert';
import 'dart:io';
import 'package:bruva/consts/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:dio/dio.dart';

class ProductService {
  late Dio dio;

  ProductService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: 20 * 1000,
      sendTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }


  Future uploadFile(id,File img)async{

    firebase_storage.Reference ref=  firebase_storage.FirebaseStorage.instance.ref().child('products').child('$id.jpg');
    await ref.putFile(img);
    final downloadUrl=await ref.getDownloadURL();
    return downloadUrl;

  }
  Future<dynamic> addProduct(prod, ) async {
    dio.post(baseUrl, data: json.encode(prod));
  }

  Future getAllProducts() async {
    try {
      Response response = await dio.get(baseUrl);
      return response.data;
    } catch (e) {
      return [];
    }
  }
}
