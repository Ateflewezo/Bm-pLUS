import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/control/services/store.dart';
import 'api.dart';
import 'locator.dart';
import 'package:path/path.dart' as Path;

class Users_provider {
  Api _api = locator_user<Api>();

  List<User> users;

  Future<List<User>> fetchWroker() async {
    var result = await _api.getDataCollection();
    users = result.docs.map((doc) => User.fromsnapshot(doc, doc.id)).toList();
    return users;
  }

  Stream<QuerySnapshot> fetchUserAsStream() {
    return _api.streamDataCollection();
  }

  Stream<QuerySnapshot> fetchUser_bytype_AsStream(String type, String storeid) {
    return _api.streamDataCollectionFilter_2filed(
        'type', type, 'store_id', storeid);
  }

  Future<User> login(
      String phone, String password, BuildContext context) async {
    EasyLoading.show(status: 'login'.tr().toString());
    final snapShot = await _api.ref.doc(phone).get();
    if (snapShot == null || !snapShot.exists) {
      EasyLoadingStatus.dismiss;
      EasyLoading.showInfo('wrong_phone'.tr().toString());

      print("docId doesn  exist");

      // return doc;
    } else {
      print("docId exist111 ${snapShot.toString()}");

      User user = User.fromsnapshot_details(snapShot, snapShot.id);
      if (user.password == password) {
        Store().setloginData(user, true);
        await Stores_provider().login(user).then((value) {
          Navigator.pushNamed(context, '/home');
          EasyLoading.showSuccess('great'.tr().toString());
        });
      } else {
        EasyLoading.showInfo('wrong_password'.tr().toString());
      }
      print("docId exist");
    }
  }

  Future<User> getUserById(String id) async {
    // id = "CZuN3qov5l81TaVxEPfk";
    print("objectID ${id}");

    var doc = await _api.getDocumentById(id);
    print("objectID ${doc.data().toString()}");
    return doc.data() != null ? User.fromsnapshot_details(doc, doc.id) : null;
  }

  Future removeUser(String id, String imageurl) async {
    print("objectID ${id}");
    var result = await _api
        .removeDocument(id)
        .then((value) => deleteImage(imageurl))
        .then((doc) async =>
            await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future deleteImage(String imageFileName) async {
    var fileUrl = Uri.decodeFull(Path.basename(imageFileName))
        .replaceAll(new RegExp(r'(\?alt).*'), '');
    print('url deleted $fileUrl storage item');

    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();
  }

  Future updateUser(User data, User worker, bool newimage) async {
    await _api.updateDocument(data.toJson(), worker.id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    if (newimage) {
      deleteImage(worker.imageURL);
    }
    return;
  }

  Future updateStoreInfo(var data, String id) async {
    await _api.updateDocument(data, id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future updateUser_Permission(String userID, List<Permission> permissions,
      String permissionID, String tab_name) async {
    await _api.ref
        .doc(userID)
        .update({'${tab_name}': permissions.map((p) => p.toJson()).toList()})
        // .updateDocument(permission.toJson(), permissionID)
        .then((doc) async =>
            await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Future addUser(User data) async {
    final snapShot = await _api.ref.doc(data.phone_number).get();

    if (snapShot == null || !snapShot.exists) {
      // Document with id == docId doesn't exist.
      Future<void> doc = _api.ref
          .doc(data.phone_number)
          .set(data.toJson())
          .then((doc) async =>
              await EasyLoading.showSuccess('great'.tr().toString()));
      print("docId doesn  exist");
      // return doc;
    } else {
      EasyLoading.showInfo('already_exist'.tr().toString());
      print("docId exist");
    }

    return;
  }

  Future<bool> addUser_test(String data) async {
    final snapShot = await _api.ref.doc(data).get();

    if (snapShot == null || !snapShot.exists) {
      print("docId doesn  exist");
      return true;
      // return doc;
    } else {
      print("docId exist");
      EasyLoading.showInfo('already_exist'.tr().toString());
      return false;
    }
  }
}
