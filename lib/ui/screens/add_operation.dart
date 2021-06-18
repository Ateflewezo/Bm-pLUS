import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/modules/customer.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/customers.dart';
import 'package:service_app/ui/menu/botton_navigation.dart';
import 'package:service_app/ui/menu/drawer_side.dart';
import 'package:service_app/ui/widget/ListViews/products/product_list_inoperation.dart';
import 'package:service_app/ui/widget/ListViews/services/service_list_inoperation.dart';
import 'package:service_app/ui/widget/operation_tools.dart';
import 'package:telephony/telephony.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as Styles;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Add_operation extends StatefulWidget {
  String id;
  Add_operation({@required this.id});
  @override
  _Add_operationState createState() => _Add_operationState();
}

var _padding = EdgeInsets.symmetric(horizontal: 50.w);
int _operation_page = 1;
var bloc;

class _Add_operationState extends State<Add_operation> {
  Customers_provider customers_provider = Customers_provider();
  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<Operation_provider>(context, listen: false);

    return FutureBuilder<Customer>(
        future: customers_provider.getcustomerById(widget.id),
        // :, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Customer> customer) {
          if (customer.hasData) {
            bloc.addCustomer(customer.data);
            print("new customer ${bloc.customer.name.toString()}");

            // return Center(child: Text('loading'.tr().toString()));

            return detaits(bloc);
          } else {
            return Center(child: Text('loading'.tr().toString()));
          }

          // if (bloc.customer == null) {

          // } else {
          //   print(" already exist ${bloc.customer.name.toString()}");
          //   // return detaits(bloc);
          // }
        });
  }

  Widget detaits(Operation_provider data) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leadingWidth: 200.w,
          shadowColor: Colors.transparent,
          backgroundColor: Constance.product_details2,
          leading: RotatedBox(
            quarterTurns:
                EasyLocalization.of(context).locale == Locale("en", "US")
                    ? 2
                    : 0,
            child: IconButton(
              icon: Image(
                color: Constance.product_details1,
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
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Constance.product_details1,
                ),
                onPressed: () {
                  bloc.liber();
                  Navigator.pushNamedAndRemoveUntil(context, "/test_onboarding",
                      (Route<dynamic> route) => false);
                  // Navigator.of(context).popAndPushNamed("/home");
                },
              ),
            )
          ],
          title: Center(
            child: Text(
              'addoperation'.tr().toString(),
              style:
                  TextStyle(color: Constance.product_details1, fontSize: 28.sp),
            ),
          ),
        ),
        drawer: Drawer_Side(),
        bottomNavigationBar: BottonNavigation(
            // isoperator: true,
            ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatinButton(
          isopearation: true,
        ),
        body: ListView(
          children: [
            _stack_top(context, data.customer),
            Container(
              height: 1330.h,
              alignment: Alignment.topRight,
              padding: _padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                          color: Color(0xFF438BE8),
                          child: Container(
                            width: 250.w,
                            alignment: Alignment.center,
                            height: 80.h,
                            child: Text(
                              "add_product_to_oper".tr().toString(),
                              style: TextStyle(
                                fontSize: Styles.Styles().fontSize_name,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/add_product_to_oper');
                          },
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                          color: Color(0xFF13AC97),
                          child: Container(
                            alignment: Alignment.center,
                            width: 250.w,
                            height: 80.h,
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
                        ),
                      ],
                    ),
                  ),

                  data != null
                      ? Operation_moment(context, data, null)
                      : SizedBox(),
                  Container(
                    width: 750.w,
                    child: Text(
                      "service_added".tr().toString(),
                      style: Styles.suptitle_style,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Flexible(
                      flex: 2,
                      child: List_service_inOperation(
                        serviceslist: [],
                      )),
                  // /list service
                  SizedBox(
                    height: 20.h,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "product_added".tr().toString(),
                      style: Styles.suptitle_style,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Flexible(
                      flex: 2, child: List_products_inOperation(context, [])),
                ],
              ),
            ),
          ],
        ));
  }
}

Widget _stack_top(BuildContext context, Customer customer) {
  print("customer ${customer.toString()}");
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        margin: EdgeInsets.only(bottom: 50.h),
        padding: EdgeInsets.only(bottom: 130.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          color: Constance.product_details2,
        ),
        height: 420.h,
        child: Padding(
          padding: _padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                    size: 18.sp,
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
                                      color: Colors.white, size: 18.sp),
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
          padding: EdgeInsets.symmetric(horizontal: 10.h),
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
                      width: 50,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.h),
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
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context,
                                "/operations/${customer.phone_number}");
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
