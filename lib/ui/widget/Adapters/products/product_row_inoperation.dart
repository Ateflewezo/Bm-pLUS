import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../../../control/modules/product.dart';
import '../../../widget/currency_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Product_inoperation_Row extends StatelessWidget {
  Product product;
  Product_inoperation_Row({@required this.product});

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<Operation_provider>(context);
    var products = bloc.productslist;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(5.w),
          child: Container(
            width: 200.w,
            height: 250.h,
            child: Card(
              margin: EdgeInsets.only(top: 5.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    width: 210.w,
                    height: 130.h,
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
                    product.name + ' (${product.quantity})',
                    style: TextStyle(
                      fontSize: Styles().fontSize_name,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  adapter_currency(context, product.price, Colors.black,
                      Styles().fontSize_price_ad),
                ],
              ),
            ),
          ),
        ),
        CachedNetworkImage(
          width: 200.w,
          height: 150.h,
          alignment: Alignment.topCenter,
          placeholder: (context, url) => Image(
            // fit: BoxFit.cover,
            image: AssetImage("res/images/logo.png"),
          ),
          imageUrl: product.imageURL,
        ),
        //
      ],
    );
  }
}
