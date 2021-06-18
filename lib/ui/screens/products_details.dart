import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/customer.dart';
import 'package:service_app/control/modules/date.dart';
import 'package:service_app/control/modules/product.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/customers.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:service_app/control/services/products.dart';
import 'package:service_app/ui/widget/Popups/operations/added_succ.dart';
import 'package:service_app/ui/widget/Popups/products/update.dart';
import 'package:service_app/ui/widget/Popups/products/delete.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as styles;
import '../widget/currency_text.dart';

import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Products_Details extends StatefulWidget {
  String id;
  Products_Details({this.id});

  @override
  _Products_DetailsState createState() => _Products_DetailsState();
}

int _quantity = 1;
String _name;
String _phone;

class _Products_DetailsState extends State<Products_Details> {
  @override
  Widget build(BuildContext context) {
    _name = 'guest'.tr().toString();
    _phone = '0000000000';
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return FutureBuilder<Product>(
        future: Products_provider().getProductById(
            widget.id), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Product> customer) {
          if (customer.hasData) {
            return details(context, customer.data);
          } else {
            return Center(
                child: Text(
              'loading'.tr().toString(),
              style: TextStyle(fontSize: 20.sp),
            ));
          }
        });
  }

  final _formKey = GlobalKey<FormState>();
  Widget details(BuildContext context, Product data) {
    var _padding = EdgeInsets.symmetric(horizontal: 32.w);

    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100.w,
          shadowColor: Colors.transparent,
          backgroundColor: Constance.product_details2,
          leading: RotatedBox(
            quarterTurns:
                EasyLocalization.of(context).locale == Locale("en", "US")
                    ? 2
                    : 2,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios,
                  color: Constance.product_details1
                  // color: Colors.transparent,
                  ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: [
            Padding(
              padding: _padding,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.delete, color: Constance.product_details1),
                    onPressed: () {
                      Stream userStream =
                          Stream.fromFuture(Store().getStore_Info());
                      userStream.listen((event) {
                        User user = event;
                        print(
                            'products_permissions ${event.products_permissions[2].value}');
                        if (user.products_permissions[2].value) {
                          Product_delete(context, data);
                        } else {
                          NO_Permissions(context);
                        }
                      });
                    },
                  ),
                  RotatedBox(
                      quarterTurns: EasyLocalization.of(context).locale ==
                              Locale("en", "US")
                          ? 4
                          : 0,
                      child: IconButton(
                        icon:
                            Icon(Icons.edit, color: Constance.product_details1),
                        onPressed: () {
                          Stream userStream =
                              Stream.fromFuture(Store().getStore_Info());
                          userStream.listen((event) {
                            User user = event;
                            print(
                                'products_permissions ${event.products_permissions[2].value}');
                            if (user.products_permissions[2].value) {
                              Product_update_alert(context, data);
                            } else {
                              NO_Permissions(context);
                            }
                          });
                        },
                      )),
                ],
              ),
            )
          ],
          title: Center(
            child: Text(
              'product_details'.tr().toString(),
              style:
                  TextStyle(color: Constance.product_details1, fontSize: 28.sp),
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 40.h),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("res/images/prod_top.png"),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.5,
              // width: 10000.w,
              child: Padding(
                padding: _padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      data.name,
                      style: TextStyle(
                        fontSize: 32.h,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 80.w,
                                  height: 80.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Constance.product_details1,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors
                                            .white54, //grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                    // border:
                                    //     Border.all(color: Colors.white10, width: 1)
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _quantity++;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Text(
                                    _quantity.toString(),
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80.w,
                                  height: 80.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.w)),
                                    color: Constance.product_details1,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors
                                            .white54, //grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                    // border:
                                    //     Border.all(color: Colors.white10, width: 1)
                                  ),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: Icon(
                                      Icons.remove,
                                    ),
                                    onPressed: () {
                                      if (_quantity > 1)
                                        setState(() {
                                          _quantity--;
                                        });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 50.h),
                              child: adapter_currency(context,
                                  data.price * _quantity, Colors.white, 60.sp),
                            ),
                          ],
                        ),
                        data.imageURL != null
                            ? CachedNetworkImage(
                                width: 300.w,
                                height: 350.w,
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover,
                                // placeholder: (context, url) => CircularProgressIndicator(),
                                imageUrl: data.imageURL,
                              )
                            : SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: _padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: EasyLocalization.of(context).locale ==
                              Locale("en", "US")
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Text(
                        "user_info".tr().toString(),
                        textAlign: TextAlign.start,
                        style: styles.title_style,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      height: 90.h,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "fullname".tr().toString();
                          } else {
                            _name = value;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Image(
                            image: AssetImage("res/images/person.png"),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: "fullname".tr().toString(),
                          labelStyle: styles.Styles().textStyle_labelstyle,
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      height: 90.h,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty || 14 < value.length
                              // ||
                              // value.length < 10
                              ) {
                            return "phone_number".tr().toString();
                          } else {
                            _phone = value;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Image(
                            image: AssetImage("res/images/phone.png"),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: "phone_number".tr().toString(),
                          labelStyle: styles.Styles().textStyle_labelstyle,
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.h),
                      child: RaisedButton(
                        color: Color(0xFF13AC97),
                        child: Container(
                          alignment: Alignment.center,
                          width: 300.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80.w))),
                          child: Text(
                            "sale_product".tr().toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 22.sp),
                          ),
                        ),
                        onPressed: () {
                          _Add_operation(context, data);

                          // if (_formKey.currentState.validate()) {
                          //   _Add_operation(context, data);
                          // }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Future<void> _Add_operation(BuildContext context, Product product) async {
    Operation_provider operation = Operation_provider();

    Customer customer = Customer(name: _name, phone_number: _phone);

    Customers_provider customers_provider = Customers_provider();
    Progress progress = Progress();

    progress.OnProgress(context, false);

    await customers_provider.addcustomerandgetID(customer);

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy/MM/dd');
    String date = formatter.format(now);
    operation.customer = customer;
    operation.productslist.add(product);
    operation.state = 4;

    operation.date_all = date;
    operation.date = Date(
        day: now.day.toString(),
        month: now.month.toString(),
        year: now.year.toString(),
        week: Date().isoWeekNumber(now).toString());
    print(DateTime.now().millisecondsSinceEpoch);
    operation.id = (now.millisecondsSinceEpoch - 1607000000000).toString();
    operation.product_total = _quantity * product.price;
    operation.paid = _quantity * product.price;
    operation.service_total = 0.0;
    Operations_provider operations_provider = Operations_provider();
    operations_provider.add_operation(operation).then((value) {});
    Navigator.of(context).pop();
    operation_added_succ(context, progress);
    // progress.cancelTimer();
    // //////libre le bloc
    // // operation.liber();
  }
}
