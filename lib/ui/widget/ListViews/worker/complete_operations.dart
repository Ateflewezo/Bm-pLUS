import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/worker_operation.dart';
import 'package:service_app/control/services/worker_operations.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/widget/Adapters/worker/complete_operation_row.dart';

Widget List_Complete_operations() {
  WorkerOperations_provider workerOperations_provider =
      WorkerOperations_provider();
  List<Worker_operation> worker_operations;
  return StreamBuilder(
      stream: workerOperations_provider.fetchWrokerWorker_operationAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          worker_operations = snapshot.data.docs
              .map((doc) => Worker_operation.fromMap(doc.data(), doc.id))
              .toList();
          print("worker_operations ${worker_operations.toString()}");
          if (worker_operations.length > 0) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: worker_operations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Worker_operation_Row(
                      context, worker_operations[index]);
                });
          } else {
            return Center(
                child: Text(
              'nodata'.tr().toString(),
              style: Styles().textStyle_nodata,
            ));
          }
        } else {
          return Center(child: Text('loading'.tr().toString()));
        }
      });
}
