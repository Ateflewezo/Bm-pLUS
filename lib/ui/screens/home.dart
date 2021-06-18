import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/services/locator.dart';
import 'package:service_app/control/services/messages.dart';
import 'package:service_app/control/services/store.dart';
import 'package:service_app/control/services/users.dart';
import 'package:service_app/ui/menu/drawer_side.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Charts/home.dart';
import 'package:service_app/ui/widget/ListViews/operation/operation_list.dart';
import 'package:service_app/ui/widget/Popups/Store/status_off.dart';
import 'package:service_app/ui/widget/onBoarding/offers.dart';
import '../menu/botton_navigation.dart';
import '../tooles/constants/styles.dart' as styles;
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool isConnected = false;
connect_msg(bool isConnected) {
  if (isConnected) {
    EasyLoading.showToast(
      "get_connection".tr().toString(),
      toastPosition: EasyLoadingToastPosition.center,
    );
    // return true;
  } else {
    EasyLoading.showToast(
      "lost_connection".tr().toString(),
      duration: Duration(seconds: 10),
      toastPosition: EasyLoadingToastPosition.center,
      // maskType: EasyLoadingMaskType.values,
      dismissOnTap: true,
    );
  }
}

Future<bool> Check() async {
  try {
    final result = await InternetAddress.lookup(
        'firebase.google.com'); //https://firebase.google.com
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // do the operation for connected, or change the bool to True for connected
      // isConnected = true;

      isConnected = true;
      connect_msg(isConnected);
      return isConnected;
      // setState(() {
      //   isConnected = true;
      //   connect_msg(isConnected);
      // });
    }
  } on SocketException catch (_) {
    // isConnected = false;
    isConnected = false;
    connect_msg(isConnected);
    return isConnected;

    // setState(() {
    //   isConnected = false;
    //   connect_msg(isConnected);
    // });
  }
// use try-catch to do this operation, so that to get the control over this
// operation better

  // var connResult = await (Connectivity().checkConnectivity());
  // if (connResult == ConnectivityResult.mobile) {
  //   EasyLoading.showToast(
  //     "get_connection".tr().toString(),
  //     toastPosition: EasyLoadingToastPosition.bottom,
  //   );
  //   return true;
  // } else if (connResult == ConnectivityResult.wifi) {
  //   EasyLoading.showToast(
  //     "get_connection".tr().toString(),
  //     toastPosition: EasyLoadingToastPosition.center,
  //   );
  //   return true;
  // }

  // EasyLoading.showToast(
  //   "lost_connection".tr().toString(),
  //   duration: Duration(seconds: 10),
  //   toastPosition: EasyLoadingToastPosition.center,
  //   // maskType: EasyLoadingMaskType.values,
  //   dismissOnTap: true,
  // );
  // return false;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _padding = EdgeInsets.symmetric(horizontal: 50.w);
  int _operation_page = 1;

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Check();
    _refrech_store_info();
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
              'home'.tr().toString(),
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
                height: 20.h,
              ),
              Padding(
                padding: _padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('lastoffers'.tr().toString(),
                        style: styles.suptitle_style),
                    TextButton(
                      child: Text(
                        'seeall'.tr().toString(),
                        style: TextStyle(fontSize: Styles().fontSize_seeall),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/offers");
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                // padding: _padding,
                height: 350.h,

                child: OffersScreen(),
              ),
              Padding(
                padding: _padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Statistics'.tr().toString(),
                      style: styles.title_style,
                    ),
                    TextButton(
                      child: Text(
                        'seeall'.tr().toString(),
                        style: TextStyle(fontSize: Styles().fontSize_seeall),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/satistics");
                      },
                    )
                  ],
                ),
              ),
              Container(
                height: 650.h,
                child: Padding(
                  padding: _padding,
                  child: ChartSp(),
                ),
              ),
              Padding(
                padding: _padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'lastoperations'.tr().toString(),
                      style: styles.title_style,
                    ),
                    TextButton(
                      child: Text(
                        'seeall'.tr().toString(),
                        style: TextStyle(fontSize: Styles().fontSize_seeall),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/operations/");
                      },
                    )
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            new RotatedBox(
                              quarterTurns: 5,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _operation_page = 1;
                                  });
                                },
                                child: new Text(
                                  'wating'.tr().toString(),
                                  style: TextStyle(
                                    fontSize: styles.Styles().fontSize_subname,
                                    color: _operation_page == 1
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 8.w,
                              height: 8.w,
                              margin: EdgeInsets.only(left: 50.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _operation_page == 1
                                    ? Colors.blue
                                    : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            new RotatedBox(
                                quarterTurns: 5,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _operation_page = 2;
                                    });
                                  },
                                  child: new Text(
                                    'current'.tr().toString(),
                                    style: TextStyle(
                                      fontSize:
                                          styles.Styles().fontSize_subname,
                                      color: _operation_page == 2
                                          ? Colors.blue
                                          : Colors.grey,
                                      // fontWeight: FontWeight.w600
                                    ),
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 50.w),
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _operation_page == 2
                                      ? Colors.blue
                                      : Colors.transparent),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                        child:
                            List_operations(_operation_page, '', '', "/home")),
                  ),
                  SizedBox(
                    width: 27.w,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void _refrech_store_info() {
    Stream.fromFuture(Store().getStore_Info()).listen((event_user) {
      _refrech_user_inf(event_user.phone_number);
      Stream.fromFuture(Stores_provider().login(event_user)).listen((event) {
        Message_provider().fetchMessages();
        // setuplocator_message_write('Users/${event.sms_number}/messages');
        if (event.status == false) {
          Status_OFF(context);
        }
      });
    });
  }

  void _refrech_user_inf(String id) {
    Stream stream_user =
        new Stream.fromFuture(Users_provider().getUserById(id));
    stream_user.listen((user) {
      Store().setloginData(user, true);
    });
  }
}
