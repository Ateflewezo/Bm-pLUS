import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/message.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/messages.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:telephony/telephony.dart';
import '../../../../control/services/operation.dart';
import '../../operation_tools.dart';
import '../../../widget/currency_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

Widget Operation_Row_customer_details(
    BuildContext context, Operation_provider operation) {
  Operations_provider operations_provider = Operations_provider();
  return InkResponse(
    onTap: () {
      print("operation.id ${operation.uid}");
      Navigator.pushNamed(context, '/operation_details/${operation.uid}');
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      shadowColor: Colors.grey,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
        height: 200.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                !operation.serviceslist.isEmpty &&
                        operation.serviceslist[0].imageURL != null
                    ? Container(
                        height: 190.h,
                        width: 150.w,
                        child: CachedNetworkImage(
                          alignment: Alignment.topCenter,
                          placeholder: (context, url) => Image(
                            fit: BoxFit.cover,
                            image: AssetImage("res/images/logo.png"),
                          ),
                          imageUrl: operation.serviceslist[0].imageURL,
                        ),
                      )
                    : !operation.productslist.isEmpty &&
                            operation.productslist[0].imageURL != null
                        ? Container(
                            height: 190.h,
                            width: 150.w,
                            child: CachedNetworkImage(
                              alignment: Alignment.topCenter,
                              // placeholder: (context, url) => CircularProgressIndicator(),
                              imageUrl: operation.productslist[0].imageURL,
                            ),
                          )
                        : Image(
                            height: 190.h,
                            width: 150.w,
                            fit: BoxFit.cover,
                            image: AssetImage("res/images/logo.png"),
                          ),
                          SizedBox(width:10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      operation.date_all,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Styles().fontSize_name,
                      ),
                    ),
                    Text(
                      operation.id,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Styles().fontSize_subname,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: getState_Text(
                          operation.state,
                          Styles().fontSize_subname,
                        )),
                  ],
                ),
              ],
            ),
            adapter_currency(
              context,
              operation.product_total + operation.service_total,
              Colors.blue,
              Styles().fontSize_price_ad,
            ),
          ],
        ),
      ),
    ),
  );
}
