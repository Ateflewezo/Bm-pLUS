import 'package:cached_network_image/cached_network_image.dart';
import 'package:service_app/ui/widget/ListViews/worker/worker_list_inaddservice.dart';
import '../../../widget/currency_text.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/modules/service.dart';
import 'package:service_app/control/provider/operation.dart';
import '../../../tooles/constants/colors_app.dart' as _color;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

showAlertDialog_addworker(BuildContext context, Service service) {
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
        height: 750.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text('add_user_info'.tr().toString()),
                InkResponse(
                  onTap: () async {
                    await EasyLoading.dismiss();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.grey[200]),
                      child: Icon(
                        Icons.close,
                        size: 18.sp,
                      )),
                )
              ],
            ),
            _service_info(service, context),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "select_worker".tr().toString(),
              style: TextStyle(
                  fontSize: Styles().fontSize_name, fontWeight: FontWeight.bold
                  // color: Colors.white,
                  ),
            ),
            Container(
              height: 250.h,
              child: List_worker_inAddservice(service),
            ),
            // Flexible(flex: 1, child: List_worker_inAddservice()),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Color(0xFF539EFF),
                child: Container(
                  alignment: Alignment.center,
                  // width: 150,
                  height: 80.h,
                  child: Text(
                    "add_service_to_operation".tr().toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Styles().fontSize_name,
                    ),
                  ),
                ),
                onPressed: () {
                  _addService_toOper(context, service);

                  // if (_formKey.currentState.validate()) {
                  //   Navigator.of(context).pop();
                  //   Navigator.pushNamed(context, '/add_operation');
                  // }
                },
              ),
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

void _addService_toOper(BuildContext context, Service service) {
  var bloc = Provider.of<Operation_provider>(context, listen: false);
  // bloc.addToServices(bloc.waiting_service);
  if (bloc.waiting_service != null &&
      bloc.waiting_service.workers.length != 0) {
    bloc.addToServices(bloc.waiting_service, true);
    Navigator.of(context).pop();
  } else {
    EasyLoading.showError('select_worker'.tr().toString());
  }
}

_service_info(Service service, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10000.0),
        child: CachedNetworkImage(
          height: 150.w,
          width: 150.w,
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          // placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: service.imageURL,
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      Container(
        width: 700.w,
        child: Text(
          'you_selected'.tr().toString(),
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: Styles().fontSize_name,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service.name,
            style: TextStyle(
              fontSize: Styles().fontSize_name,
              fontWeight: FontWeight.normal,
            ),
          ),
          adapter_currency(context, service.price, _color.product_details1,
              Styles().fontSize_price),
        ],
      ),
    ],
  );
}
