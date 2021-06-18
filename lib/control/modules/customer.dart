class Customer {
  String name;
  String phone_number;
  String id;
  String imageURL;
  bool selected = false;
  //sate 1:is active  2: onwait  3 :onprogress

  int complete_operation = 0;

  Customer({this.name, this.phone_number, this.complete_operation});
  Customer.fromMap(Map snapshot, String id)
      : id = id ?? '',
        complete_operation = snapshot['complete_operation'] ?? 0,
        name = snapshot['name'] ?? '',
        phone_number = snapshot['phone_number'] ?? '0021365289652';

  toJson() {
    return {
      "complete_operation": complete_operation,
      "name": name,
      "phone_number": phone_number,
    };
  }

  toJson_addOperation() {
    return {
      "name": name,
      "phone_number": phone_number,
    };
  }

  toJson_complete_operation() {
    return {
      "complete_operation": complete_operation,
    };
  }
}
