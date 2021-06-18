import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:service_app/control/modules/monthes.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:service_app/control/services/worker.dart';
import 'package:service_app/ui/widget/ListViews/payment_list.dart';
import 'package:service_app/ui/widget/Popups/Workers/paid_worker.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as Styles;
import '../widget/Popups/Workers/show_n_edit_pop.dart';
import '../widget/currency_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:telephony/telephony.dart';

class Worker_Details extends StatefulWidget {
  String id;
  Worker_Details({this.id});

  //  Worker worker =await workers_provider.getWrokerById(id);
  @override
  _Worker_DetailsState createState() => _Worker_DetailsState();
}

var _padding = EdgeInsets.symmetric(horizontal: 50.w);
int _operation_page = 1;

class _Worker_DetailsState extends State<Worker_Details> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _current_month = DateTime.now().month.toString();
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(new DropdownMenuItem(
      value: "00",
      child: new Text("select_month".tr().toString()),
      onTap: () {
        setState(() {
          // EasyLocalization.of(context).locale = Locale("ar", "SA");
        });
      },
    ));

    for (var item in getmonthes(context)) {
      items.add(new DropdownMenuItem(
        value: item.value,
        child: new Text(item.name),
      ));
    }

    return items;
  }

  void changedDropDownItem(String current_month) {
    setState(() {
      _current_month = current_month;
    });
  }

  Workers_provider workers_provider = Workers_provider();

  @override
  Widget build(BuildContext context) {
    _dropDownMenuItems = getDropDownMenuItems();
    return FutureBuilder<Worker>(
        future: workers_provider.getWrokerById(
            widget.id), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Worker> worker) {
          if (worker.hasData) {
            return details(worker);
          } else {
            return Center(
                child: Text('loading'.tr().toString(),
                    style: Styles.Styles().textStyle_nodata));
          }
        });
  }

  Widget details(AsyncSnapshot<Worker> worker) {
    double _w = 210.w, _h = 200.h;
    return Scaffold(
        appBar: _appbar(context),
        body: ListView(
          children: [
            _stack_top(context, worker.data),
            Container(
              height: 1330.h,
              alignment: Alignment.topRight,
              padding: _padding,
              child: Column(
                children: [
                  Container(
                    width: 750.w,
                    margin: EdgeInsets.only(top: 20.h),
                    child: Container(
                      width: 150.w,
                      child: DropdownButton(
                        // iconEnabledColor: false,
                        // dropdownColor: Colors.transparent,
                        focusColor: Colors.transparent,

                        value: _current_month,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: _w,
                          height: _h,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 2,
                                color: Colors.grey,
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Constance.product_details2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "salaire1".tr().toString(),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Styles.Styles().fontSize_name,
                                    color: Colors.white),
                              ),
                              Satictic_currency(
                                  context,
                                  worker.data.salery,
                                  Colors.white,
                                  Styles.Styles().fontSize_price),
                              Text(
                                paid(worker.data)
                                    ? "paid".tr().toString()
                                    : "unpaid".tr().toString(),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Styles.Styles().fontSize_name,
                                    color: paid(worker.data)
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: _w,
                          height: _h,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 0.5,
                                spreadRadius: 0.5,
                                color: Colors.grey,
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            // border: Border.all(),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "tot_comission".tr().toString(),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Styles.Styles().fontSize_name,
                                ),
                              ),
                              Satictic_currency(
                                  context,
                                  worker.data.comission -
                                      worker.data.comission_paid,
                                  Colors.black,
                                  Styles.Styles().fontSize_price),
                              // Text(
                              //   "rest_amont".tr().toString(),
                              //   maxLines: 1,
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     fontSize: Styles.Styles().fontSize_subname,
                              //   ),
                              // ),
                              // Satictic_currency(
                              //     context,
                              //     worker.data.comission -
                              //         worker.data.comission_paid,
                              //     Colors.red,
                              //     Styles.Styles().fontSize_price),
                            ],
                          ),
                        ),
                        Container(
                          width: _w,
                          height: _h,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 0.5,
                                spreadRadius: 0.5,
                                color: Colors.grey,
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            // border: Border.all(),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "paidup".tr().toString(),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Styles.Styles().fontSize_name,
                                ),
                              ),
                              Satictic_currency(
                                  context,
                                  worker.data.total_paid,
                                  Colors.black,
                                  Styles.Styles().fontSize_price),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: 750.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "payments".tr().toString(),
                          style: Styles.suptitle_style,
                        ),
                        Container(
                          width: 140.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: Colors.grey,
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(),
                            color: Constance.product_details2,
                          ),
                          child: InkResponse(
                            onTap: () {
                              Paid_worker(context, worker.data);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Image(
                                  color: Colors.white,
                                  image: AssetImage("res/images/pay.png"),
                                ),
                                Text(
                                  "pay".tr().toString(),
                                  style: TextStyle(
                                      fontSize:
                                          Styles.Styles().fontSize_subname,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Flexible(flex: 2, child: List_payments(_current_month)),
                ],
              ),
            ),
          ],
        ));
  }
}

bool paid(Worker data) {
  DateTime now = DateTime.now();

  return (data.salaire &&
          data.salaire_month == now.month.toString() &&
          data.salaire_year == now.year.toString())
      ? true
      : false;
}

Widget _appbar(BuildContext context) {
  return AppBar(
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
              EasyLocalization.of(context).locale == Locale("en", "US") ? 4 : 1,
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
        'worker_details'.tr().toString(),
        style: TextStyle(
            color: Constance.product_details1,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget _stack_top(BuildContext context, Worker worker) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        margin: EdgeInsets.only(bottom: 80.h),
        padding: EdgeInsets.only(bottom: 130.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          color: Constance.product_details2,
        ),
        height: 450.h,
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
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: worker.imageURL != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10000.0),
                                child: CachedNetworkImage(
                                  height: 120.w,
                                  width: 120.w,
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => CircleAvatar(
                                    backgroundImage:
                                        AssetImage("res/images/logo.png"),
                                  ),
                                  imageUrl: worker.imageURL,
                                ),
                              )
                            : new Container(
                                height: 120.w,
                                width: 120.w,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "res/images/upload.png",
                                      ), // picked file
                                      fit: BoxFit.fill),
                                )),
                      ),
                      Container(
                        width: 60.w,
                        height: 60.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Constance.product_details1,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white38,
                                  spreadRadius: 2,
                                  blurRadius: 5)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: IconButton(
                            icon: Image(
                              image: AssetImage("res/images/settings.png"),
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Open_WorkerSettingAlert(context, worker);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              worker.name,
                              style: TextStyle(
                                fontSize: Styles.Styles().fontSize_subname,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Text(
                              worker.phone_number,
                              style: TextStyle(
                                fontSize: Styles.Styles().fontSize_name,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "salaire1".tr().toString(),
                              style: TextStyle(
                                fontSize: Styles.Styles().fontSize_subname,
                                color: Constance.product_details1,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 30.h),
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
                                        .openDialer(worker.phone_number);
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
                                            recipients: [worker.phone_number])
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: 150.h,
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
                          worker.complete_operation.toString(),
                          style: TextStyle(
                            fontSize: Styles.Styles().fontSize_name,
                            color: Colors.black,
                          ),
                        ),
                      ],
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
                            Navigator.popAndPushNamed(
                                context, '/worker_operations');
                          },
                        ),
                      ),
                    ),
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
