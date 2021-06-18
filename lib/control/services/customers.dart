import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/customer.dart';

import 'api.dart';
import 'locator.dart';

class Customers_provider {
  Api _api = locator_Customer<Api>();

  List<Customer> customers;

  Future<List<Customer>> fetchcustomers() async {
    var result = await _api.getDataCollection();
    customers =
        result.docs.map((doc) => Customer.fromMap(doc.data(), doc.id)).toList();
    return customers;
  }

  Stream<QuerySnapshot> fetchCustomerAsStream() {
    return _api.streamDataCollection();
  }

  Future<Customer> getcustomerById(String id) async {
    print("objectID ${id}");

    var doc = await _api.getDocumentById(id);
    print("objectID ${doc.data().toString()}");
    return doc.data() != null ? Customer.fromMap(doc.data(), doc.id) : null;
    // return Customer.fromMap(doc.data(), doc.id);
  }

  Future removecustomer(String id, String imageurl) async {
    print("objectID ${id}");
    var result = await _api
        .removeDocument(id)
        // .then((value) => _api.deleteImage(imageurl))
        .then((doc) async =>
            await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future updatecustomer(Customer data, Customer customer, bool newimage) async {
    await _api.updateDocument(data.toJson(), customer.id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    if (newimage) {
      _api.deleteImage(customer.imageURL);
    }
    return;
  }

  Future addcustomer(Customer data) async {
    await _api.addDocument(data.toJson()).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future update_operationNB(String customerid) async {
    Customer customer;
    final snapShot = await _api.ref.doc(customerid).get();
    if (snapShot == null || !snapShot.exists) {
      print(" customer doesn  exist");
    } else {
      print("customer exist ${snapShot.toString()}");
      customer = Customer.fromMap(snapShot.data(), snapShot.id);
      customer.complete_operation = customer.complete_operation + 1;
      print(
          "customer exist ${customer.toJson_complete_operation().toString()}");

      await _api
          .updateDocument(customer.toJson_complete_operation(), customer.id)
          .then((doc) async =>
              await EasyLoading.showSuccess('great'.tr().toString()));
    }
    return;
  }

  Future<bool> addcustomerandgetID(Customer data) async {
    print("customer ${data.toJson().toString()}");
    // Progress progress = Progress();

    // progress.OnProgress(context);

    if (await _api.addDocumentandgetID_customer(data, data.phone_number)) {
      await EasyLoading.showSuccess('great'.tr().toString());
      return true;
    } else {
      return false;
    }
  }
}
