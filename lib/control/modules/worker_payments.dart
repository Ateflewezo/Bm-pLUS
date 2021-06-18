import 'package:easy_localization/easy_localization.dart';

class Payment {
  String type;
  String date;
  String id;

  double salery_rn = 0.0;
  double paided = 0.0;

  String month;

  double comission_rn = 0.0;

  Payment(
      {this.date, this.paided, this.comission_rn, this.salery_rn, this.month,this.type});
  Payment.fromMap(Map snapshot, String id)
      : id = id ?? '',
        date = snapshot['date'] ?? '',
        type = snapshot['type'] ?? '',
        paided = snapshot['paided'] ?? 0.0,
        comission_rn = snapshot['comission_rn'] ?? 0.0,
        salery_rn = snapshot['salery_rn'] ?? 0.0;

  toJson() {
    return {
      "date": date,
      "type": type,
      "paided": paided,
      "comission_rn": comission_rn,
      "salery_rn": salery_rn,
      "month": month,
    };
  }
}
