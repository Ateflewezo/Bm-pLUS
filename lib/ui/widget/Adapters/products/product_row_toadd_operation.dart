import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../../../control/modules/product.dart';
import '../../../widget/currency_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ADD_To_Operation_Product_Row extends StatefulWidget {
  Product product;
  ADD_To_Operation_Product_Row({@required this.product});
  @override
  ADD_To_Operation_Product_Row_State createState() =>
      ADD_To_Operation_Product_Row_State();
}

class ADD_To_Operation_Product_Row_State
    extends State<ADD_To_Operation_Product_Row> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<Operation_provider>(context, listen: true);
    var products = bloc.productslist;
    // print("product in bloc ${bloc.products[0].name}");
    int _quantity = 1;
    return InkResponse(
      onTap: () {
        bloc.contains(widget.product)
            ? null //bloc.re(widget.product)
            : bloc.addToProducts(widget.product.id, widget.product);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: bloc.contains(widget.product)
                  ? Color(0XFF549FFF)
                  : Colors.transparent,
              width: 2.w),
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              width: 230.w,
              // height: 250, //MediaQuery.of(context).size.height + 10,
              child: Card(
                margin: EdgeInsets.only(top: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                      width: 190.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.blue[100],
                            Colors.blue[200],
                            Colors.blue[300],
                            Colors.blue[500]
                          ],
                          // transform: GradientRotation(4),
                        ),
                      ),
                    ),
                    Text(
                      widget.product.name,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: Styles().fontSize_name,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    adapter_currency(context, widget.product.price,
                        Colors.black, Styles().fontSize_price_ad),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkResponse(
                          onTap: () {
                            bloc.addToProducts(
                                widget.product.id, widget.product);
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            padding: EdgeInsets.only(
                              bottom: 0,
                            ),
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              // color: Colors.blue[500],
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.blue[100],
                                  Colors.blue[200],
                                  Colors.blue[300],
                                  Colors.blue[500]
                                ],
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),

                        Text(
                          bloc.contains(widget.product)
                              ? bloc
                                  .productslist[bloc.productslist.indexWhere(
                                      (element) =>
                                          element.id == widget.product.id)]
                                  .quantity
                                  .toString()
                              : "0",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: Styles().fontSize_name,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            bloc.removToProducts(widget.product);
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            padding: EdgeInsets.only(
                              bottom: 0,
                            ),
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              // color: Colors.blue[500],
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.blue[100],
                                  Colors.blue[200],
                                  Colors.blue[300],
                                  Colors.blue[500]
                                ],
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),

                        //
                        SizedBox(
                          width: 0,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CachedNetworkImage(
                width: 350.w,
                height: 120.h,
                alignment: Alignment.topCenter,
                placeholder: (context, url) => Image(
                  // fit: BoxFit.none,
                  image: AssetImage("res/images/logo.png"),
                ),
                imageUrl: widget.product.imageURL,
              ),
            ),
            bloc.contains(widget.product)
                ? Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(5)),
                        color: Color(0XFF549FFF)
                        //  border: Border.all(color: Color(0XFF549FFF),width: 1),
                        ),
                    child: Icon(
                      Icons.check,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
