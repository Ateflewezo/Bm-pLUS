import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:service_app/control/modules/worker_operation.dart';
import 'package:service_app/control/services/worker.dart';
import 'api.dart';
import 'locator.dart';

class WorkerOperations_provider {
  Api _api = locator_worker_operation<Api>();

  List<Worker_operation> Worker_operations;

  Future<List<Worker_operation>> fetchWroker() async {
    var result = await _api.getDataCollection();
    Worker_operations = result.docs
        .map((doc) => Worker_operation.fromMap(doc.data(), doc.id))
        .toList();
    return Worker_operations;
  }

  Stream<QuerySnapshot> fetchWrokerWorker_operationAsStream_byMonthe(
      String month) {
    // month = "1";
    print("month ${month}");

    return _api.streamDataCollectionFilter("month", month);
  }

  Stream<QuerySnapshot> fetchWrokerWorker_operationAsStream() {
    return _api.streamDataCollection();
  }

  Future<Worker_operation> getWorker_operationById(String id) async {
    print("objectID ${id}");
    var doc = await _api.getDocumentById(id);
    // Worker worker = Worker.fromMap(doc.data(), doc.id);
    print("objectID ${doc.data().toString()}");

    return doc.data() != null
        ? Worker_operation.fromMap(doc.data(), doc.id)
        : null;
  }

  Future removeWorker_operation(String id, String imageurl) async {
    print("objectID ${id}");
    var result = await _api.removeDocument(id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future addWorker_operation(Worker_operation data) async {
    _api.addDocument(data.toJson());

    return;
  }
}
