import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/widget/ListViews/operation/operation_list_bycustomer.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:telephony/telephony.dart';
import '../../control/services/customers.dart';
import '../../control/modules/customer.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as Styles;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customer_Details extends StatefulWidget {
  String id;
  Customer_Details({this.id});

  @override
  _Customer_DetailsState createState() => _Customer_DetailsState();
}

Customers_provider customers_provider = Customers_provider();
var _padding = EdgeInsets.symmetric(horizontal: 50.w);
int _operation_page = 1;

class _Customer_DetailsState extends State<Customer_Details> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return FutureBuilder<Customer>(
        future: customers_provider.getcustomerById(
            widget.id), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Customer> customer) {
          if (customer.hasData) {
            return details(customer);
          } else {
            return Center(
                child: Text(
              'loading'.tr().toString(),
              style: Styles.Styles().textStyle_nodata,
            ));
          }
        });
  }

  Widget details(AsyncSnapshot<Customer> customer) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Stream userStream = Stream.fromFuture(Store().getStore_Info());
            userStream.listen((event) {
              User user = event;
              print('users_permissions ${event.users_permissions[0].value}');
              if (user.operations_permissions[0].value) {
                Navigator.pushNamed(
                    context, '/add_operation/${customer.data.phone_number}');
              } else {
                NO_Permissions(context);
              }
            });
          },
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        ),
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
              'customer_details'.tr().toString(),
              style: TextStyle(
                  color: Constance.product_details1,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: ListView(
          children: [
            _stack_top(context, customer.data),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
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
                            'lastoperations'.tr().toString(),
                            style: Styles.title_style,
                          ),
                          TextButton(
                            child: Text(
                              'seeall'.tr().toString(),
                              style: TextStyle(
                                  fontSize: Styles.Styles().fontSize_seeall),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, "/operations/${customer.data.id}");
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Flexible(
                        flex: 2,
                        child:
                            List_operations_details_customer(customer.data.id)),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

Widget _stack_top(BuildContext context, Customer data) {
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15.w, right: 15.w),
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
                              data.name,
                              style: TextStyle(
                                fontSize: Styles.Styles().fontSize_name,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              data.phone_number,
                              style: TextStyle(
                                fontSize: Styles.Styles().fontSize_subname,
                                color: Colors.white,
                              ),
                            ),
                            InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "show_all_customer".tr().toString(),
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
                                        .openDialer(data.phone_number);
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
                                            recipients: [data.phone_number])
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
                          data.complete_operation.toString(),
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
                                spreadRadius: 2,
                                blurRadius: 2)
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
                                context, "/operations/${data.id}");
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
