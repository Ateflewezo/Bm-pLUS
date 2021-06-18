import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:service_app/ui/widget/Adapters/products/product_row.dart';
import '../../../../control/modules/product.dart';

Widget List_products_AddToOffer() {
  return GridView.builder(
      shrinkWrap: true,
      itemCount: 50,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8),
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
          child: Product_Row(
            product: Product(),
          ),
          onTap: () {
            // showAlertDialog_new_offer(context);
          },
        );
      });
}
