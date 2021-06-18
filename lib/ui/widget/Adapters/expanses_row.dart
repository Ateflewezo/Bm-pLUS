import 'package:flutter/material.dart';
import '../../widget/currency_text.dart';
import 'package:service_app/control/modules/expancess.dart';
import 'package:service_app/ui/widget/Popups/expancess/update.dart';
import '../../tooles/constants/colors_app.dart' as color;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../tooles/constants/styles.dart';

Widget Expanses_Row(BuildContext context, Expancess expances) {
  return Container(
    width: 500.w,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      shadowColor: Colors.grey,
      color: color.color3,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),

        // alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 100.w,
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
                    style: TextStyle(
                        fontSize: Styles().fontSize_name, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.h),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        (expances.type == "salaire" ||
                                expances.type == "comission")
                            ? expances.name +
                                " (${expances.type.tr().toString()}) "
                            : expances.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Styles().fontSize_name,
                        ),
                      ),
                      Text(
                        expances.date_all,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Styles().fontSize_subname,
                        ),
                      ),
                      Satictic_currency(
                        context,
                        expances.price,
                        Colors.white,
                        Styles().fontSize_price_ad,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            (expances.type == "salaire" || expances.type == "comission")
                ? SizedBox()
                : InkResponse(
                    onTap: () {
                      Update_expancess_alert(context, expances);
                    },
                    child: Container(
                        width: 60.w,
                        height: 60.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 3,
                              spreadRadius: 1,
                              color: Colors.grey,
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          color: color.product_details1,
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 20.sp,
                        )),
                  ),
          ],
        ),
      ),
    ),
  );
}
