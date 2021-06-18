import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'api.dart';
import 'locator.dart';
import '../modules/store.dart';

class Stores_provider {
  Api _api = locator_Store<Api>();

  List<Store> users;

  Future<Store_classe> getStoreById(String id) async {
    // id = "BusLb0kC8yHdJjIXIuIU";
    // id = 'info';
    print("objectID ${id}");

    var doc = await _api.getDocumentById(id);
    print("objectID ${doc.data().toString()}");
    return Store_classe().fromsnapshot(doc, doc.id);
  }

  Future updateStore(
      Store_classe data, Store_classe oldstore, bool newimage) async {
    await _api.updateDocument(data.toJson(), oldstore.id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    if (newimage) {
      _api.deleteImage(oldstore.image);
    }
    return;
  }

  Future<Store_classe> login(User user) async {
    final snapShot = await _api.ref.doc(user.store_id).get();
    if (snapShot == null || !snapShot.exists) {
      print("docId doesn  exist");

      return null;
    } else {
      print("docId exist ${snapShot.toString()}");
      Store_classe store = Store_classe().fromsnapshot(snapShot, snapShot.id);
      Store().setStore_data(store, user);
      print("store data ${store.toJson().toString()}");
      return store;
    }
  }
}
