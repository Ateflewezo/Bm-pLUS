import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/service.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:service_app/control/services/worker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/widget/Adapters/worker/worker_row_inaddservice.dart';

Widget List_worker_inAddservice(Service service) {
  Workers_provider workers_provider = Workers_provider();
  List<Worker> workers;
  return StreamBuilder(
      stream: workers_provider.fetchWrokerAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          workers = snapshot.data.docs
              .map((doc) => Worker.fromMap(doc.data(), doc.id))
              .toList();
          if (workers.length > 0) {
            return ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: workers.length,
                itemBuilder: (BuildContext context, int index) {
                  // return Product_Row();
                  return InkResponse(
                    child: Worker_row_inADDservice(
                      worker: workers[index],
                      service: service,
                    ),
                  );
                });
          } else {
            return Center(child: Text('nodata'.tr().toString()));
          }
        } else {
          return Center(child: Text('loading'.tr().toString()));
        }
      });
}
