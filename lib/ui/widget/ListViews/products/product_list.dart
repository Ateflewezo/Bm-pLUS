import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Adapters/products/product_row.dart';
import 'package:service_app/ui/widget/Popups/Offers/add_new.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:service_app/ui/widget/Popups/products/add_new.dart';
import '../../../../control/modules/product.dart';
import '../../../../control/services/products.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget List_products(BuildContext context, bool isoffer) {
  List<Product> products;
  Products_provider productProvider = Products_provider();
  return Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: Padding(
      padding: EdgeInsets.only(bottom: 0.h, right: 50.w, left: 50.w),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xFF69ADFC),
        child: Container(
          alignment: Alignment.center,
          // width: 90,
          height: 80.w,
          child: Text(
            "add_product_to_oper".tr().toString(),
            style: TextStyle(color: Colors.white, fontSize: 28.sp),
          ),
        ),
        onPressed: () {
          Stream userStream = Stream.fromFuture(Store().getStore_Info());
          userStream.listen((event) {
            User user = event;
            print(
                'products_permissions ${event.products_permissions[0].value}');
            if (user.products_permissions[0].value) {
              Product_addnew_alert(context);
            } else {
              NO_Permissions(context);
            }
          });
        },
      ),
    ),
    body: Column(
      children: [
        StreamBuilder(
            stream: productProvider.fetchProductsAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                products = snapshot.data.docs
                    .map((doc) => Product.fromMap(doc.data(), doc.id))
                    .toList();
                if (products.isEmpty) {
                  return Center(
                      child: Text(
                    'nodata'.tr().toString(),
                    style: Styles().textStyle_nodata,
                  ));
                }
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.w,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 1.1.w),
                    itemBuilder: (BuildContext context, int index) {
                      print("products[index].name ${products[index].name}");
                      return InkResponse(
                        child: Product_Row(
                          product: products[index],
                        ),
                        onTap: () {
                          print("products[index].name ${products[index].id}");

                          isoffer
                              ? showAlertDialog_new_offer(
                                  context, products[index], null, true)
                              : Navigator.pushNamed(
                                  context, '/details/${products[index].id}');
                        },
                      );
                    });

                // return ListView.builder(
                //   itemCount: products.length,
                //   itemBuilder: (buildContext, index) =>
                //       ProductCard(productDetails: products[index]),
                // );
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
