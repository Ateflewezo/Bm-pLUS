import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_app/control/modules/worker.dart';

class Service {
  String name;
  String id;
  String description;
  String imageURL;
  double price;
  double commission;
  String uid;
  int quantity = 1;
  List<Worker> workers = [];

  Service(
      {this.name,
      this.description,
      this.imageURL,
      this.price,
      this.commission});
  Service.fromMap(Map snapshot, String id)
      : id = id ?? '',
        quantity = snapshot['quantity'] ?? 1,
        price = snapshot['price'] ?? '',
        commission = snapshot['commission'] ?? '',
        name = snapshot['name'] ?? '',
        imageURL = snapshot['imageURL'] ?? '',
        workers = snapshot['workers']
                .map<Worker>((p) => Worker.fromMap(p, p['id'] ?? ''))
                .toList() ??
            [];

  Service.fromsnapshot(DocumentSnapshot snap, String id)
      : uid = id ?? '',
        workers = snap
                .get('workers')
                .map<Worker>((p) => Worker.fromMap(p, p.get('id') ?? ''))
                .toList() ??
            [],
        quantity = snap.get('quantity') ?? 1,
        id = snap.get('id') ?? '',
        price = snap.get('price') ?? 0.0,
        commission = snap.get('commission') ?? 0.0,
        name = snap.get('name') ?? '',
        imageURL = snap.get('imageURL') ?? '';

  toJson() {
    return {
      "id": id != null ? id : null,
      "workers": workers.map((p) => p.toJson()).toList(),
      "price": price,
      "commission": commission,
      "name": name,
      "imageURL": imageURL,
      "quantity": quantity,
    };
  }
}
