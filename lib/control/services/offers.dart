import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/offer.dart';
import 'api.dart';
import 'locator.dart';
import 'package:easy_localization/easy_localization.dart';

class Offers_provider {
  Api _api = locator_offer<Api>();

  List<Offer> products;

  Future<List<Offer>> fetchOffers() async {
    var result = await _api.getDataCollection();
    products =
        result.docs.map((doc) => Offer.fromMap(doc.data(), doc.id)).toList();
    return products;
  }

  Stream<QuerySnapshot> fetchOffersAsStream(String search_by) {
    if (search_by.isEmpty) {
      return _api.streamDataCollection();
    } else {
      return _api.streamDataCollectionFilter('name', search_by);
    }
  }

  Future<Offer> getOfferById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Offer.fromMap(doc.data(), doc.id);
  }

  Future removeOffer(String id) async {
    await _api.removeDocument(id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));
    return;
  }

  Future updateOffer(Offer data, String id) async {
    await _api.updateDocument(data.toJson(), id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));
    return;
  }

  Future addOffer(Offer data) async {
    var result = await _api.addDocument(data.toJson()).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }
}
