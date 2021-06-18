import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/menu/botton_navigation.dart';
import 'package:service_app/ui/menu/drawer_side.dart';
import 'package:service_app/ui/widget/ListViews/services/service_list.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as styles;

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  var _padding = const EdgeInsets.symmetric(horizontal: 25);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leadingWidth: 100,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.grey[50],
        leading: RotatedBox(
          quarterTurns:
              EasyLocalization.of(context).locale == Locale("en", "US") ? 2 : 0,
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
            'services'.tr().toString(),
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
      body: Padding(
        padding: _padding,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                  child: List_Services(
                isoffer: false,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
