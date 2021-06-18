import 'package:get_it/get_it.dart';
import 'package:service_app/control/services/expancess.dart';
import 'package:service_app/control/services/offers.dart';
import 'package:service_app/control/services/users.dart';
import 'package:service_app/control/services/worker_payment.dart';
import 'package:service_app/control/services/messages.dart';
import 'products.dart';
import 'services.dart';
import 'worker.dart';
import 'store.dart';
import '../services/api.dart';

const String store_url = "Stores/";

GetIt locator_Store;
void setuplocator_Store(String store_id, String user_id) {
  locator_Store = GetIt();
  locator_Store.registerLazySingleton(() => Api(store_url));
  locator_Store.registerLazySingleton(() => Stores_provider());

  // //////////
  // setuplocator_message('Users/${user_id}/messages');
  setuplocator_product('${store_id}/products');
  setuplocator_service('${store_id}/services');
  setuplocator_worker('${store_id}/workers');

  setuplocator_offer("${store_id}/productsINoffers");
  setuplocator_customer('${store_id}/customers');
  setuplocator_Operation('${store_id}/operations');
  setuplocator_Expancess('${store_id}/expancess');
}

GetIt locator_message_read;
void _setuplocator_message_read(String s) {
  locator_message_read = GetIt();
  locator_message_read.registerLazySingleton(() => Api(s));
  locator_message_read.registerLazySingleton(() => Message_provider());
}

GetIt locator_message_write;
void _setuplocator_message_write(String s) {
  locator_message_write = GetIt();
  locator_message_write.registerLazySingleton(() => Api(s));
  locator_message_write.registerLazySingleton(() => Message_provider());
}

void setuplocator_message(String sms_number, String user_number) {
  _setuplocator_message_read('Users/${user_number}/messages');
  _setuplocator_message_write('Users/${sms_number}/messages');
}

GetIt locator_product;
void setuplocator_product(String s) {
  locator_product = GetIt();
  locator_product.registerLazySingleton(() => Api(store_url + s));
  locator_product.registerLazySingleton(() => Products_provider());
}

GetIt locator_offer;

void setuplocator_offer(String s) {
  locator_offer = GetIt();
  locator_offer.registerLazySingleton(() => Api(store_url + s));
  locator_offer.registerLazySingleton(() => Offers_provider());
}

GetIt locator_service;
void setuplocator_service(String s) {
  locator_service = GetIt();
  locator_service.registerLazySingleton(() => Api(store_url + s));
  locator_service.registerLazySingleton(() => Services_provider());
}

GetIt locator_worker;
void setuplocator_worker(String s) {
  locator_worker = GetIt();
  locator_worker.registerLazySingleton(() => Api(store_url + s));
  locator_worker.registerLazySingleton(() => Workers_provider());
}

GetIt locator_worker_operation;
void setuplocator_worker_operation(String s) {
  locator_worker_operation = GetIt();
  locator_worker_operation.registerLazySingleton(() => Api(store_url + s));
  locator_worker_operation.registerLazySingleton(() => Workers_provider());
}

GetIt locator_user;
void setuplocator_user() {
  locator_user = GetIt();
  locator_user.registerLazySingleton(() => Api('Users/'));
  locator_user.registerLazySingleton(() => Users_provider());
}

GetIt locator_worker_payment;
void setuplocator_workerPayment(String id, String store_id) {
  locator_worker_payment = GetIt();
  locator_worker_payment.registerLazySingleton(
      () => Api("Stores/${store_id}/workers/${id}/payments"
          // workers_url + "/${id}"
          ));
  locator_worker_payment.registerLazySingleton(() => WorkersPayment_provider());
}

GetIt locator_Customer;
void setuplocator_customer(String s) {
  locator_Customer = GetIt();
  locator_Customer.registerLazySingleton(() => Api(store_url + s));
  locator_Customer.registerLazySingleton(() => Workers_provider());
}

GetIt locator_Operation;
void setuplocator_Operation(String s) {
  locator_Operation = GetIt();
  locator_Operation.registerLazySingleton(() => Api(store_url + s));
  locator_Operation.registerLazySingleton(() => Workers_provider());
}

GetIt locator_Expancess;

void setuplocator_Expancess(String s) {
  locator_Expancess = GetIt();
  locator_Expancess.registerLazySingleton(() => Api(store_url + s));
  locator_Expancess.registerLazySingleton(() => Expancess_provider());
}
