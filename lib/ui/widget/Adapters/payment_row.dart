import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../widget/currency_text.dart';
import 'package:service_app/control/modules/worker_payments.dart';
import '../../tooles/constants/colors_app.dart' as color;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../tooles/constants/styles.dart';

Widget Payment_Row(BuildContext context, Payment payment) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    shadowColor: Colors.grey,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      height: 160.h,
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 120.w,
                height: 150.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 1,
                      color: Colors.grey,
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: color.product_details2,
                ),
                child: Text(
                  "\$",
                  style: TextStyle(
                      fontSize: Styles().fontSize_name, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Container(
                width: 450.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          payment.date,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Styles().fontSize_name,
                          ),
                        ),
                        Text(
                          payment.type.tr().toString(),
                          style: TextStyle(
                            color: color.product_details2,
                            fontSize: Styles().fontSize_name,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "salaire".tr().toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: Styles().fontSize_subname,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        adapter_currency(context, payment.salery_rn,
                            Colors.grey, Styles().fontSize_subname),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "comission".tr().toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Styles().fontSize_subname,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        adapter_currency(context, payment.comission_rn,
                            Colors.blue[300], Styles().fontSize_subname),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "paidup".tr().toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Styles().fontSize_subname,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        adapter_currency(context, payment.paided, Colors.green,
                            Styles().fontSize_subname),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
