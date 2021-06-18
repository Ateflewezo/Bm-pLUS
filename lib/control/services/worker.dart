import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/worker_operation.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/worker_operations.dart';
import 'package:path/path.dart' as Path;
import '../modules/worker.dart';
import 'api.dart';
import 'locator.dart';

// GetIt locator_worker_payment;
// void setuplocator_workerPayment(String id) {
//   locator_worker_payment = GetIt();
//   locator_worker_payment.registerLazySingleton(
//       () => Api("Stores/uid_of_store_number01/workers/${id}/payments"
//           // workers_url + "/${id}"
//           ));
//   locator_worker_payment.registerLazySingleton(() => WorkersPayment_provider());
// }

class Workers_provider {
  Api _api = locator_worker<Api>();

  List<Worker> wroker;

  Future<List<Worker>> fetchWroker() async {
    var result = await _api.getDataCollection();
    wroker =
        result.docs.map((doc) => Worker.fromMap(doc.data(), doc.id)).toList();
    return wroker;
  }

  Stream<QuerySnapshot> fetchWrokerAsStream() {
    return _api.streamDataCollection();
  }

  Future<Worker> getWrokerById(String id) async {
    // id = "CZuN3qov5l81TaVxEPfk";
    print("objectID ${id}");

    var doc = await _api.getDocumentById(id);
    print("objectID ${doc.data().toString()}");
    return doc.data() != null ? Worker.fromMap(doc.data(), doc.id) : null;
  }

  Future removeWroker(String id, String imageurl) async {
    print("objectID ${id}");
    var result = await _api.removeDocument(id).then((value) async {
      try {
        // deleteImage(imageurl);
        await EasyLoading.showSuccess('great'.tr().toString());
      } catch (e) {}
    });

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

  Future updateWroker(Worker data, Worker worker, bool newimage) async {
    await _api.updateDocument(data.toJson(), worker.id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    if (newimage) {
      try {
        // deleteImage(worker.imageURL);
      } catch (e) {}
    }
    return;
  }

  Future updateWroker_commission(
      Operation_provider operation, String store_id) async {
    Worker wrk;
    for (var service in operation.serviceslist) {
      print(
          " updateWroker_commission service in operation ${service.workers.length.toString()}");
      for (var worker in service.workers) {
        print("worker in operation ${worker.comission.toString()}");

        final snapShot = await _api.ref.doc(worker.id).get();
        if (snapShot == null || !snapShot.exists) {
          print(" worker doesn  exist");
        } else {
          print("worker exist ${snapShot.toString()}");
          wrk = Worker.fromMap(snapShot.data(), snapShot.id);
          wrk.comission += worker.comission * service.quantity;
          wrk.complete_operation++;
          await _api.updateDocument(wrk.toJson_comission(), wrk.id);

          ///add complete operation
          setuplocator_worker_operation(
              '${store_id}/workers/${worker.id}/complete_operations');
          Worker_operation worker_operation = Worker_operation(
            operation_nb: operation.id,
            customer_name: operation.customer.name,
            date_all: operation.date_all,
            price: wrk.comission,
          );
          WorkerOperations_provider().addWorker_operation(worker_operation);
        }
      }
    }

    // wrk.comission += 20;
    // wrk.complete_operation++;
    // await _api.updateDocument(wrk.toJson_comission(), wrk.id).then(
    //     (value) async =>
    //         await EasyLoading.showSuccess('great'.tr().toString()));
    return;
  }

  Future updateWroker_status(Operation_provider operation, int status) async {
    for (var service in operation.serviceslist) {
      print(
          "updateWroker_status service in operation ${service.workers.length.toString()}");
      for (var worker in service.workers) {
        print("worker in operation ${worker.id.toString()}");

        final snapShot = await _api.ref.doc(worker.id).get();
        if (snapShot == null || !snapShot.exists) {
          print("worker doesn  exist");
        } else {
          print("worker exist ${snapShot.toString()}");
          Worker wrk = Worker.fromMap(snapShot.data(), snapShot.id);
          wrk.state = status;

          print("worker exist ${wrk.toJson_state().toString()}");

          await _api.updateDocument(wrk.toJson_state(), wrk.id).then(
              (value) => EasyLoading.showSuccess('great'.tr().toString()));
        }
      }
    }

    return;
  }

  Future updateWroker_totpaid(Worker wrk) async {
    final snapShot = await _api.ref.doc(wrk.id).get();
    if (snapShot == null || !snapShot.exists) {
      print("updateWroker_totpaid worker doesn  exist");
    } else {
      print("worker exist ${snapShot.toString()}");
      // Worker worker = Worker.fromMap(snapShot.data(), snapShot.id);
      // worker.total_paid = wrk.total_paid;
      print("worker paid ${wrk.toJson_total_paid()}");

      _api.updateDocument(wrk.toJson_total_paid(), wrk.id).then((value) async =>
          await EasyLoading.showSuccess('great'.tr().toString()));
    }
    return;
  }

  Future addWroker(Worker data) async {
    await EasyLoadingStatus.dismiss;
    var result = await _api.addDocument(data.toJson()).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }
}
