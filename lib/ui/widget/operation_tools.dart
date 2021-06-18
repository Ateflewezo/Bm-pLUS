import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/provider/operation.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../widget/currency_text.dart';

import 'package:service_app/control/modules/store.dart';
import 'Popups/operations/paid.dart';
import '../tooles/constants/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget Operation_moment(
    BuildContext context, Operation_provider operation, String s) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 50.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "paidup".tr().toString(),
                  style: TextStyle(fontSize: Styles().fontSize_price),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Satictic_currency(context, operation.paid,
                    Constance.product_details1, Styles().fontSize_name),
              ],
            ),
            operation.id != null
                ? Row(
                    children: [
                      Text(
                        "oper_nb".tr().toString(),
                        style: TextStyle(fontSize: Styles().fontSize_name),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        operation.id,
                        style: TextStyle(
                            fontSize: Styles().fontSize_name,
                            color: Constance.product_details1),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "tot_amont".tr().toString(),
                  style: TextStyle(fontSize: Styles().fontSize_name),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Satictic_currency(
                    context,
                    operation.product_total + operation.service_total,
                    Constance.product_details1,
                    Styles().fontSize_price),
              ],
            ),
            Row(
              children: [
                Text(
                  "rest_amont".tr().toString(),
                  style: TextStyle(fontSize: Styles().fontSize_name),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Satictic_currency(
                    context,
                    (operation.product_total + operation.service_total) -
                        operation.paid,
                    Constance.product_details1,
                    Styles().fontSize_price),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "oper_satute".tr().toString(),
                  style: TextStyle(fontSize: Styles().fontSize_name),
                ),
                SizedBox(
                  width: 10.w,
                ),
                getState_Text(operation.state, Styles().fontSize_price)
              ],
            ),
            ((operation.product_total + operation.service_total) -
                        operation.paid) >
                    0
                ? Container(
                    width: 150.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 0.2,
                          spreadRadius: 0.1,
                          color: Constance.product_details1,
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.h),
                      ),
                      // border: Border.all(),
                      color: Constance.product_details1,
                    ),
                    child: InkResponse(
                      onTap: () {
                        Stream storeStream =
                            Stream.fromFuture(Store().getStore_data());
                        storeStream.listen((event) {
                          Store_classe store_classe = event;
                          Paid_operation(context, operation, s, store_classe);
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            color: Colors.white,
                            image: AssetImage("res/images/pay.png"),
                          ),
                          Text(
                            "pay".tr().toString(),
                            style: TextStyle(
                                fontSize: Styles().fontSize_subname,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ))
                : SizedBox(),
          ],
        )
      ],
    ),
  );
}

Widget getState_Text(int state, double fontsize) {
  return Text(
    state == 0
        ? "writing".tr().toString()
        : state == 1
            ? "wating".tr().toString()
            : state == 2
                ? "current".tr().toString()
                : state == 3
                    ? "complete".tr().toString()
                    : "given".tr().toString(),
    style: TextStyle(
      color: state == 1
          ? Colors.redAccent
          : state == 2
              ? Colors.green
              : state == 3
                  ? Colors.blue
                  : Colors.grey,
      fontSize: fontsize,
    ),
  );
}

String Operation_state(int state) {
  return state == 0
      ? "writing".tr().toString()
      : state == 1
          ? "wating".tr().toString()
          : state == 2
              ? "current".tr().toString()
              : state == 3
                  ? "complete".tr().toString()
                  : "given".tr().toString();
}
