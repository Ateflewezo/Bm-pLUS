import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/widget/Popups/user/update.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class Show_info extends StatefulWidget {
  User user;
  Show_info({this.user});
  @override
  _Show_infoState createState() => _Show_infoState();
}

class _Show_infoState extends State<Show_info> {
  bool edite = false;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        width: 700.w,
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
                  "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
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
                        size: 18.sp,
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
                    user: widget.user,
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 150.w,
                          height: 150.w,
                          child: widget.user.imageURL != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10000.0),
                                  child: CachedNetworkImage(
                                    width: 150.w,
                                    height: 150.w,
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.cover,
                                    // placeholder: (context, url) => CircularProgressIndicator(),
                                    imageUrl: widget.user.imageURL,
                                  ),
                                )
                              : new Container(
                                  width: 150.w,
                                  height: 150.w,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "res/images/pfofil1.png",
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
                              "fullname".tr().toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Styles().fontSize_name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              "  : " + widget.user.name,
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
                              "grad".tr().toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Styles().fontSize_name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              "  : " + widget.user.type.tr().toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: Styles().fontSize_name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Color(0xFF69ADFC),
                          child: Container(
                            alignment: Alignment.center,
                            // width: 150.w,
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

Future Open_UserSettingAlert(BuildContext context, User user) async {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Show_info(
      user: user,
    ),
  );

  // show the dialog
  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
