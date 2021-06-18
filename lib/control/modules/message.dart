import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String date;
  String body;
  List<String> client_number = [];
  String id;

  Message({this.date, this.body, this.client_number});
  Message.fromMap(Map snapshot, String id)
      : id = id ?? '',
        date = snapshot['date'] ?? '',
        body = snapshot['body'] ?? '',
        client_number =
            snapshot['client_number'].map<String>((p) => p).toList() ?? [];
  //  snapshot['client_number'] ?? '';
  Message.fromsnapshot(DocumentSnapshot snap, String id)
      : id = id ?? '',
        date = snap.get('date') ?? '',
        body = snap.get('body') ?? '',
        client_number = snap
                .get('client_number')
                .map<String>((p) => p.toString() ?? '')
                .toList() ??
            [];
  toJson() {
    return {
      "date": date,
      "client_number": client_number.map((p) => p).toList(),
      "body": body,
    };
  }
}
