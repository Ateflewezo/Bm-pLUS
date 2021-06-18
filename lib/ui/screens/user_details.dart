import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/control/services/users.dart';
import 'package:service_app/ui/widget/ListViews/permission_list.dart';
import 'package:service_app/ui/widget/Popups/user/show_inf.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as Styles;

import 'package:service_app/control/modules/store.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class User_Details extends StatefulWidget {
  String id;
  User_Details({this.id});

  @override
  _User_DetailsState createState() => _User_DetailsState();
}

int _operation_page = 1;

class _User_DetailsState extends State<User_Details> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var _padding = EdgeInsets.symmetric(horizontal: 50.w);

    return FutureBuilder<User>(
        future: Users_provider().getUserById(
            widget.id), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<User> user) {
          if (user.hasData) {
            return details(user.data, context);
          } else {
            return Center(
                child: Text(
              'loading'.tr().toString(),
              style: Styles.Styles().textStyle_nodata,
            ));
          }
        });
  }
}

Widget details(User user, BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        leadingWidth: 200.w,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Constance.icon_color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          SizedBox(
            width: 80.w,
          )
        ],
        title: Center(
          child: Text(
            'user_pirmiss'.tr().toString(),
            style: TextStyle(
                color: Constance.icon_color,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView(
        children: [
          _widget_top(context, user),
        ],
      ));
}

Widget _widget_top(BuildContext context, User user) {
  var _padding = EdgeInsets.symmetric(horizontal: 50.w);
  return Container(
    height: 1330.h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: _padding,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      width: 150.w,
                      height: 150.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10000.0),
                          border: Border.all(color: Colors.blue, width: 2)),
                      child: user.imageURL != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10000.0),
                              child: CachedNetworkImage(
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => CircleAvatar(
                                  backgroundImage:
                                      AssetImage("res/images/profil1.png"),
                                ),
                                imageUrl: user.imageURL,
                              ),
                            )
                          : new Container(
                              decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                    "res/images/profil1.png",
                                  ), // picked file
                                  fit: BoxFit.fill),
                            )),
                    ),
                    Container(
                      width: 50.w,
                      height: 50.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white38,
                                spreadRadius: 1,
                                blurRadius: 1)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: IconButton(
                          icon: Image(
                            image: AssetImage("res/images/settings.png"),
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Stream userStream =
                                Stream.fromFuture(Store().getStore_Info());
                            userStream.listen((event) {
                              User user_listes = event;
                              print(
                                  'users_permissions ${event.users_permissions[1].value}');
                              if (user_listes.users_permissions[1].value) {
                                Open_UserSettingAlert(context, user);
                              } else {
                                NO_Permissions(context);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: Styles.Styles().fontSize_name,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      user.type.tr().toString(),
                      style: TextStyle(
                          fontSize: Styles.Styles().fontSize_subname,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: _padding,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text("oper_permiss".tr().toString(), style: Styles.title_style),
                SizedBox(
                  height: 20.h,
                ),
                Card(
                    shadowColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15.h),
                      child: List_operations_perm(
                        permissions: user.operations_permissions,
                        tab_name: 'operations_permissions',
                        user_id: user.id,
                      ),
                    )),
                SizedBox(
                  height: 40.h,
                ),
                Text("service_permiss".tr().toString(),
                    style: Styles.title_style),
                SizedBox(
                  height: 20.h,
                ),
                Card(
                    shadowColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.h)),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15.h),
                      child: List_operations_perm(
                        permissions: user.services_permissions,
                        tab_name: 'services_permissions',
                        user_id: user.id,
                      ),
                    )),
                SizedBox(
                  height: 40.h,
                ),
                Text("prod_permiss".tr().toString(), style: Styles.title_style),
                SizedBox(
                  height: 20.h,
                ),
                Card(
                    shadowColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.h)),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15.h),
                      child: List_operations_perm(
                        permissions: user.products_permissions,
                        tab_name: 'products_permissions',
                        user_id: user.id,
                      ),
                    )),
                SizedBox(
                  height: 40.h,
                ),
                Text("user_pirmiss".tr().toString(), style: Styles.title_style),
                SizedBox(
                  height: 20.h,
                ),
                Card(
                    shadowColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.h)),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15.h),
                      child: List_operations_perm(
                        permissions: user.users_permissions,
                        tab_name: 'users_permissions',
                        user_id: user.id,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
