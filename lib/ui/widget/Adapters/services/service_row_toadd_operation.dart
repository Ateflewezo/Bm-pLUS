import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../../../control/modules/service.dart';
import 'package:service_app/ui/widget/Popups/Workers/select_worker_pop.dart';
import '../../../tooles/constants/colors_app.dart' as _color;
import '../../../widget/currency_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class ADDService_To_operation_Row extends StatefulWidget {
  Service service;
  ADDService_To_operation_Row({this.service});
  @override
  _ADDService_To_operation_RowState createState() =>
      _ADDService_To_operation_RowState();
}

class _ADDService_To_operation_RowState
    extends State<ADDService_To_operation_Row> {
  @override
  Widget build(BuildContext context) {
    Service service = widget.service;
    var bloc = Provider.of<Operation_provider>(context, listen: true);
    var services = bloc.serviceslist;
    return InkResponse(
      onTap: () {
        // bloc.contains_service(service)
        //     ? bloc.removToServices(service)
        //     : showAlertDialog_addworker(context, service);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: bloc.contains_service(service)
                  ? Color(0XFF549FFF)
                  : Colors.grey,
              width: bloc.contains_service(service) ? 2 : 0.2),
        ),
        margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        width: 216.w,
        height: 250,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  service.imageURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            width: 230.w,
                            height: 130.h,
                            child: CachedNetworkImage(
                              alignment: Alignment.topCenter,
                              placeholder: (context, url) => Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.w),
                                width: 230.w,
                                height: 180.h,
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
                          ),
                        )
                      : Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          width: 230.w,
                          height: 180.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("res/images/logo.png"),
                            ),
                          ),
                        ),
                  Text(
                    service.name,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: Styles().fontSize_name,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  bloc.contains_service(service)
                      ? Text(
                          "worker".tr(
                            namedArgs: {
                              'lang': bloc
                                  .get_service(service)
                                  .workers[0]
                                  .name
                                  .toString()
                            },
                            // args: ['']
                          ),
                          // 'worker'.tr().toString(),
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: Styles().fontSize_subname,
                            fontWeight: FontWeight.normal,
                          ))
                      : SizedBox(),
                  adapter_currency(context, service.price,
                      _color.product_details1, Styles().fontSize_price_ad),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkResponse(
                        onTap: () {
                          bloc.contains_service(service)
                              ? setState(() {
                                  bloc.addToServices(service, false);
                                })
                              : showAlertDialog_addworker(context, service);
                        },
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          padding: EdgeInsets.only(
                            bottom: 0,
                          ),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: Colors.blue[500],
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.blue[100],
                                Colors.blue[200],
                                Colors.blue[300],
                                Colors.blue[500]
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),

                      Text(
                        bloc.contains_service(service)
                            ? bloc
                                .serviceslist[bloc.serviceslist.indexWhere(
                                    (element) => element.id == service.id)]
                                .quantity
                                .toString()
                            : "0",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: Styles().fontSize_name,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkResponse(
                        onTap: () {
                          setState(() {
                            bloc.removoneToservice(service);
                          });
                        },
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          padding: EdgeInsets.only(
                            bottom: 0,
                          ),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: Colors.blue[500],
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.blue[100],
                                Colors.blue[200],
                                Colors.blue[300],
                                Colors.blue[500]
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),

                      //
                      SizedBox(
                        width: 0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bloc.contains_service(service)
                ? Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(5)),
                        color: Color(0XFF549FFF)
                        //  border: Border.all(color: Color(0XFF549FFF),width: 1),
                        ),
                    child: Icon(
                      Icons.check,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
