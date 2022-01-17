import 'dart:io' as io;

import 'package:bruva/business_logic/colors/colors_cubit.dart';
import 'package:bruva/business_logic/products/product_bloc.dart';
import 'package:bruva/consts/constants.dart';
import 'package:bruva/data/web_services/product_service.dart';
import 'package:bruva/presentation/widgets.dart';
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
final TextEditingController _beforeDiscount = TextEditingController();
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
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: BlocBuilder<ColorsCubit, ColorsState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () async {
                                image = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                context
                                    .read<ColorsCubit>()
                                    .addImage(io.File(image!.path));
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  height:
                                      MediaQuery.of(context).size.height / 12,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white60,
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  child: const Icon(Icons.add))),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 7,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.imagesList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white60,
                                            border: Border.all(
                                                color: Colors.black, width: 2)),
                                        child: Image.file(
                                            state.imagesList[index])),
                                    Positioned(
                                        right: 0,
                                        child: IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ColorsCubit>()
                                                  .deleteImage(index);
                                            },
                                            icon: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.red,
                                            ))),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
        formElements(),
        colorPickingList(),
        genderRadio(),
        categoriesRadio(),
        subCategoryDrop(),
        sizeCheckBoxes(),
        BlocBuilder<ColorsCubit, ColorsState>(
          builder: (context, state) {
            return TextButton.icon(
                onPressed: () async {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate() &&
                      state.imagesList.isNotEmpty &&
                      state.selectedSubCategory != null &&
                      state.selectedCategory != null &&
                      state.selectedGender != null &&
                      state.selectedSize.isNotEmpty &&
                      state.selectedColor.isNotEmpty &&
                      int.parse(_beforeDiscount.text) >
                          int.parse(_priceController.text)) {
                    BlocProvider.of<ProductBloc>(context).add(AddNewProduct(
                        state.imagesList,
                        _nameController.text,
                        _priceController.text,
                        _beforeDiscount.text,
                        _descriptionController.text,
                        state.selectedColor,
                        state.selectedSize,
                        state.selectedGender,
                        state.selectedCategory,
                        state.selectedSubCategory));
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add product',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ));
          },
        ),
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
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 2) {
                  return 'Please enter product name';
                }
                return null;
              }),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'price',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextFormField(
                    controller: _beforeDiscount,
                    style: const TextStyle(color: Colors.green),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'before discount',
                      hintStyle: TextStyle(color: Colors.green),
                    ),
                    cursorColor: Colors.green,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 2) {
                        return 'Please enter product  Price before discount';
                      }
                      return null;
                    }),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextFormField(
                    controller: _priceController,
                    style: const TextStyle(color: Colors.green),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Price',
                      hintStyle: TextStyle(color: Colors.green),
                    ),
                    cursorColor: Colors.green,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 2) {
                        return 'Please enter product price';
                      }
                      return null;
                    }),
              ),
            ],
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
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 2) {
                  return 'Please enter brief product description';
                }
                return null;
              }),
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
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.selectedColor.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              onDoubleTap: () {
                                context.read<ColorsCubit>().removeColor(index);
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(state.selectedColor[index]),
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

  Widget genderRadio() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.1,
      height: MediaQuery.of(context).size.height / 15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genders.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return BlocBuilder<ColorsCubit, ColorsState>(
            builder: (context, state) {
              return Row(
                children: [
                  Text(genders[index]),
                  Radio<String>(
                      value: genders[index],
                      groupValue: state.selectedGender,
                      onChanged: (val) {
                        context
                            .read<ColorsCubit>()
                            .addGender(genders[index].toString());
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
      width: MediaQuery.of(context).size.width / 1.1,
      height: MediaQuery.of(context).size.height / 15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return BlocBuilder<ColorsCubit, ColorsState>(
            builder: (context, state) {
              return Row(
                children: [
                  Text(categories[index]),
                  Radio<String>(
                      value: categories[index].toString(),
                      groupValue: state.selectedCategory,
                      onChanged: (val) {
                        context
                            .read<ColorsCubit>()
                            .addCategory(categories[index].toString());
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
    return BlocBuilder<ColorsCubit, ColorsState>(
      builder: (context, state) {
        if (categories.contains(state.selectedCategory)) {
          var subCat = allCategories[categories.indexWhere(
              (element) => element.toString() == state.selectedCategory)];
          return Container(padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black,width: 2)),
            child: DropdownButton(elevation: 12,
                dropdownColor: Colors.white,
                iconEnabledColor: Colors.black,
                style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                iconSize: 30,
                value: subCat.contains(state.selectedSubCategory)
                    ? state.selectedSubCategory
                    : subCat[0],
                icon: const Icon(Icons.keyboard_arrow_down),
                items: subCat
                    .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                          enabled: true,
                          child: Text(
                            e,
                            style: const TextStyle(color: Colors.black),
                          ),
                          value: e.toString(),
                        ))
                    .toList(),
                onChanged: (val) {
                  context.read<ColorsCubit>().addSubCategory(val);
                }),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget sizeCheckBoxes() {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 15,
        width: MediaQuery.of(context).size.width / 1.1,
        child: BlocBuilder<ColorsCubit, ColorsState>(
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount:
                  state.selectedCategory == 'footWear' ? 14 : sizes.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(
                      state.selectedCategory == 'footWear'
                          ? (35 + index).toString()
                          : sizes[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    state.selectedCategory == 'footWear'
                        ? Checkbox(
                            value: state.selectedSize.contains(35 + index),
                            onChanged: (bool? val) {
                              state.selectedSize.contains(35 + index)
                                  ? context
                                      .read<ColorsCubit>()
                                      .removeSize(35+index)
                                  : context
                                      .read<ColorsCubit>()
                                      .addSize(35+index);
                            })
                        : Checkbox(
                            value: state.selectedSize.contains(sizes[index]),
                            onChanged: (bool? val) {
                              state.selectedSize.contains(sizes[index])
                                  ? context
                                      .read<ColorsCubit>()
                                      .removeSize(sizes[index])
                                  : context
                                      .read<ColorsCubit>()
                                      .addSize(sizes[index]);
                            }),
                  ],
                );
              },
            );
          },
        ));
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
      body: BlocBuilder<ProductBloc,ProductState>(builder: (context, state) {
        if(state is LoadingState){
          return loading();
        }else{return screenStructure();}
      },),
    );
  }
}
