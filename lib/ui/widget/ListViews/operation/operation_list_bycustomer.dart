import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:service_app/ui/widget/Adapters/operation/operation_row_bycustomer.dart';
import '../../../../control/provider/operation.dart';
import 'package:easy_localization/easy_localization.dart';

Widget List_operations_details_customer(String customerid) {
  Operations_provider operations_provider = Operations_provider();
  List<Operation_provider> operations;
  return StreamBuilder(
      stream:
          operations_provider.fetchOperation_bycustomerID_AsStream(customerid),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          operations = snapshot.data.docs
              .map((doc) => Operation_provider.fromsnapshot(doc, doc.id)
                  // .fromMap(doc.data(), doc.id)
                  )
              .toList();
          if (operations.length > 0) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: operations.length,
                itemBuilder: (BuildContext context, int index) {
                  if (!operations[index].serviceslist.isEmpty)
                    printInfo(
                        operations[index].serviceslist[0].name.toString());

                  return Operation_Row_customer_details(
                      context, operations[index]);
                });
          } else {
            return Center(child: Text('nodata'.tr().toString()));
          }
        } else {
          return Center(child: Text('loading'.tr().toString()));
        }
      });
}
