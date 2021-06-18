import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:service_app/control/services/store.dart';
import 'edite_setting.dart';
import 'package:service_app/control/modules/user.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class Open_Setting extends StatefulWidget {
  @override
  _Open_SettingState createState() => _Open_SettingState();
}

class _Open_SettingState extends State<Open_Setting> {
  bool edite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750,
      // height: 800.h,
      child: FutureBuilder(
        future: Store().getStore_Info(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _store_info(snapshot.data);
          } else {
            return Text(
              'loading'.tr().toString(),
              style: Styles().textStyle_nodata,
            );
          }
        },
      ),
    );
  }

  Widget _store_info(User data) {
    print("store_id ${data.store_id}");
    return FutureBuilder(
        future: Stores_provider().login(data),
        builder: (context, store) {
          if (store.hasData) {
            print("store ${store.data.toJson()}");

            if (store.data != null) {
              return _details(store.data);
            } else {
              return Center(
                  child: Text(
                'nodata'.tr().toString(),
                style: Styles().textStyle_nodata,
              ));
            }
          } else {
            return Center(
                child: Text(
              'loading'.tr().toString(),
              style: Styles().textStyle_nodata,
            ));
          }
        });
  }

  Widget _details(Store_classe data) {
    return SingleChildScrollView(
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        width: 750,
        // height: 440,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "app_setting".tr().toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Styles().fontSize_name,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.grey[200]),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20.sp,
                      ),
                      onPressed: () async {
                        await EasyLoading.dismiss();
                        Navigator.of(context).pop();
                      },
                    ))
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            edite
                ? Edite_Info(
                    store: data,
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          width: 150.w,
                          height: 150.w,
                          child: data.image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10000.0),
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
                                    imageUrl: data.image,
                                  ),
                                )
                              : Container(
                                  decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "res/images/logo.png",
                                      ), // picked file
                                      fit: BoxFit.fill),
                                )),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "name".tr().toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Styles().fontSize_name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              " ${data.name} ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: Styles().fontSize_name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "sms_phone".tr().toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Styles().fontSize_name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              " ${data.sms_number} ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: Styles().fontSize_name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "action_typ".tr().toString(),
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.normal,
                        //       ),
                        //     ),
                        //     Text(
                        //       "مغسلة ",
                        //       style: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.normal,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // SizedBox(
                        //   height: 10,
                        // ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "coin".tr().toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Styles().fontSize_name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              " " + data.unite,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: Styles().fontSize_name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Color(0xFF69ADFC),
                          child: Container(
                            alignment: Alignment.center,
                            // width: 90,
                            height: 80.h,
                            child: Text(
                              "edite_info".tr().toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Styles().fontSize_name,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              edite = true;
                            });
                            // if (_formKey.currentState.validate()) {
                            //   // Navigator.of(context).pop();
                            //   // Navigator.pushNamed(context, '/add_operation');
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
            ////
          ],
        ),
      ),
    );
  }
}

Future Open_SettingAlert(BuildContext context) async {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Open_Setting(),
  );

  // show the dialog
  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
