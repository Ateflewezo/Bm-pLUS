import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../modules/product.dart';
import '../services/api.dart';
import '../services/locator.dart';
import 'package:easy_localization/easy_localization.dart';

class Products_provider {
  Api _api = locator_product<Api>();

  List<Product> products;

  Future<List<Product>> fetchProducts() async {
    var result = await _api.getDataCollection();
    products =
        result.docs.map((doc) => Product.fromMap(doc.data(), doc.id)).toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Product> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Product.fromMap(doc.data(), doc.id);
  }

  Future removeProduct(String id) async {
    await _api.removeDocument(id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));
    return;
  }

  Future updateProduct(Product data, String id) async {
    await _api.updateDocument(data.toJson(), id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));
    return;
  }

  Future addProduct(Product data) async {
    await EasyLoadingStatus.dismiss;
    var result = await _api.addDocument(data.toJson()).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  FirebaseDatabase database;
  DatabaseReference reference;
  Products() {
    database = FirebaseDatabase.instance;
    reference = database.reference();
  }

  Future Insert_product(Product product) {
    // FirebaseApp.initializeApp(Context);
    // FirebaseApp.initializeApp(this);
    // database = FirebaseDatabase.instance;
    // reference = database.reference();
    reference
        .child("MMve-H6Uem2IvJ2vJSO")
        .child("MMve-H6Uem2IvJ2vJSO")
        .child("Products");
    reference.child("Stores").child("store1").child("Products").push().set({
      "name": product.name,
      "description": product.description,
      "price": product.price,
      "imageURL": product.imageURL,
    });
  }

  Future AllProducts() {
    reference
        .child("Stores")
        .child("store1")
        .child("Products")
        .limitToLast(5)
        .onChildAdded
        .listen((event) {
      Product p = Product(
        name: event.snapshot.value["name"],
        description: event.snapshot.value["description"],
        imageURL: event.snapshot.value["imageURL"],
        price: event.snapshot.value["price"],
      );
      print(p.name);
    });
  }
}
