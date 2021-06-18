import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Adapters/products/product_row_inoperation.dart';
import '../../../../control/modules/product.dart';
import 'package:easy_localization/easy_localization.dart';

Widget List_products_inOperation(
    BuildContext context, List<Product> productslist) {
  List<Product> products;
  if (productslist.isEmpty) {
    var bloc = Provider.of<Operation_provider>(context);
    products = bloc.productslist;
  } else {
    products = productslist;
  }
  return products.length != 0
      ? ListView.builder(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            // return Product_Row();
            print("product added ${products.length}");
            // print("product added ${bloc.list[index]}");

            print(products[index].toString());
            if (products[index] != null)
              return Product_inoperation_Row(product: products[index]);
          },
        )
      : Center(
          child: Text(
            'nodata'.tr().toString(),
            style: Styles().textStyle_nodata,
          ),
        );
}
