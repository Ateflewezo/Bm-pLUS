import 'package:flutter/material.dart';
import 'package:service_app/control/modules/worker_operation.dart';
import 'package:service_app/ui/widget/Popups/expancess/update.dart';
import '../../../tooles/constants/colors_app.dart' as color;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';
import '../../currency_text.dart';

Widget Worker_operation_Row(
    BuildContext context, Worker_operation worker_operation) {
  return Container(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      shadowColor: Colors.grey,
      // color: color.color3,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),

        // alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 150.w,
                  height: 180.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: color.color4,
                  ),
                  child: Text(
                    "\$",
                    style: TextStyle(fontSize: 55.sp, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.h),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            "oper_nb".tr().toString(),
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: Styles().fontSize_name,
                            ),
                          ),
                          Text(
                            " " + worker_operation.operation_nb,
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: Styles().fontSize_name,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        worker_operation.customer_name,
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: Styles().fontSize_name,
                        ),
                      ),
                      Text(
                        worker_operation.date_all,
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: Styles().fontSize_name,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Satictic_currency(
                        context,
                        worker_operation.price,
                        Colors.green,
                        Styles().fontSize_price_ad,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
