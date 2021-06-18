import 'package:service_app/control/modules/date.dart';

class Expancess {
  String name;
  String date_all;
  String type;
  String id;
  double price;
  Date date;

  //sate 1:is active  2: onwait  3 :onprogress

  int complete_operation = 0;

  Expancess({this.name, this.price, this.date, this.date_all, this.type});
  Expancess.fromMap(Map snapshot, String id)
      : id = id ?? '',
        price = snapshot['price'] ?? 0,
        date_all = snapshot['date_all'] ?? '',
        type = snapshot['type'] ?? '',
        date = Date.fromMap(snapshot['date'] ?? '', id),
        name = snapshot['name'] ?? '';

  toJson() {
    return {
      "price": price,
      "name": name,
      "type": type,
      "date": date.toJson(),
      "date_all": date_all,
    };
  }

  toJson_update() {
    return {
      "price": price,
      "name": name,
    };
  }
}
