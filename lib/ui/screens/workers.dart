import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_app/ui/menu/drawer_side.dart';
import 'package:service_app/ui/widget/ListViews/worker/worker_list.dart';

import '../menu/botton_navigation.dart';
import '../tooles/constants/styles.dart' as styles;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Workers extends StatefulWidget {
  @override
  _WorkersState createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _operation_page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _barApp(),
        drawer: Drawer_Side(),
        bottomNavigationBar: BottonNavigation(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatinButton(
          isopearation: false,
        ),
        body: List_Workers());
  }

  _barApp() {
    return new PreferredSize(
      child: new Container(
        padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: new Padding(
          padding: EdgeInsets.only(left: 50.h, right: 50.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotatedBox(
                quarterTurns:
                    EasyLocalization.of(context).locale == Locale("en", "US")
                        ? 2
                        : 0,
                child: IconButton(
                  icon: Image(
                    image: AssetImage("res/images/menu_white.png"),
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
              ),
              Text(
                "workers_list".tr().toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold),
              ),
              RotatedBox(
                quarterTurns:
                    EasyLocalization.of(context).locale == Locale("en", "US")
                        ? 4
                        : 1,
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.transparent,
                    // size: 20.sp,
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, "/search");
                  },
                ),
              )
            ],
          ),
        ),
        decoration: new BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0XFF37DCC6), Color(0XFF175CB2)]),
          // boxShadow: [
          //   new BoxShadow(
          //     color: Colors.grey[500],
          //     blurRadius: 20.0,
          //     spreadRadius: 1.0,
          //   )
          // ]
        ),
      ),
      preferredSize: new Size(750.w, 100.h),
    );
  }
}
