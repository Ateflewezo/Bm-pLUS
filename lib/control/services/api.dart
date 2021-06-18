import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path/path.dart' as Path;
import 'package:service_app/control/modules/customer.dart';
import 'messages.dart';
import '../../ui/screens/home.dart';

class Api {
  final String path;
  CollectionReference ref;

  Api(this.path) {
    Firebase.initializeApp();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  // Future<QuerySnapshot> getDataCollection_orderby(String orderby) {
  //   return ref.get();
  // }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionSearch(String field, var value) {
    return ref.where(field, isGreaterThanOrEqualTo: value).snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionFilter(String field, var value) {
    return ref.where(field, isEqualTo: value).snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionFilter_orderby(
      String field, var value, String orderby) {
    return ref
        // .orderBy("id", descending: true)
        // .limit(2)
        .where(field, isEqualTo: value)
        .snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionFilter_limitlast10(
      String field, var value) {
    return ref.where(field, isEqualTo: value).limit(10).snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionFilter_2filed_orderby(
      String field, var value, String field2, var value2, String orderby) {
    return ref
        .where(field, isEqualTo: value)
        .where(field2, isEqualTo: value2)
        .orderBy(orderby)
        .snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionFilter_2filed(
      String field, var value, String field2, var value2) {
    return ref
        .where(field, isEqualTo: value)
        .where(field2, isEqualTo: value2)
        .snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data).then((doc) {
      print('doc.id ${doc.id}');
    }).catchError((error) {
      print(error);
    });
  }

  Future<bool> addDocumentandgetID_customer(Customer data, String id) async {
    try {
      final snapShot = await ref.doc(id).get();

      if (snapShot == null || !snapShot.exists) {
        var connResult = await (Connectivity().checkConnectivity());
        if (connResult != ConnectivityResult.mobile &&
            connResult != ConnectivityResult.wifi) {
          EasyLoading.showToast(
            "lost_connection".tr().toString(),
            duration: Duration(seconds: 10),
            toastPosition: EasyLoadingToastPosition.bottom,
            // maskType: EasyLoadingMaskType.values,
            dismissOnTap: true,
          );
          return false;
        }

        if (data.name == null) {
          EasyLoading.showInfo('customer_doesnt_exi'.tr().toString());
          return false;
        }
        Message_provider().Send_Message_(
            "wellcom_customer".tr().toString(), [data.phone_number]);
        // Document with id == docId doesn't exist.
        Future<void> doc = ref.doc(id).set(data.toJson());
        print("docId doesn  exist");
        return true;

        // return doc;
      } else {
        print("docId exist");
        return true;
      }
    } catch (e) {
      var connResult = await (Connectivity().checkConnectivity());
      if (connResult != ConnectivityResult.mobile &&
          connResult != ConnectivityResult.wifi) {
        EasyLoading.showToast(
          "lost_connection".tr().toString(),
          duration: Duration(seconds: 10),
          toastPosition: EasyLoadingToastPosition.center,
          // maskType: EasyLoadingMaskType.values,
          dismissOnTap: true,
        );
        return false;
      }
    }

    // Future<DocumentReference> doc = ref.add(data);
    // return doc;
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }

  Future deleteImage(String imageFileName) async {
    // var fileUrl = Uri.decodeFull(Path.basename(imageFileName))
    //     .replaceAll(new RegExp(r'(\?alt).*'), '');
    // print('url deleted $fileUrl storage item');

    // final Reference firebaseStorageRef =
    //     FirebaseStorage.instance.ref().child(fileUrl);
    // await firebaseStorageRef.delete();
  }
}
