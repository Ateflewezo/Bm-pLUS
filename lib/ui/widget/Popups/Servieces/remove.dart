import 'package:flutter/material.dart';
import 'package:service_app/ui/widget/Popups/operations/dalete.dart';
import '../../../../control/modules/service.dart';
import '../../../../control/services/services.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

Setvice_delete(BuildContext context, Service service) {
  // set up the button
  final _formKey = GlobalKey<FormState>();
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: SingleChildScrollView(
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        width: 700.w,
        // height: 440,
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
            _info('dalet_ser_Q'.tr().toString()),
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFFF94444),
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.w,
                    height: 80.h,
                    child: Text(
                      "verf".tr().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Styles().fontSize_name,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Services_provider services_provider = Services_provider();

                    services_provider.removeService(
                        service.id, service.imageURL);
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF808080),
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.w,
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
        width: 150.w,
        height: 150.w,
        child: image_Logo_(),
        
        // CircleAvatar(
        //   backgroundColor: Colors.grey,
        //   //  fit: BoxFit.cover,
        //   backgroundImage: AssetImage(
        //     "res/images/car2.png",
        //   ),
        // ),
      ),
      SizedBox(
        height: 10,
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
