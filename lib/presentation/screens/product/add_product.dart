import 'dart:io'as io;

import 'package:bruva/business_logic/products/product_bloc.dart';
import 'package:bruva/data/web_services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

late ProductService productService;
final TextEditingController _nameController = TextEditingController();
final TextEditingController _priceController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final _formKey = GlobalKey<FormState>();
final ImagePicker imagePicker = ImagePicker();
XFile? image;

Widget screenStructure() {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
    child: scrollElements(),
  );
}

Widget scrollElements() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      formElements(),
      TextButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.camera),
          label: const Text(
            'Pick image',
            style: TextStyle(color: Colors.green, fontSize: 20),
          )),
      TextButton.icon(
          onPressed: uploadProduct,
          icon: const Icon(Icons.add),
          label: const Text(
            'Add product',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ))
    ],
  );
}

Widget formElements() {
  return Form(
    key: _formKey,
    child: Column(
      children: [
        TextFormField(
          controller: _nameController,
          style:const TextStyle(color: Colors.green) ,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'product Name',
            hintStyle: TextStyle(color: Colors.green),
          ),
          cursorColor: Colors.green,
        ),
       const SizedBox(height: 15,),
        TextFormField(
          controller: _priceController,
          style:const TextStyle(color: Colors.green) ,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'product Price',
            hintStyle: TextStyle(color: Colors.green),
          ),
          cursorColor: Colors.green,
        ),
        const SizedBox(height: 15,),

        TextFormField(

          controller: _descriptionController,
          style:const TextStyle(color: Colors.green) ,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),fillColor: Colors.green,
            hintText: 'description',
            hintStyle: TextStyle(color: Colors.green),
          ),
          cursorColor: Colors.white,
        ),
        const SizedBox(height: 15,),

      ],
    ),
  );
}

pickImage() async {
  image = await imagePicker.pickImage(source: ImageSource.gallery);
}

uploadProduct() async {


 final imageUrl=await productService.uploadFile(DateTime.now().millisecondsSinceEpoch,io.File(image!.path));
  Map<String, dynamic> prod = {
    'id': DateTime.now().millisecondsSinceEpoch,
    'name': _nameController.text,
    'price': _priceController.text,
    'description': _descriptionController.text,
    'image': imageUrl
  };

  await productService.addProduct(prod);
}

class _AddProductState extends State<AddProduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productService = ProductService();
    BlocProvider.of<ProductBloc>(context).addProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 25, 34, 1),
      body: screenStructure(),
    );
  }
}
