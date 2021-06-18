import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Adapters/services/service_row_inoperation.dart';
import 'package:service_app/ui/widget/Popups/Offers/add_new.dart';
import '../../../../control/modules/service.dart';
import '../../../../control/services/services.dart';
import 'package:service_app/ui/widget/Popups/Servieces/add_new.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class List_service_inOperation extends StatefulWidget {
  List<Service> serviceslist;
  List_service_inOperation({this.serviceslist});

  @override
  _List_service_inOperationState createState() =>
      _List_service_inOperationState();
}

class _List_service_inOperationState extends State<List_service_inOperation> {
  @override
  Widget build(BuildContext context) {
    List<Service> services = [];
    if (widget.serviceslist.isEmpty) {
      var bloc = Provider.of<Operation_provider>(context);
      services = bloc.serviceslist;
    } else {
      services = widget.serviceslist;
    }

    if (services.length != 0) {
      print("lenght ${services.length}");
      print("item ${services[0].toString()}");
      return ListView.builder(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: services.length,
          // itemExtent: 500.w,
          // semanticChildCount: 10,
          itemBuilder: (BuildContext context, int index) {
            print("item ${services[index]}");

            return Service_in_operation_Row(
              service: services[index],
            );
          });
    } else {
      return Center(
          child: Text(
        'nodata'.tr().toString(),
        style: Styles().textStyle_nodata,
      ));
    }
  }
}
