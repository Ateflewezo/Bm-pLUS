import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:service_app/control/modules/worker_payments.dart';
import 'package:service_app/control/services/worker.dart';
import 'api.dart';
import 'locator.dart';

class WorkersPayment_provider {
  Api _api = locator_worker_payment<Api>();

  List<Payment> payments;

  Future<List<Payment>> fetchWroker() async {
    var result = await _api.getDataCollection();
    payments =
        result.docs.map((doc) => Payment.fromMap(doc.data(), doc.id)).toList();
    return payments;
  }

  Stream<QuerySnapshot> fetchWrokerPaymentAsStream_byMonthe(String month) {
    // month = "1";
    print("month ${month}");

    return _api.streamDataCollectionFilter("month", month);
  }

  Stream<QuerySnapshot> fetchWrokerPaymentAsStream() {
    return _api.streamDataCollection();
  }

  Future<Payment> getpaymentById(String id) async {
    print("objectID ${id}");
    var doc = await _api.getDocumentById(id);
    // Worker worker = Worker.fromMap(doc.data(), doc.id);
    print("objectID ${doc.data().toString()}");

    return doc.data() != null ? Payment.fromMap(doc.data(), doc.id) : null;
  }

  Future removepayment(String id, String imageurl) async {
    print("objectID ${id}");
    var result = await _api.removeDocument(id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future addpayment(Payment data, Worker worker) async {
    DateTime now = DateTime.now();
    worker.total_paid += data.paided;
    print("data.type ${data.type}");
    if (data.type == "salaire") {
      worker.salaire = true;
      worker.salaire_month = data.month;
      worker.salaire_year = now.year.toString();
      worker.salaire_date = data.date;
      worker.total_salary += data.paided;
    } else {
      worker.comission_paid += data.paided;
    }

    await EasyLoadingStatus.dismiss;
    var result = await _api
        .addDocument(data.toJson())
        .then((doc) => Workers_provider().updateWroker_totpaid(worker));

    return;
  }
}
