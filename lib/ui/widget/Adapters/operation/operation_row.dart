import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Popups/operations/dalete.dart';
import 'package:service_app/ui/widget/Popups/operations/updateState_pop.dart';
import '../../operation_tools.dart';
import '../../../widget/currency_text.dart';

import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

Widget Operation_Row(
    BuildContext context, Operation_provider operation, String actial_page) {
  return Slidable(
      // delegate: new SlidableDrawerDelegate(),+
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        operation.state <= 3
            ? Container(
                height: 200.h,
                width: 80.w,
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.blue,
                    size: 35.sp,
                  ),
                  onPressed: () {
                    Stream userStream =
                        Stream.fromFuture(Store().getStore_Info());
                    userStream.listen((event) {
                      User user = event;
                      print(
                          'operations_permissions ${event.operations_permissions[1].value}');
                      if (user.operations_permissions[1].value) {
                        Operation_update(context, operation, actial_page);
                      } else {
                        NO_Permissions(context);
                      }
                    });
                  },
                ),

                // onTap: () => _showSnackBar('Share'),
              )
            : SizedBox(),
      ],
      secondaryActions: <Widget>[
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
              if (operation.state != 1) {
                // if not in waiting
                EasyLoading.showError("delete_oper_error".tr(namedArgs: {
                  'state': Operation_state(operation.state).tr(),
                }, args: [
                  ''
                ]));
                // ,"delete_oper_error".tr().toString());
                return;
              }
              Stream userStream = Stream.fromFuture(Store().getStore_Info());
              userStream.listen((event) {
                User user = event;
                print(
                    'operations_permissions ${event.operations_permissions[2].value}');
                if (user.operations_permissions[2].value) {
                  Operation_delete(context, operation.uid);
                } else {
                  NO_Permissions(context);
                }
              });
            },
          ),

          // onTap: () => _showSnackBar('Share'),
        ),
      ],
      child: InkResponse(
        onTap: () {
          print("operation.id ${operation.uid}");
          Navigator.pushNamed(context, '/operation_details/${operation.uid}');
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Colors.grey,
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            height: 200.h,
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    !operation.serviceslist.isEmpty &&
                            operation.serviceslist[0].imageURL != null
                        ? Container(
                            height: 200.h,
                            width: 150.w,
                            child: CachedNetworkImage(
                              alignment: Alignment.topCenter,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Image(
                                height: 200.h,
                                width: 150.w,
                                fit: BoxFit.cover,
                                image: AssetImage("res/images/logo.png"),
                              ),
                              placeholder: (context, url) => Image(
                                height: 200.h,
                                width: 150.w,
                                fit: BoxFit.cover,
                                image: AssetImage("res/images/logo.png"),
                              ),
                              imageUrl: operation.serviceslist[0].imageURL,
                            ),
                          )
                        : !operation.productslist.isEmpty &&
                                operation.productslist[0].imageURL != null
                            ? Container(
                                height: 200.h,
                                width: 150.w,
                                child: CachedNetworkImage(
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image(
                                    height: 200.h,
                                    width: 150.w,
                                    fit: BoxFit.cover,
                                    image: AssetImage("res/images/logo.png"),
                                  ),
                                  imageUrl: operation.productslist[0].imageURL,
                                ),
                              )
                            : Image(
                                height: 200.h,
                                width: 150.w,
                                fit: BoxFit.cover,
                                image: AssetImage("res/images/logo.png"),
                              ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          operation.id,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: Styles().fontSize_name,
                          ),
                        ),
                        Text(
                          operation.customer.name,
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
                  Styles().fontSize_price,
                ),
              ],
            ),
          ),
        ),
      ));
}
