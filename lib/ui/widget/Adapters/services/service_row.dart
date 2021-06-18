import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../../../control/modules/service.dart';
import 'package:service_app/ui/widget/Popups/Servieces/remove.dart';
import 'package:service_app/ui/widget/Popups/Servieces/update.dart';
import '../../../widget/currency_text.dart';

import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

Widget Service_Row(BuildContext context, Service service) {
  return Slidable(
      // delegate: new SlidableDrawerDelegate(),+
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100.w,
              width: 80.w,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colors.blue,
                ),
                onPressed: () {
                  Stream userStream =
                      Stream.fromFuture(Store().getStore_Info());
                  userStream.listen((event) {
                    User user = event;
                    print(
                        'services_permissions ${event.services_permissions[1].value}');
                    if (user.services_permissions[1].value) {
                      Service_update(context, service);
                    } else {
                      NO_Permissions(context);
                    }
                  });
                },
              ),

              // onTap: () => _showSnackBar('Share'),
            ),
            Container(
              height: 100.w,
              width: 80.w,
              decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  // size: 35.sp,
                ),
                onPressed: () {
                  Stream userStream =
                      Stream.fromFuture(Store().getStore_Info());
                  userStream.listen((event) {
                    User user = event;
                    print(
                        'services_permissions ${event.services_permissions[2].value}');
                    if (user.services_permissions[2].value) {
                      Setvice_delete(context, service);
                    } else {
                      NO_Permissions(context);
                    }
                  });
                },
              ), // onTap: () => _showSnackBar('Share'),
            ),
          ],
        ),
      ],
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.w),
        ),
        shadowColor: Colors.grey,
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
          height: 200.h,
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              service.imageURL != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        height: 200.w,
                        width: 180.w,
                        alignment: Alignment.topCenter,
                        placeholder: (context, url) => Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 10.w),
                          height: 200.w,
                          width: 180.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("res/images/logo.png"),
                            ),
                          ),
                        ),
                        imageUrl: service.imageURL,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(
                      height: 200.w,
                      width: 180.w,
                    ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    service.name,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Styles().fontSize_name,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: Row(
                      children: [
                        Text(
                          'price'.tr().toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: Styles().fontSize_price_ad,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        adapter_currency(context, service.price, Colors.blue,
                            Styles().fontSize_price_ad),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
}
