import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/widget/Popups/Store/logout.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:service_app/ui/widget/Popups/Store/show_setting.dart';
import '../tooles/constants/styles.dart' as styles;
import 'package:package_info/package_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Drawer_Side extends StatefulWidget {
  @override
  _Drawer_SideState createState() => _Drawer_SideState();
}

class _Drawer_SideState extends State<Drawer_Side> {
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(new DropdownMenuItem(
      value: "العربية",
      child: new Text(
        "العربية",
        style: styles.drawer_items_style,
      ),
      onTap: () {
        setState(() {
          EasyLocalization.of(context).locale = Locale("ar", "SA");
        });
      },
    ));
    items.add(new DropdownMenuItem(
      value: "English",
      child: new Text(
        "English",
        style: styles.drawer_items_style,
      ),
      onTap: () {
        setState(() {
          EasyLocalization.of(context).locale = Locale("en", "US");
        });
      },
    ));
    return items;
  }

  User user;
  String version = "";
  String appName = "";
  String packageName = "", buildNumber = "";
  @override
  Future<void> initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      // setState((){

      // });
      buildNumber = packageInfo.buildNumber;
    });

    // print('user object ${user.toJson().toString()}');

    // user = await Store().getStore_Info();
    print('user object ${user.toString()}');
    Stream<User> user_Data = Stream.fromFuture(Store().getStore_Info());
    user_Data.listen((data) {
      print('user object ${data.toString()}');
      user = data;
    });
    _dropDownMenuItems = getDropDownMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    print('user object ${user.toString()}');
    Stream<User> user_Data = Stream.fromFuture(Store().getStore_Info());
    user_Data.listen((data) {
      print('user object ${data.toString()}');
      user = data;
    });

    EasyLocalization.of(context).locale == Locale("en", "US")
        ? _currentlan = "English"
        : _currentlan = "العربية";
    return FutureBuilder(
      future: Store().getStore_Info(),
      builder: (context, user_snp) {
        user = user_snp.data;
        print('user object ${user.toJson().toString()}');

        return Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                width: 200.w,
                height: 300.h,
                decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: const DecorationImage(
                      image: AssetImage("res/images/drawer_header.png"),
                      fit: BoxFit.cover,
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 160.w,
                            height: 160.w,
                            child:
                                user.imageURL != null && !user.imageURL.isEmpty
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10000.0),
                                        child: CachedNetworkImage(
                                          height: 100.w,
                                          width: 100.w,
                                          alignment: Alignment.topCenter,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              new Container(
                                                  height: 100.w,
                                                  width: 100.w,
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                          "res/images/logo.png",
                                                        ), // picked file
                                                        fit: BoxFit.fill),
                                                  )),
                                          imageUrl: user.imageURL,
                                        ),
                                      )
                                    : new Container(
                                        height: 100.w,
                                        width: 100.w,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "res/images/logo.png",
                                              ), // picked file
                                              fit: BoxFit.fill),
                                        )),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                user.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28.sp),
                              ),
                              subtitle: Text(
                                user.type.tr().toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 26.sp),
                              ),
                              onTap: () {
                                // Update the state of the app.
                                // ...
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "version".tr().toString() + " : " + version,
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.h),
                child: Column(
                  children: [
                    ListTile(
                      title: Align(
                          alignment: EasyLocalization.of(context).locale ==
                                  Locale("en", "US")
                              ? Alignment(-1.3, 3)
                              : Alignment(1.3, 0),
                          child: Text(
                            'products'.tr().toString(),
                            style: styles.drawer_items_style,
                          )),
                      leading: Image(
                        image: AssetImage("res/images/cart.png"),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/products");

                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Align(
                          alignment: EasyLocalization.of(context).locale ==
                                  Locale("en", "US")
                              ? Alignment(-1.3, 3)
                              : Alignment(1.3, 0),
                          child: Text(
                            'offers'.tr().toString(),
                            style: styles.drawer_items_style,
                          )),
                      leading: Image(
                        image: AssetImage("res/images/bag.png"),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/offers");

                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Align(
                          alignment: EasyLocalization.of(context).locale ==
                                  Locale("en", "US")
                              ? Alignment(-1.3, 3)
                              : Alignment(1.3, 0),
                          child: Text(
                            'operations'.tr().toString(),
                            style: styles.drawer_items_style,
                          )),
                      leading: Image(
                        image: AssetImage("res/images/cart-add.png"),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/operations/");

                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Align(
                          alignment: EasyLocalization.of(context).locale ==
                                  Locale("en", "US")
                              ? Alignment(-1.3, 3)
                              : Alignment(1.3, 0),
                          child: Text(
                            'services'.tr().toString(),
                            style: styles.drawer_items_style,
                          )),
                      leading: Image(
                        image: AssetImage("res/images/car.png"),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/services");
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Align(
                          alignment: EasyLocalization.of(context).locale ==
                                  Locale("en", "US")
                              ? Alignment(-1.3, 3)
                              : Alignment(1.3, 0),
                          child: Text(
                            'customers'.tr().toString(),
                            style: styles.drawer_items_style,
                          )),
                      leading: Image(
                        image: AssetImage("res/images/people.png"),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/customers");
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Align(
                          alignment: EasyLocalization.of(context).locale ==
                                  Locale("en", "US")
                              ? Alignment(-1.3, 3)
                              : Alignment(1.3, 0),
                          child: Text(
                            'workers'.tr().toString(),
                            style: styles.drawer_items_style,
                          )),
                      leading: Image(
                        image: AssetImage("res/images/workers.png"),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/workers");

                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Align(
                          alignment: EasyLocalization.of(context).locale ==
                                  Locale("en", "US")
                              ? Alignment(-1.3, 3)
                              : Alignment(1.3, 0),
                          child: Text(
                            'Users'.tr().toString(),
                            style: styles.drawer_items_style,
                          )),
                      leading: Image(
                        image: AssetImage("res/images/users.png"),
                      ),
                      onTap: () {
                        if (user.type == "boss") {
                          Navigator.pushNamed(context, "/users");
                        } else {
                          NO_Permissions(context);
                        }
                      },
                    ),
                    ListTile(
                      title: Align(
                          alignment: EasyLocalization.of(context).locale ==
                                  Locale("en", "US")
                              ? Alignment(-1.3, 3)
                              : Alignment(1.3, 0),
                          child: Text(
                            'Statistics'.tr().toString(),
                            style: styles.drawer_items_style,
                          )),
                      leading: Image(
                        image: AssetImage("res/images/celluar.png"),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, "/satistics");

                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Align(
                          alignment: EasyLocalization.of(context).locale ==
                                  Locale("en", "US")
                              ? Alignment(-1.3, 3)
                              : Alignment(1.3, 0),
                          child: Text(
                            'settings'.tr().toString(),
                            style: styles.drawer_items_style,
                          )),
                      leading: Image(
                        image: AssetImage("res/images/settings.png"),
                      ),
                      onTap: () {
                        // Navigator.pushNamed(context, "/app_setting");
                        // Open_Setting();
                        // Service_update(context);
                        if (user.type == "boss") {
                         Open_SettingAlert(context);
                        } else {
                          NO_Permissions(context);
                        }
                        
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Align(
                          alignment: EasyLocalization.of(context).locale ==
                                  Locale("en", "US")
                              ? Alignment(-1.3, 3)
                              : Alignment(1.3, 0),
                          child: Text(
                            'logout'.tr().toString(),
                            style: styles.drawer_items_style,
                          )),
                      leading: Image(
                        image: AssetImage("res/images/power.png"),
                      ),
                      onTap: () async {
                        Logout_Alert(context);
                        // await Store().setlogout();
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context,
                        //     "/test_onboarding",
                        //     (Route<dynamic> route) => false);
                      },
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    ListTile(
                      title: DropdownButton(
                        value: _currentlan,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      ),
                      leading: Image(
                        image: AssetImage("res/images/language.png"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentlan = "العربية";
  void changedDropDownItem(String selectedlan) {
    setState(() {
      _currentlan = selectedlan;
    });
  }
}
