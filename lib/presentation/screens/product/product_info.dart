import 'package:bruva/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../widgets.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  const ProductInfo({Key? key,required this.product}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      color:const  Color(0xFFFFFFFF),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2.2,
                  child: Image.network(
                    widget.product.images.first,
                    fit: BoxFit.fill,
                  ),
                ),Positioned(
                  bottom: 10,
                  right: 5,
                  child: favoritesButtonInfo(widget.product),
                ),Positioned(
                  top:0,
                  left: 5,
                  child:backArrow(context),

                ),
              ],
            ),
            Container(
              decoration:const BoxDecoration(
                color: Color(0xFFFFFFFF),
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
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height /
                          10,
                    ),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:const EdgeInsets.only(
                              top: 0, left: 18, right: 16),
                          child: Text(
                            widget.product.name,
                            textAlign: TextAlign.left,
                            style:const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: .27,
                              color:
                              Color(0xFF17262A),
                            ),
                          ),
                        ),
                        Text(
                          '${widget.product.price}  L.E',
                          textAlign: TextAlign.left,
                          style:const TextStyle(
                            fontSize: 22,
                            letterSpacing: .27,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

//TODO: sizes here
//                           Container(
//                             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 AnimatedOpacity(
//                                   opacity: 0.0,
//                                   duration: Duration(milliseconds: 500),
//                                   child: Container(
//                                     width: prods[0].sizes.length *
//                                         90.0 +
//                                         70,
//                                     height: 50,
//                                     child: Padding(
//                                       padding: EdgeInsets.all(5),
//                                       child: ListView.builder(
//                                           physics: BouncingScrollPhysics(),
//                                           shrinkWrap: true,
//                                           itemCount: prods[0]
//                                               .sizes
//                                               .length,
//                                           scrollDirection: Axis.horizontal,
//                                           itemBuilder: (ctx, index) {
//                                             return Row(
//                                               children: <Widget>[
//                                                 Padding(
//                                                   padding:
//                                                   const EdgeInsets.all(
//                                                       8.0),
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         selectedSize = prods[0]
//                                                             .sizes[index];
//                                                         sizeIndex = index;
// //                                                          print(
// //                                                              widget.product_detail_size[
// //                                                                  selectedSize]);
//                                                       });
//                                                     },
//                                                     child: Container(
//                                                       decoration:
//                                                       BoxDecoration(
//                                                         color: sizeIndex ==
//                                                             index
//                                                             ? Colors.indigo
//                                                             : DesignCourseAppTheme
//                                                             .nearlyWhite,
//                                                         borderRadius:
//                                                         BorderRadius.only(
//                                                             topRight: Radius
//                                                                 .circular(
//                                                                 12),
//                                                             bottomLeft:
//                                                             Radius.circular(
//                                                                 12)),
//                                                         boxShadow: <
//                                                             BoxShadow>[
//                                                           BoxShadow(
//                                                             color: Colors
//                                                                 .black
//                                                                 .withOpacity(
//                                                                 .2),
//                                                             offset: Offset(
//                                                                 1.1, 1.1),
//                                                             blurRadius: 5,
//                                                           )
//                                                         ],
//                                                       ),
//                                                       alignment:
//                                                       Alignment.center,
//                                                       child: Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .all(3.0),
//                                                         child: Text(
//                                                           prods[0]
//                                                               .sizes[index],
//                                                           style: TextStyle(
//                                                               fontSize: 14,
//                                                               color: sizeIndex ==
//                                                                   index
//                                                                   ? Colors
//                                                                   .white
//                                                                   : Colors
//                                                                   .black,
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .w600),
//                                                           textAlign: TextAlign
//                                                               .center,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
//                                           }),
//                                     ),
//                                   ),
//                                 ),
//                                 AnimatedOpacity(
//                                   opacity: opacity1,
//                                   duration: Duration(milliseconds: 500),
//                                   child: Container(
//                                     width:
//                                     prods[0].colors.length *
//                                         70.0 +
//                                         50,
//                                     height: 50,
//                                     child: Padding(
//                                       padding: EdgeInsets.all(5),
//                                       child: ListView.builder(
//                                           physics: BouncingScrollPhysics(),
//                                           shrinkWrap: true,
//                                           itemCount: prods[0]
//                                               .colors
//                                               .length,
//                                           scrollDirection: Axis.horizontal,
//                                           itemBuilder: (ctx, index) {
//                                             return Row(
//                                               children: <Widget>[
//                                                 Padding(
//                                                   padding:
//                                                   const EdgeInsets.all(
//                                                       8.0),
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         selectedColor = prods[
//                                                         0]
//                                                             .colors[index];
//                                                         colorIndex = index;
// //                                                          print(
// //                                                              widget.product_detail_size[
// //                                                                  selectedSize]);
//                                                       });
//                                                     },
//                                                     child: Container(
//                                                       width: 50,
//                                                       decoration:
//                                                       BoxDecoration(
//                                                         color: colorIndex ==
//                                                             index
//                                                             ? Colors
//                                                             .deepPurple
//                                                             : DesignCourseAppTheme
//                                                             .nearlyWhite,
//                                                         borderRadius:
//                                                         BorderRadius.only(
//                                                             topRight: Radius
//                                                                 .circular(
//                                                                 12),
//                                                             bottomLeft:
//                                                             Radius.circular(
//                                                                 12)),
//                                                         boxShadow: <
//                                                             BoxShadow>[
//                                                           BoxShadow(
//                                                             color: Colors
//                                                                 .black
//                                                                 .withOpacity(
//                                                                 .2),
//                                                             offset: Offset(
//                                                                 1.1, 1.1),
//                                                             blurRadius: 5,
//                                                           )
//                                                         ],
//                                                       ),
//                                                       alignment:
//                                                       Alignment.center,
//                                                       child: Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .all(0.0),
//                                                         child: Text(
//                                                           prods[0]
//                                                               .colors[index],
//                                                           style: TextStyle(
//                                                               fontSize: 14,
//                                                               color: colorIndex ==
//                                                                   index
//                                                                   ? Colors
//                                                                   .white
//                                                                   : Colors
//                                                                   .black,
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .w600),
//                                                           textAlign: TextAlign
//                                                               .center,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
//                                           }),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),




                    //TODO  check spaces
                   const Divider(),
                    const   Text('Description'),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: SizedBox(
                        height:
                        MediaQuery
                            .of(context)
                            .size
                            .height /
                            5,
                        width:
                        MediaQuery
                            .of(context)
                            .size
                            .width /
                            1.1,
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding:
                             const EdgeInsets.all(0.0),
                              child: Text(
                                widget.product.description
                                ,
                                textAlign: TextAlign.left,
                                style:const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    letterSpacing: .27,
                                    color: Colors.black),
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
              const Spacer(),
            cartButton(widget.product),
          ],
        ),

      ),
    );
  }
}
