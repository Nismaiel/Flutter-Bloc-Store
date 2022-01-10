import 'dart:io' as io;
import 'dart:io';

import 'package:bruva/business_logic/products/product_bloc.dart';
import 'package:bruva/data/web_services/product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
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
int? tempColor;

class _AddProductState extends State<AddProduct> {
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
        imagePickingList(),
        formElements(),
        colorPickingList(),
        TextButton.icon(
            onPressed: uploadProduct,
            icon: const Icon(Icons.add),
            label: const Text(
              'Add product',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ))
      ],
    );
  }

  Widget imagePickingList() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          image = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          BlocProvider.of<ProductBloc>(context)
                              .add(AddImage(image: io.File(image!.path)));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 7,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white60,
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child:const Icon(Icons.add))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: MediaQuery.of(context).size.height / 7,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.imagesList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height:
                                      MediaQuery.of(context).size.height / 7,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white60,
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  child: Image.file(state.imagesList[index])),
                              Positioned(
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        BlocProvider.of<ProductBloc>(context)
                                            .add(DeleteImage(index));
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ))),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget colorPickingList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('select color'),
                      content: MaterialColorPicker(
                        onColorChange: (value) {
                          tempColor = value.value;
                        },
                        shrinkWrap: true,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(AddColor(tempColor!.toInt()));
                              // Navigator.pop(context);
                            },
                            child: const Text('add color'))
                      ],
                    );
                  },
                );
              },
              child: const CircleAvatar(
                child: Icon(Icons.add),
              )),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width / 1.1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return CircleAvatar(child: Text(state.colorsList.length.toString()),
                      // backgroundColor: Color(state.colorsList[index]),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget formElements() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            style: const TextStyle(color: Colors.green),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'product Name',
              hintStyle: TextStyle(color: Colors.green),
            ),
            cursorColor: Colors.green,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: _priceController,
            style: const TextStyle(color: Colors.green),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'product Price',
              hintStyle: TextStyle(color: Colors.green),
            ),
            cursorColor: Colors.green,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: _descriptionController,
            style: const TextStyle(color: Colors.green),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              fillColor: Colors.green,
              hintText: 'description',
              hintStyle: TextStyle(color: Colors.green),
            ),
            cursorColor: Colors.white,
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  uploadProduct() async {
    await productService.addProduct(io.File(image!.path), _nameController.text,
        _priceController.text, _descriptionController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productService = ProductService();
    BlocProvider.of<ProductBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Add product'),
      ),
      backgroundColor: Colors.white,
      body: screenStructure(),
    );
  }
}
