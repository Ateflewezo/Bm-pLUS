import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/ui/widget/Popups/user/add_new.dart';
import 'package:service_app/ui/widget/Tabs/tabview_users.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as styles;

import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

var _padding = EdgeInsets.symmetric(horizontal: 50.w);

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    // Store_classe store = Store_classe();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Stream userStream = Stream.fromFuture(Store().getStore_Info());
          userStream.listen((event) {
            User user = event;
            print('users_permissions ${event.users_permissions[0].value}');
            if (user.users_permissions[0].value) {
              New_UserAlert(context);
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
            'Users'.tr().toString(),
            style: styles.title_style,
          ),
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder(
            future: Store().getStore_Info(),
            builder: (context, snapshot_user) {
              if (snapshot_user.hasData) {
                return Container(
                  padding: _padding,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      FutureBuilder(
                        future: Store().getStore_data(),
                        builder: (context, snapshot_store) {
                          if (snapshot_store.hasData) {
                            return ListTile(
                              leading: snapshot_store.data.image != null
                                  ? Container(
                                      width: 100.w,
                                      height: 100.w,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10000.0),
                                        child: CachedNetworkImage(
                                          alignment: Alignment.topCenter,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              new Container(
                                                  decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  "res/images/logo.png",
                                                ), // picked file
                                                fit: BoxFit.fill),
                                          )),
                                          imageUrl: snapshot_store.data.image,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 100.w,
                                      height: 100.w,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "res/images/logo.png",
                                            ), // picked file
                                            fit: BoxFit.fill),
                                      )),
                              title: Text(
                                snapshot_store.data.name,
                                style: TextStyle(
                                    fontSize: styles.Styles().fontSize_name),
                              ),
                              subtitle: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("wllecom".tr().toString(),
                                      style: TextStyle(
                                          fontSize: styles.Styles()
                                              .fontSize_subname)),
                                  Text(
                                    " ${snapshot_user.data.name} ",
                                    style: TextStyle(
                                        fontSize:
                                            styles.Styles().fontSize_subname,
                                        color: Constance.product_details1),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                'loading'.tr().toString(),
                                style: styles.Styles().textStyle_nodata,
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'loading'.tr().toString(),
                    style: styles.Styles().textStyle_nodata,
                  ),
                );
              }
            },
          ),
          Container(height: 950.h, child: TabView_Users()),
        ],
      ),
    );
  }
}
