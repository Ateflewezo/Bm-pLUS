import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Adapters/services/service_row_toadd_operation.dart';
import '../../../../control/modules/service.dart';
import '../../../../control/services/services.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget List_service_addTO_Operation() {
  List<Service> services;
  Services_provider services_provider = Services_provider();
  return Scaffold(
    body: StreamBuilder(
        stream: services_provider.fetchServicesAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            services = snapshot.data.docs
                .map((doc) => Service.fromMap(doc.data(), doc.id))
                .toList();
            if (services.isEmpty) {
              return Center(
                  child: Text(
                'nodata'.tr().toString(),
                style: Styles().textStyle_nodata,
              ));
            }
            return GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 0.9.w),
                shrinkWrap: true,
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  // return Product_Row();
                  return ADDService_To_operation_Row(
                    service: services[index],
                  );
                });
          } else {
            return Center(
                child: Text(
              'Loading',
              style: Styles().textStyle_nodata,
            ));
          }
        }),
  );
}
