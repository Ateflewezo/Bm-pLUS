import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/date.dart';
import 'package:service_app/control/modules/statistic.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/expancess.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:service_app/ui/widget/Charts/satistic.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';

import 'package:service_app/ui/widget/ListViews/expance_list.dart';
import 'package:service_app/ui/widget/Popups/expancess/new.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as Styles;
import '../../control/modules/expancess.dart';
import '../widget/currency_text.dart';
import '../../control/provider/operation.dart';

import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Satistics extends StatefulWidget {
  @override
  _SatisticsState createState() => _SatisticsState();
}

var bloc;
int _operation_page = 1;
String _filterby = 'date.day';
String _date = DateTime.now().day.toString();

class _SatisticsState extends State<Satistics> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<Operation_provider>(context, listen: false);
    int month = Date().isoWeekNumber(DateTime.now()); //Jiffy().week.toString();
    print('DateTime.now().weekday ${month}');
    var _padding = EdgeInsets.symmetric(horizontal: 15.w);
    Satistic_model satistic =
        Satistic_model(tot_expancess: 0.0, tot_product: 0.0, tot_service: 0.0);
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // var _padding = const EdgeInsets.symmetric(horizontal: 32);
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100.h,
          shadowColor: Colors.transparent,
          backgroundColor: Constance.product_details2,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Constance.product_details1,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: _padding,
              child: IconButton(
                icon: Icon(Icons.search, color: Colors.transparent),
                onPressed: () {
                  Navigator.pushNamed(context, "/search");
                },
              ),
            )
          ],
          title: Center(
            child: Text(
              'Statistics'.tr().toString(),
              style: TextStyle(
                  color: Constance.product_details1,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: StreamBuilder(
            stream:
                Operations_provider().fetchStatic_AsStream(_filterby, _date),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                satistic.tot_product = 0.0;
                satistic.tot_service = 0.0;
                for (var item in snapshot.data.docs) {
                  print(
                      "payments ${Operation_provider.fromsnapshotTOstatic(item, item.id).product_total.toString()}");

                  satistic.tot_product +=
                      Operation_provider.fromsnapshotTOstatic(item, item.id)
                          .product_total;

                  satistic.tot_service +=
                      Operation_provider.fromsnapshotTOstatic(item, item.id)
                          .service_total;
                }
                return ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Constance.product_details2,
                      ),
                      height: 120.h,
                      child: DefaultTabController(
                        length: getTabs().length,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: TabBar(
                                unselectedLabelColor: Colors.white30,
                                labelColor: Colors.white,
                                indicatorColor: Colors.blue,
                                tabs: getTabs(),
                                onTap: (int i) {
                                  switch (i) {
                                    case 0:
                                      setState(() {
                                        _filterby = 'date.day';
                                        _date = DateTime.now().day.toString();
                                      });
                                      break;
                                    case 1:
                                      setState(() {
                                        _filterby = 'date.week';
                                        _date = Date()
                                            .isoWeekNumber(DateTime.now())
                                            .toString();
                                      });
                                      break;
                                    case 2:
                                      setState(() {
                                        _filterby = 'date.month';
                                        _date = DateTime.now().month.toString();
                                      });
                                      break;
                                    case 3:
                                      setState(() {
                                        _filterby = 'date.year';
                                        _date = DateTime.now().year.toString();
                                      });
                                      break;
                                    default:
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: 750.w, child: _stack_top(context, satistic)),
                    Container(
                      height: 1000.h,
                      alignment: Alignment.topRight,
                      padding: _padding,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: 750.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "expance".tr().toString(),
                                  style: Styles.suptitle_style,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                      height: 180.h,
                                      width: 650.w,
                                      child: List_Expanses(_filterby, _date))),
                              Container(
                                  width: 80.w,
                                  height: 180.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      // BoxShadow(
                                      //   blurRadius: 1,
                                      //   spreadRadius: 1,
                                      //   color: Colors.grey,
                                      // ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.w),
                                    ),
                                    color: Constance.product_details1,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 25.sp,
                                    ),
                                    onPressed: () {
                                      New_expancess_alert(context);
                                    },
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          bottom_widget(context, satistic),
                        ],
                      ),
                    ),
                  ],
                );

                /////
              } else {
                return Center(
                    child: Text(
                  'loading'.tr().toString(),
                  style: Styles.Styles().textStyle_nodata,
                ));
              }
            }));
  }
}

