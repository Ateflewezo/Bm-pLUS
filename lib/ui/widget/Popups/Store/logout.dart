import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
// For Image Picker

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

import 'package:service_app/control/modules/store.dart';

Logout_Alert(BuildContext context) {
  // set up the button
  final _formKey = GlobalKey<FormState>();
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: SingleChildScrollView(
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        width: 750,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ))
              ],
            ),
            _info('logout_txt'.tr().toString()),
            SizedBox(
              height: 30.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF69ADFC),
                  child: Container(
                    alignment: Alignment.center,
                    width: 130.w,
                    height: 80.h,
                    child: Text(
                      "verf".tr().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Styles().fontSize_name,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await Store().setlogout();
                    Navigator.pushNamedAndRemoveUntil(context,
                        "/test_onboarding", (Route<dynamic> route) => false);
                  },
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF808080),
                  child: Container(
                    alignment: Alignment.center,
                    width: 130.w,
                    height: 80.h,
                    child: Text(
                      "cancel".tr().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Styles().fontSize_name,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  ;

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

_info(String txt) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 200.w,
        height: 200.w,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          //  fit: BoxFit.cover,
          backgroundImage: AssetImage(
            "res/images/logout.jpg",
          ),
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Styles().fontSize_name,
          fontWeight: FontWeight.normal,
        ),
      )
    ],
  );
}
