import 'package:bruva/business_logic/colors/colors_cubit.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets.dart';

class ProductInfo extends StatefulWidget {
  final Product product;

  const ProductInfo({Key? key, required this.product}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo>
    with TickerProviderStateMixin {
  @override
  void initState() {
    context.read<ColorsCubit>().emit(ColorsInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(248, 240, 227, 1),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(248, 240, 227, 1),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.2,
                        child: CarouselSlider.builder(
                          itemCount: widget.product.images.length,
                          itemBuilder: (context, index, realIndex) {
                            return Image.network(
                              widget.product.images[index],
                              fit: BoxFit.fill,
                            );
                          },
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                            scrollDirection: Axis.horizontal,
                            aspectRatio: 16 / 9,
                            initialPage: 2,
                          ),
                        )),
                    Positioned(
                      bottom: 10,
                      right: 5,
                      child: favoritesButtonInfo(widget.product),
                    ),
                    Positioned(
                      top: 0,
                      left: 5,
                      child: backArrow(context),
                    ),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(248, 240, 227, .7),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 18, right: 16),
                                child: Text(
                                  widget.product.name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    letterSpacing: .27,
                                    color: Color(0xFF17262A),
                                  ),
                                ),
                              ),
                              Text(
                                '${widget.product.price}  L.E',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 22,
                                  letterSpacing: .27,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.product.sizes.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      context.read<ColorsCubit>().addCartSize(
                                          widget.product.sizes[index]
                                              .toString());
                                    },
                                    child:
                                        BlocBuilder<ColorsCubit, ColorsState>(
                                      builder: (context, state) {
                                        if (state.sizesList.isNotEmpty) {
                                          return Container(
                                            alignment: Alignment.center,
                                            width: 40,
                                            child: Text(
                                              widget.product.sizes[index]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: widget
                                                          .product.sizes[index]
                                                          .toString() ==
                                                      state.sizesList[0]
                                                  ? []
                                                  : const [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          blurRadius: 2,
                                                          spreadRadius: 2,
                                                          offset:
                                                              Offset(1.1, 1.3))
                                                    ],
                                              color: const Color.fromRGBO(
                                                  249, 241, 241, 1),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            alignment: Alignment.center,
                                            width: 40,
                                            child: Text(
                                              widget.product.sizes[index]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black45,
                                                    blurRadius: 2,
                                                    spreadRadius: 2,
                                                    offset: Offset(1.1, 1.3))
                                              ],
                                              color: Color.fromRGBO(
                                                  249, 241, 241, 1),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ));
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 15,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.product.colors.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      context.read<ColorsCubit>().addCartColor(
                                          widget.product.colors[index]);
                                    },
                                    child:
                                        BlocBuilder<ColorsCubit, ColorsState>(
                                      builder: (context, state) {
                                        if (state.colorsList.isNotEmpty) {
                                          return Container(
                                            width: 40,
                                            // height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: widget.product
                                                          .colors[index] ==
                                                      state.colorsList[0]
                                                  ? []
                                                  : const [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          blurRadius: 2,
                                                          spreadRadius: 3,
                                                          offset:
                                                              Offset(1.1, 1.3))
                                                    ],
                                              color: Color(
                                                  widget.product.colors[index]),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            width: 40,
                                            // height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.black45,
                                                    blurRadius: 2,
                                                    spreadRadius: 3,
                                                    offset: Offset(1.1, 1.3))
                                              ],
                                              color: Color(
                                                  widget.product.colors[index]),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ));
                            },
                          ),
                        ),

                        // TODO  check spaces
                        const Divider(),
                        const Text('Description'),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SizedBox(
                            // height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                widget.product.description,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    letterSpacing: .27,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
          bottomNavigationBar: BlocBuilder<ColorsCubit, ColorsState>(
          builder: (context, state) {
            return cartButton(
                widget.product,
                state.sizesList.first!=''?state.sizesList.first: '',
                state.colorsList.first!=''?state.colorsList.first:0,
                state.colorsList.isNotEmpty && state.sizesList.isNotEmpty);
          },
        ),
      ),
    );
  }
}
