import 'dart:io' as io;

import 'package:bruva/business_logic/colors/colors_cubit.dart';
import 'package:bruva/business_logic/products/product_bloc.dart';
import 'package:bruva/data/web_services/product_service.dart';
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
List sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL', '4XL', '5XL'];
List genders = ['Male', 'Female', 'unisex'];
List categories = [
  'top',
  'bottoms',
  'underWears',
  'footWear',
  'fullBody',
  'accessories',
  'jewelry',
  'bags'
];
List allCategories = [
   top,
   bottoms,
  underWears,
   footWear,
  fullBody,
   accessories,
   jewelry,
   bags
];
List<String> top = [
  'shirt',
  'T-shirt',
  'sweater',
  'jacket',
  'coat',
  'vest',
  'tanktop',
  'blouse',
];
List<String> bottoms = [
  'jeans',
  'shorts',
  'skirt',
];
List<String> underWears = ['panties', 'stockings', 'bra', 'boxers', 'undershirts'];
List<String> footWear = [
  'sneakers',
  'shoes',
  'socks',
  'heels'
];
List<String> fullBody = ['suit', 'tracksuit', 'pajamas', 'swimsuit', 'dress'];
List<String> accessories = [
  'tie',
  'bow-tie',
  'hat',
  'sun hat',
  'Ice cap',
  'cap',
  'scarf',
  'glasses',
  'sunglasses',
  'belt',
  'wallet',
  'watch'
];
List<String> jewelry = ['earrings', 'bracelet', 'ring', 'necklace'];
List<String> bags = ['bagpack', 'handpack', 'purse'];

class _AddProductState extends State<AddProduct> {
  Widget screenStructure() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
      child: scrollElements(),
    );
  }

  Widget scrollElements() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                print(state);
                return SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () async {
                                  image = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  BlocProvider.of<ProductBloc>(context).add(
                                      AddImage(image: io.File(image!.path)));
                                },
                                child: Container(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width / 3,
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height / 7,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white60,
                                        border: Border.all(
                                            color: Colors.black, width: 2)),
                                    child: const Icon(Icons.add))),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.3,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 7,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.imagesList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width /
                                              3,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height /
                                              7,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: Colors.white60,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2)),
                                          child: Image.file(
                                              state.imagesList[index])),
                                      Positioned(
                                          right: 0,
                                          child: IconButton(
                                              onPressed: () {
                                                BlocProvider.of<ProductBloc>(
                                                    context)
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
                      ],
                    ),
                  ),
                );
              },
            )),
        formElements(),
        colorPickingList(),
        sizeCheckBoxes(),
        genderRadio(),
        categoriesRadio(),
        subCategoryDrop(),
        TextButton.icon(
            onPressed: () async {
              await productService.addProduct(
                  io.File(image!.path),
                  _nameController.text,
                  _priceController.text,
                  _descriptionController.text);
            },
            icon: const Icon(Icons.add),
            label: const Text(
              'Add product',
              style: TextStyle(color: Colors.black, fontSize: 20),
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

  Widget colorPickingList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'select available colors',
            style: TextStyle(fontSize: 19, color: Colors.green),
          ),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('select color'),
                          content: MaterialColorPicker(
                            onColorChange: (value) {
                              tempColor = value.value;
                            },
                            shrinkWrap: true,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  try {
                                    context
                                        .read<ColorsCubit>()
                                        .addColor(tempColor!.toInt());
                                    Navigator.pop(context);
                                  } catch (e) {
                                    print(e.toString());
                                  }
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
              BlocBuilder<ColorsCubit, ColorsState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 70,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.1,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.colorsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              onDoubleTap: () {
                                context.read<ColorsCubit>().removeColor(index);
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(state.colorsList[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget sizeCheckBoxes() {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height / 15,
      width: MediaQuery
          .of(context)
          .size
          .width / 1.1,
      child: ListView.builder(
        itemCount: sizes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return BlocBuilder<ColorsCubit, ColorsState>(
            builder: (context, state) {
              return Row(
                children: [
                  Text(
                    sizes[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Checkbox(
                      value: state.sizesList.contains(sizes[index]),
                      onChanged: (bool? val) {
                        state.sizesList.contains(sizes[index])
                            ? context
                            .read<ColorsCubit>()
                            .removeSize(sizes[index])
                            : context.read<ColorsCubit>().addSize(sizes[index]);
                      }),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget genderRadio() {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width / 1.1,
      height: MediaQuery
          .of(context)
          .size
          .height / 15,
      child: ListView.builder(scrollDirection: Axis.horizontal,
        itemCount: genders.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return BlocBuilder<ColorsCubit, ColorsState>(
            builder: (context, state) {
              return Row(
                children: [
                  Text(genders[index]),
                  Radio<String>(value: genders[index],
                      groupValue: state.selectedGender,
                      onChanged: (val) {
                        context.read<ColorsCubit>().addGender(
                            genders[index].toString());
                      })
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget categoriesRadio() {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width / 1.1,
      height: MediaQuery
          .of(context)
          .size
          .height / 15,
      child: ListView.builder(scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return BlocBuilder<ColorsCubit, ColorsState>(
            builder: (context, state) {
              return Row(
                children: [
                  Text(categories[index]),
                  Radio<String>(value: categories[index].toString(),
                      groupValue: state.selectedCategory,
                      onChanged: (val) {
                        context.read<ColorsCubit>().addCategory(
                            categories[index].toString());
                      })
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget subCategoryDrop() {
    return BlocBuilder<ColorsCubit, ColorsState>(builder: (context, state) {
if(categories.contains(state.selectedCategory)){
  var subCat=allCategories[categories.indexWhere((element) => element.toString()==state.selectedCategory)];
  return DropdownButton(value: subCat.contains(state.selectedSubCategory)?state.selectedSubCategory:subCat[0],
      icon: const Icon(Icons.keyboard_arrow_down),
      items:subCat.map<DropdownMenuItem<String>>((e) =>DropdownMenuItem(enabled: true,child: Text(e,style: TextStyle(color: Colors.blue),),value: e.toString(),)).toList(),
      onChanged: (val){
        context.read<ColorsCubit>().addSubCategory(val);
      });
}else{return SizedBox();}
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productService = ProductService();
    BlocProvider.of<ProductBloc>(context);
    BlocProvider.of<ColorsCubit>(context);
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
