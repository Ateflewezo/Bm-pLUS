import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:service_app/control/services/customers.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../../widget/currency_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/customer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

//IconData icon, String title, String subTitle) {
Widget Customer_Row(BuildContext context, Customer customer) {
  return Slidable(
      // delegate: new SlidableDrawerDelegate(),+
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        Container(
          height: 200.h,
          width: 80.w,
          decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 35.sp,
            ),
            onPressed: () {
              if (customer.complete_operation != 0) {
                EasyLoading.showError("hav_operation".tr().toString());
                return;
              }

              Customers_provider().removecustomer(customer.id, '');
              Navigator.popAndPushNamed(context, '/customers');
            },
          ),

          // onTap: () => _showSnackBar('Share'),
        ),
      ],
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.grey,
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          height: 150.h,
          alignment: Alignment.topCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Image(
                    // height: 150,
                    fit: BoxFit.fill,
                    image: AssetImage("res/images/custom.png"),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        customer.name,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Styles().fontSize_name,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            customer.complete_operation.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: Styles().fontSize_name,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'operations'.tr().toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: Styles().fontSize_subname,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  // adapter_currency(context, 400, Colors.grey, 16.0),
                  TextButton(
                    child: Text(
                      'show_all_operator'.tr().toString(),
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/customer_details/${customer.id}');
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ));
}
