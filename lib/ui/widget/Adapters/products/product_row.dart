import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../../../control/modules/product.dart';
import '../../../widget/currency_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Product_Row extends StatelessWidget {
  Product product;
  Product_Row({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            width: 170.w,
            height: 270.h, //MediaQuery.of(context).size.height + 10,
            child: Card(
              margin: EdgeInsets.only(top: 5.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                    width: 160.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.h),
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
                    product.name,
                    maxLines: 1,
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
          width: 150.w,
          height: 120.h,
          alignment: Alignment.topCenter,
          // placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: product.imageURL,
        ),
      ],
    );
  }
}
