import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../modules/service.dart';
import '../services/api.dart';
import '../services/locator.dart';

class Services_provider {
  Api _api = locator_service<Api>();

  List<Service> services;

  Future<List<Service>> fetchServices() async {
    var result = await _api.getDataCollection();
    services =
        result.docs.map((doc) => Service.fromMap(doc.data(), doc.id)).toList();
    return services;
  }

  Stream<QuerySnapshot> fetchServicesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Service> getServiceById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Service.fromMap(doc.data(), doc.id);
  }

  Future removeService(String id, String imageurl) async {
    print("objectID ${id}");
    var result = await _api
        .removeDocument(id)
        .then((value) => _api.deleteImage(imageurl))
        .then((doc) async =>
            await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future updateService(Service data, Service service, bool newimage) async {
    await _api.updateDocument(data.toJson(), service.id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    if (newimage) {
      _api.deleteImage(service.imageURL);
    }
    return;
  }

  Future addService(Service data) async {
    await EasyLoadingStatus.dismiss;
    var result = await _api.addDocument(data.toJson()).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }
}
