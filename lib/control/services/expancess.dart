import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:service_app/control/modules/customer.dart';
import 'package:service_app/control/modules/expancess.dart';
import 'package:service_app/ui/widget/progress/progress.dart';

import 'api.dart';
import 'locator.dart';
import 'package:path/path.dart' as Path;

class Expancess_provider {
  Api _api = locator_Expancess<Api>();

  List<Expancess> expansess;

  Future<List<Expancess>> fetchExpancess() async {
    var result = await _api.getDataCollection();
    expansess = result.docs
        .map((doc) => Expancess.fromMap(doc.data(), doc.id))
        .toList();
    return expansess;
  }

  Stream<QuerySnapshot> fetchExpancessAsStream() {
    return _api.streamDataCollection();
  }

  Stream<QuerySnapshot> getstatistic(String filterby, String date) {
    return _api.streamDataCollectionFilter(filterby, date);
  }

  Future<Expancess> getExpancessById(String id) async {
    // id = "123";
    print("objectID ${id}");

    var doc = await _api.getDocumentById(id);
    print("objectID ${doc.data().toString()}");
    return doc.data() != null ? Expancess.fromMap(doc.data(), doc.id) : null;
  }

  Future removeExpancess(String id, String imageurl) async {
    print("objectID ${id}");
    var result = await _api.removeDocument(id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future updateExpancess(Expancess data, String id) async {
    await _api.updateDocument(data.toJson_update(), id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future addExpancess(Expancess data) async {
    await _api.addDocument(data.toJson()).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }
}
