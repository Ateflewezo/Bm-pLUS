import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/worker.dart';

import 'api.dart';
import 'locator.dart';
import 'customers.dart';

class Operations_provider extends ChangeNotifier {
  Api _api = locator_Operation<Api>();

  List<Operation_provider> operations = [];

  Future<List<Operation_provider>> fetchoperations() async {
    var result = await _api.getDataCollection();
    operations = result.docs
        .map((doc) => Operation_provider.fromMap(doc.data(), doc.id))
        .toList();
    return operations;
  }

  // Satistic satistic;
  Stream<QuerySnapshot> fetchStatic_AsStream(String filterby, String date) {
    // DateTime.now().day.toString()
    return _api.streamDataCollectionFilter_2filed(filterby, date, 'state', 4);
  }

  Stream<QuerySnapshot> fetchOperationAsStream() {
    return _api.streamDataCollection();
  }

  Stream<QuerySnapshot> fetchOperation_bycustomerID_AsStream(
      String customerID) {
    return _api.streamDataCollectionFilter_limitlast10(
        'customer.phone_number', customerID);
  }

  Stream<QuerySnapshot> fetchOperation_bystate_AsStream(
      int state, String searth_by, String customer_ID) {
    // return _api.streamDataCollectionFilter('state', state);
    print("customer id ${customer_ID}");
    if (customer_ID.isEmpty) {
      return _api.streamDataCollectionFilter('state', state);
    } else {
      return _api.streamDataCollectionFilter_2filed(
          'state', state, 'customer.phone_number', customer_ID);
    }
  }

  Future<Operation_provider> getOperationById(String id) async {
    // id = "CZuN3qov5l81TaVxEPfk";
    print("objectID ${id}");

    var doc = await _api.getDocumentById(id);
    print("objectID ${doc.data().toString()}");
    return doc.data() != null
        ? Operation_provider.fromsnapshot(doc, doc.id)
        : null;
  }

  Future removeOperation(String id) async {
    print("objectID ${id}");
    var result = await _api
        .removeDocument(id)
        // .then((value) => deleteImage(imageurl))
        .then((doc) async =>
            await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future updateOperation(
      Operation_provider operation, String id, String store_id) async {
    await _api.updateDocument(operation.Update_state(), id).then((doc) async {
      switch (operation.state) {
        case 2:

          ///worker it become active right now
          Workers_provider().updateWroker_status(operation, 1);
          break;
        case 3:

          ///worker it become disactive right now

          Workers_provider().updateWroker_status(operation, 0);
          break;
        case 4:
          Workers_provider().updateWroker_commission(operation, store_id).then(
              (value) => Customers_provider()
                  .update_operationNB(operation.customer.phone_number));
          break;
        default:
      }
    });

    return;
  }

  Future updateOperation_All(Operation_provider operation, String id) async {
    print("operation ${operation.toJson()}");
    await _api.updateDocument(operation.toJson(), id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));
  }

  Future updateOperation_Paid(var data, String id) async {
    print("operation ${data}");
    await _api.updateDocument(data, id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));
  }

  Future add_operation(Operation_provider data) {
    print("operation ${data.toJson()}");
    return _api.addDocument(data.toJson()).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));
  }
}
