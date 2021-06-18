import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Adapters/operation/operation_row.dart';
import '../../../../control/provider/operation.dart';
import 'package:easy_localization/easy_localization.dart';

Widget List_operations(int operation_page, String search_by, String customer_id,
    String actial_page) {
  Operations_provider operations_provider = Operations_provider();
  List<Operation_provider> operations;
  return StreamBuilder(
      stream: operations_provider.fetchOperation_bystate_AsStream(
          operation_page, search_by, customer_id),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          operations = snapshot.data.docs
              .map((doc) => Operation_provider.fromsnapshot(doc, doc.id)
                  // .fromMap(doc.data(), doc.id)
                  )
              .toList();

          operations.sort((b, a) => a.id.compareTo(b.id));
          if (operations.length > 0) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: operations.length,
                itemBuilder: (BuildContext context, int index) {
                  if (!operations[index].serviceslist.isEmpty)
                    printInfo(
                        operations[index].serviceslist[0].name.toString());

                  return Operation_Row(context, operations[index], actial_page);
                });
          } else {
            return Center(
                child: Text(
              'nodata'.tr().toString(),
              style: Styles().textStyle_nodata,
            ));
          }
        } else {
          return Center(
              child: Text(
            'loading'.tr().toString(),
            style: Styles().textStyle_nodata,
          ));
        }
      });
}