bottom_widget(BuildContext context, Satistic_model data) {
  double _width = 340.w;
  double _height = 250.w;
  return Column(
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "tot_services_product".tr().toString(),
              style: Styles.suptitle_style,
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: _height,
            width: _width,

            // width: MediaQuery.of(context).size.width * 0.45,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadowColor: Colors.grey,
              color: Constance.color3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Container(
                          width: 70.w,
                          height: 80.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.w),
                            ),
                            color: Constance.color4,
                          ),
                          child: Image(
                            image: AssetImage("res/images/car.png"),
                            color: Colors.white,
                          )),
                      Padding(
                        padding: EdgeInsets.all(2),
                      ),
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          "services_done".tr().toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Styles.Styles().fontSize_name,
                          ),
                        ),
                      )
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Satictic_currency(context, data.tot_service,
                            Colors.white, Styles.Styles().fontSize_price),
                        // Container(
                        //     width: 50.w,
                        //     height: 50.w,
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //       boxShadow: <BoxShadow>[
                        //         BoxShadow(
                        //           blurRadius: 1,
                        //           spreadRadius: 1,
                        //           color: Colors.grey,
                        //         ),
                        //       ],
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(50),
                        //       ),
                        //       color: Constance.product_details1,
                        //     ),
                        //     child: Icon(
                        //       Icons.arrow_forward_ios,
                        //       size: 20.sp,
                        //       color: Colors.transparent,
                        //     )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: _height,
            width: _width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w),
              ),
              shadowColor: Colors.grey,
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Container(
                          width: 70.w,
                          height: 80.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: Colors.grey,
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.w),
                            ),
                            color: Constance.color4,
                          ),
                          child: Image(
                            image: AssetImage("res/images/cart.png"),
                            color: Colors.white,
                          )),
                      Padding(
                        padding: EdgeInsets.all(2.w),
                      ),
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          "tot_salse".tr().toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Styles.Styles().fontSize_name,
                          ),
                        ),
                      )
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Satictic_currency(context, data.tot_product,
                            Colors.black, Styles.Styles().fontSize_price),
                        // Container(
                        //     width: 50.w,
                        //     height: 50.w,
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //       boxShadow: <BoxShadow>[
                        //         BoxShadow(
                        //           blurRadius: 1,
                        //           spreadRadius: 1,
                        //           color: Colors.grey,
                        //         ),
                        //       ],
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(50.h),
                        //       ),
                        //       color: Constance.color4,
                        //     ),
                        //     child: Icon(
                        //       Icons.arrow_forward_ios,
                        //       size: 20.sp,
                        //       color: Colors.transparent,
                        //     )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}

Widget _stack_top(BuildContext context, Satistic_model satistics) {
  double _width = 220.w;
  double _height = 230.w;
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        margin: EdgeInsets.only(bottom: 150.h),
        padding: EdgeInsets.only(bottom: 100.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30.h),
            bottomLeft: Radius.circular(30.h),
          ),
          color: Constance.product_details2,
        ),
        width: 750.w,
        height: 70.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Expanded(
            //   child: Container(
            //     height: 800.h,
            //     width: 750.w,
            //     child: Center(child: Satistics_Chart()),
            //   ),
            // ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
        child: StreamBuilder(
            stream: Expancess_provider().getstatistic(_filterby, _date),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                satistics.tot_expancess = 0.0;
                for (var item in snapshot.data.docs) {
                  print("Expancess ${Expancess.fromMap(item.data(), item.id)}");

                  satistics.tot_expancess +=
                      Expancess.fromMap(item.data(), item.id).price;
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: _width,
                      height: _height,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 0.5,
                            spreadRadius: 0.5,
                            color: Colors.grey[400],
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        ),
                        // border: Border.all(),
                        color: Constance.color4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "enters".tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Styles.Styles().fontSize_name,
                                color: Colors.white),
                          ),
                          Satictic_currency(
                              context,
                              satistics.tot_product + satistics.tot_service,
                              Colors.white,
                              Styles.Styles().fontSize_price),
                        ],
                      ),
                    ),
                    Container(
                      width: _width,
                      height: _height,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 0.5,
                            spreadRadius: 0.5,
                            color: Colors.grey,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        ),
                        // border: Border.all(),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "expance".tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Styles.Styles().fontSize_name,
                            ),
                          ),
                          Satictic_currency(context, satistics.tot_expancess,
                              Colors.black, Styles.Styles().fontSize_price),
                        ],
                      ),
                    ),
                    Container(
                      width: _width,
                      height: _height,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 0.5,
                            spreadRadius: 0.5,
                            color: Colors.grey,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        ),
                        // border: Border.all(),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "enquam".tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Styles.Styles().fontSize_name,
                            ),
                          ),
                          Satictic_currency(
                              context,
                              (satistics.tot_product + satistics.tot_service) -
                                  satistics.tot_expancess,
                              Colors.black,
                              Styles.Styles().fontSize_price),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('loading'.tr().toString()));
              }
            }),
      ),
    ],
  );
}

List<Tab> getTabs() {
  return <Tab>[
    Tab(
      child: Text(
        'thisDay'.tr().toString(),
        style: TextStyle(fontSize: Styles.Styles().fontSize_statistic_tit1),
      ),
    ),
    Tab(
      child: Text(
        'thisweak'.tr().toString(),
        style: TextStyle(
          fontSize: Styles.Styles().fontSize_statistic_tit1,
        ),
      ),
    ),
    Tab(
      child: Text(
        'thismonthe'.tr().toString(),
        style: TextStyle(
          fontSize: Styles.Styles().fontSize_statistic_tit1,
        ),
      ),
    ),
    Tab(
      child: Text(
        'thisyear'.tr().toString(),
        style: TextStyle(
          fontSize: Styles.Styles().fontSize_statistic_tit1,
        ),
      ),
    ),
  ];
}
