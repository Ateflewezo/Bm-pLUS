import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../../../control/modules/service.dart';
import '../../../tooles/constants/colors_app.dart' as _color;
import '../../../widget/currency_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class Service_in_operation_Row extends StatelessWidget {
  Service service;
  Service_in_operation_Row({this.service});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      alignment: Alignment.center,
      // width: 300.w,
      height: 250.h,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            service.imageURL != null
                ? Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                    width: 150.w,
                    height: 130.h,
                    child: CachedNetworkImage(
                      alignment: Alignment.topCenter,
                      placeholder: (context, url) => Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage("res/images/logo.png"),
                          ),
                        ),
                      ),
                      imageUrl: service.imageURL,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    width: 180.w,
                    height: 130.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("res/images/logo.png"),
                      ),
                    ),
                  ),
            Text(
              service.name + ' (${service.quantity})',
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                fontSize: Styles().fontSize_name,
                fontWeight: FontWeight.normal,
              ),
            ),
            !service.workers.isEmpty
                ? Text(
                    "worker".tr(
                      namedArgs: {'lang': service.workers[0].name.toString()},
                    ),
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: Styles().fontSize_subname,
                      fontWeight: FontWeight.normal,
                    ))
                : SizedBox(),
            adapter_currency(context, service.price, _color.product_details1,
                Styles().fontSize_price_ad),
          ],
        ),
      ),
    );
  }
}
