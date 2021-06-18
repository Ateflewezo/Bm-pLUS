import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:service_app/ui/menu/botton_navigation.dart';
import 'package:service_app/ui/menu/drawer_side.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/ListViews/products/product_list.dart';
import 'package:service_app/ui/widget/onBoarding/offers.dart';
import '../tooles/constants/styles.dart' as styles;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var _padding = const EdgeInsets.symmetric(horizontal: 32);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leadingWidth: 100,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.grey[50],
          leading: RotatedBox(
            quarterTurns:
                EasyLocalization.of(context).locale == Locale("en", "US")
                    ? 2
                    : 0,
            child: IconButton(
              icon: Image(
                image: AssetImage("res/images/menu.png"),
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          actions: [
            Padding(
              padding: _padding,
              child: RotatedBox(
                quarterTurns:
                    EasyLocalization.of(context).locale == Locale("en", "US")
                        ? 4
                        : 1,
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.transparent,
                    // color: Colors.black,
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, "/search");
                  },
                ),
              ),
            )
          ],
          title: Center(
            child: Text(
              'products'.tr().toString(),
              style: styles.title_style,
            ),
          ),
        ),
        drawer: Drawer_Side(),
        bottomNavigationBar: BottonNavigation(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatinButton(
          isopearation: false,
        ),
        body: Container(
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),

              // Padding(
              //   padding: _padding,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('lastoffers'.tr().toString(),
              //           style: styles.suptitle_style),
              //       TextButton(
              //         child: Text(
              //           'seeall'.tr().toString(),
              //           style: TextStyle(fontSize: Styles().fontSize_seeall),
              //         ),
              //         onPressed: () {
              //           Navigator.pushNamed(context, "/offers");
              //         },
              //       )
              //     ],
              //   ),
              // ),

              // SizedBox(
              //   height: 20.h,
              // ),
              // Container(
              //   // padding: _padding,
              //   height: 350.h,
              //   child: OffersScreen(),
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // Padding(
              //   padding: _padding,
              //   child: Text(
              //     'allproducts'.tr().toString(),
              //     style: styles.suptitle_style,
              //   ),
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
              ////listview

              Container(
                height: 1020.h,
                child: Padding(
                  padding: _padding,
                  child: List_products(context, false),
                ),
              ),
            ],
          ),
        ));
  }
}
