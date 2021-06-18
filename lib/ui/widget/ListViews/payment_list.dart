import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/worker_payments.dart';
import 'package:service_app/control/services/worker_payment.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../widget/Adapters/payment_row.dart';
import 'package:easy_localization/easy_localization.dart';

Widget List_payments(String current_month) {
  WorkersPayment_provider workersPayment_provider = WorkersPayment_provider();
  List<Payment> payments;
  return StreamBuilder(
      stream: workersPayment_provider
          .fetchWrokerPaymentAsStream_byMonthe(current_month),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          payments = snapshot.data.docs
              .map((doc) => Payment.fromMap(doc.data(), doc.id))
              .toList();
          print("payments ${payments.toString()}");
          if (payments.length > 0) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: payments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Payment_Row(context, payments[index]);
                });
          } else {
            return Center(child: Text('nodata'.tr().toString(),style: Styles().textStyle_nodata,));
          }
        } else {
          return Center(child: Text('loading'.tr().toString(),style: Styles().textStyle_nodata,));
        }
      });
}
