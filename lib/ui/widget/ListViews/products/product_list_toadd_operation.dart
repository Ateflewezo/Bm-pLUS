import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:service_app/ui/widget/Adapters/products/product_row_toadd_operation.dart';
import 'package:service_app/ui/widget/Popups/products/add_new.dart';
import '../../../../control/modules/product.dart';
import '../../../../control/services/products.dart';
import 'package:easy_localization/easy_localization.dart';

Widget List_products_Add_To_operation(BuildContext context) {
  List<Product> products;
  Products_provider productProvider = Products_provider();
  return Scaffold(
   
    body: Column(
      children: [
        StreamBuilder(
            stream: productProvider.fetchProductsAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                products = snapshot.data.docs
                    .map((doc) => Product.fromMap(doc.data(), doc.id))
                    .toList();
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.5),
                    itemBuilder: (BuildContext context, int index) {
                      return ADD_To_Operation_Product_Row(
                        product: products[index],
                      );
                    });
              } else {
                return Center(child: Text('loading'.tr().toString()));
              }
            }),
        // SizedBox(
        //   height: 20.0,
        // )
      ],
    ),
  );
}
