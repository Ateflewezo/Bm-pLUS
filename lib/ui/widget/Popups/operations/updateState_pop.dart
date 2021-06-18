import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/messages.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';
import '../../operation_tools.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Operation_update(BuildContext context, Operation_provider operation, String s) {
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
                // Text('add_user_info'.tr().toString()),
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
            // operation.state == 3
            //     ? _info('complet_txt'.tr().toString())
            //     :
            _info(
              "operation_msg_update".tr(namedArgs: {
                'state0': operation.id,
                'state1': Operation_state(operation.state).tr(),
                'state2': Operation_state(operation.state + 1).tr()
              }, args: [
                ''
              ]),
            ),
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
                  color: Color(0xFF69ADFC),
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.w,
                    height: 80.h,
                    child: Text(
                      "verf".tr().toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Styles().fontSize_name),
                    ),
                  ),
                  onPressed: () {
                    //////////////////////////send message to customer
                    Stream storeStream =
                        Stream.fromFuture(Store().getStore_data());
                    storeStream.listen((event) {
                      Store_classe store_classe = event;

                      Message_provider().Send_Message_(
                          "operation_msg".tr(namedArgs: {
                            'state0': operation.id,
                            'state1': Operation_state(operation.state).tr(),
                            'state2': Operation_state(operation.state + 1).tr(),
                          }, args: [
                            ''
                          ])
                          // +
                          // "\n " +
                          // store_classe.name
                          ,
                          [operation.customer.phone_number]);

                      //////////update operation
                      operation.state++;
                      // if (operation.state == 4) {
                      //   operation.paid =
                      //       operation.product_total + operation.service_total;
                      // }
                      Operations_provider operations_provider =
                          Operations_provider();
                      operations_provider
                          .updateOperation(
                              operation, operation.uid, store_classe.id)
                          .then((value) {});
                      Navigator.of(context).pop();
                      s != null ? Navigator.popAndPushNamed(context, s) : null;
                    });
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
                          fontSize: Styles().fontSize_name),
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
  double tot = operation.service_total + operation.product_total;
  if ((tot - operation.paid != 0) && operation.state == 3) {
    EasyLoading.showError("should_paid".tr().toString());
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

_info(String txt) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
          width: 150.w,
          height: 150.w,
          child: FutureBuilder(
            future: Store().getStore_data(),
            builder: (context, snapshot_store) {
              if (snapshot_store.hasData) {
                return snapshot_store.data.image != null
                    ? Container(
                        width: 150.w,
                        height: 150.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10000.0),
                          child: CachedNetworkImage(
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => new Container(
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
                        width: 150.w,
                        height: 150.w,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                "res/images/logo.png",
                              ), // picked file
                              fit: BoxFit.fill),
                        ));
              } else {
                return Center(
                  child: Text(
                    'loading'.tr().toString(),
                    style: Styles().textStyle_nodata,
                  ),
                );
              }
            },
          )),
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
