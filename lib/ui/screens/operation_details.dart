import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/modules/customer.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/customers.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:service_app/ui/widget/ListViews/products/product_list_inoperation.dart';
import 'package:service_app/ui/widget/ListViews/services/service_list_inoperation.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:service_app/ui/widget/Popups/operations/added_succ.dart';
import 'package:service_app/ui/widget/Popups/operations/updateState_pop.dart';
import 'package:service_app/ui/widget/operation_tools.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import 'package:telephony/telephony.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as Styles;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Operation_Details extends StatefulWidget {
  String id;
  Operation_Details({this.id});
  @override
  _Operation_DetailsState createState() => _Operation_DetailsState();
}

var _padding = EdgeInsets.symmetric(horizontal: 50.w);
int _operation_page = 1;

Operations_provider operations_provider = Operations_provider();
var bloc;

class _Operation_DetailsState extends State<Operation_Details> {
  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<Operation_provider>(context, listen: true);

    return FutureBuilder<Operation_provider>(
        future: operations_provider.getOperationById(
            widget.id), // a previously-obtained Future<String> or null
        builder: (BuildContext context,
            AsyncSnapshot<Operation_provider> operation) {
          if (operation.hasData) {
            if (operation.data.state == 1) {
              // bloc = operation.data;
              if (bloc.customer == null) {
                bloc.updatebloc(operation.data);
                bloc.new_operation = false;
              }
              return details(bloc);
            } else {
              return details(operation.data);
            }
          } else {
            return Center(
                child: Text(
              'loading'.tr().toString(),
              style: Styles.Styles().textStyle_nodata,
            ));
          }
        });
  }

  Widget details(Operation_provider operation) {
    return Scaffold(
        floatingActionButton: operation.state == 1
            ? FloatingActionButton(
                onPressed: () async {
                  if (bloc.serviceslist.isEmpty && bloc.productslist.isEmpty) {
                    EasyLoading.showInfo('empty_operation'.tr().toString());
                    return;
                  }
                  Progress progress = Progress();
                  progress.OnProgress(context, false);

                  Operations_provider operations_provider =
                      Operations_provider();

//////test new or update
                  if (!bloc.new_operation) {
                    await operations_provider
                        .updateOperation_All(bloc, bloc.uid)
                        .then((value) {
                      //////libre le bloc
                      bloc.liber();

                      Navigator.of(context).pushNamed("/home");
                      operation_added_succ(context, progress);
                    });
                    return;
                  }
                },
                tooltip: 'Increment',
                child: new Icon(
                  Icons.save_outlined,
                  size: 35.sp,
                  color: Colors.white,
                ),
              )
            : SizedBox(),
        appBar: AppBar(
          leadingWidth: 200.w,
          shadowColor: Colors.transparent,
          backgroundColor: Constance.product_details2,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Constance.product_details1,
            ),
            onPressed: () {
              bloc.liber();

              Navigator.pop(context);
            },
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
                  icon: Icon(Icons.search, color: Colors.transparent),
                  onPressed: () {
                    Navigator.pushNamed(context, "/search");
                  },
                ),
              ),
            )
          ],
          title: Center(
            child: Text(
              'operation_details'.tr().toString(),
              style: TextStyle(
                  color: Constance.product_details1,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: ListView(
          children: [
            _stack_top(context, operation),
            Container(
              height: 1330.h,
              alignment: Alignment.topRight,
              padding: _padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ////////////
                  Operation_moment(context, operation,
                      '/operation_details/${operation.uid}'),

                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "service_added".tr().toString(),
                        style: Styles.suptitle_style,
                      ),
                      operation.state == 1
                          ? RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red),
                              ),
                              color: Color(0xFF13AC97),
                              child: Container(
                                alignment: Alignment.center,
                                // width: 250.w,
                                // height: 40.h,
                                child: Text(
                                  "add_service_to_oper".tr().toString(),
                                  style: TextStyle(
                                    fontSize: Styles.Styles().fontSize_name,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/add_service_to_oper');
                              },
                            )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                      height: 300.h,
                      child: List_service_inOperation(
                          serviceslist: operation.serviceslist)),
                  // /list service
                  SizedBox(
                    height: 20.h,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "product_added".tr().toString(),
                        style: Styles.suptitle_style,
                      ),
                      operation.state == 1
                          ? RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red),
                              ),
                              color: Color(0xFF438BE8),
                              child: Text(
                                "add_product_to_oper".tr().toString(),
                                style: TextStyle(
                                  fontSize: Styles.Styles().fontSize_name,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/add_product_to_oper');
                              },
                            )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Flexible(
                      flex: 2,
                      child: List_products_inOperation(
                          context, operation.productslist)),
                  SizedBox(
                    height: 20.h,
                  ),
                  operation.state <= 3
                      ? Container(
                          // width: 80,
                          height: 80.h,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 0.2,
                                spreadRadius: 0.1,
                                color: Constance.product_details1,
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            // border: Border.all(),
                            color: Constance.product_details1,
                          ),
                          child: InkResponse(
                            onTap: () {
                              Stream userStream =
                                  Stream.fromFuture(Store().getStore_Info());
                              userStream.listen((event) {
                                User user = event;
                                print(
                                    'operations_permissions ${event.operations_permissions[1].value}');
                                if (user.operations_permissions[1].value) {
                                  Operation_update(context, operation,
                                      '/operation_details/${operation.uid}');

                                  // setState(() {

                                  // });
                                } else {
                                  NO_Permissions(context);
                                }
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "begin_oper".tr().toString(),
                                  style: TextStyle(
                                      fontSize: Styles.Styles().fontSize_name,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

Widget _stack_top(BuildContext context, Operation_provider data) {
  return FutureBuilder<Customer>(
      future: Customers_provider().getcustomerById(data.customer
          .phone_number), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<Customer> customer) {
        if (customer.hasData) {
          return _customer_inf(context, customer.data);
        } else {
          return Center(
              child: Text(
            'nodata'.tr().toString(),
            style: Styles.Styles().textStyle_nodata,
          ));
        }
      });
}

Widget _customer_inf(BuildContext context, Customer customer) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        margin: EdgeInsets.only(bottom: 45.h),
        padding: EdgeInsets.only(bottom: 130.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          color: Constance.product_details2,
        ),
        height: 380.h,
        child: Padding(
          padding: _padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Image(
                      width: 100.w,
                      height: 100.w,
                      image: AssetImage("res/images/custom.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customer.name,
                              style: TextStyle(
                                fontSize: Styles.Styles().fontSize_name,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              customer.phone_number,
                              style: TextStyle(
                                fontSize: Styles.Styles().fontSize_subname,
                                color: Colors.white,
                              ),
                            ),
                            InkResponse(
                              onTap: () {
                                Navigator.pushNamed(context, "/customers");
                              },
                              child: Text(
                                "all_customer".tr().toString(),
                                style: TextStyle(
                                  fontSize: Styles.Styles().fontSize_subname,
                                  color: Constance.product_details1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 15.h),
                              width: 50.w,
                              height: 50.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.blue[100],
                                        spreadRadius: 2,
                                        blurRadius: 2)
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                  onPressed: () async {
                                    final telephony = Telephony.instance;
                                    await telephony
                                        .openDialer(customer.phone_number);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 50.w,
                              height: 50.w,
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white54,
                                        spreadRadius: 2,
                                        blurRadius: 2)
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.email_outlined,
                                      color: Colors.white, size: 20.sp),
                                  onPressed: () async {
                                    String _result = await sendSMS(
                                            message: "",
                                            recipients: [customer.phone_number])
                                        .catchError((onError) {
                                      print(onError);
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: _padding,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          height: 130.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Color(0XFF35557E), spreadRadius: 1, blurRadius: 5)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    color: Constance.product_details2,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Image(
                    image: AssetImage("res/images/car_white.png"),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "complete_operaction".tr().toString(),
                          style: TextStyle(
                            fontSize: Styles.Styles().fontSize_name,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          customer.complete_operation.toString(),
                          style: TextStyle(
                            fontSize: Styles.Styles().fontSize_name,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.w),
                      width: 60.w,
                      height: 60.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Constance.product_details2,
                          // border: Border.all(
                          //   color: Color(0XFF35557E),
                          //   width: 5,
                          // ),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0XFF35557E),
                                spreadRadius: 3,
                                blurRadius: 5)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, "/operations/${customer.id}");
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
