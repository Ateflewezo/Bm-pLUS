class Worker_operation {
  String customer_name;
  String date_all;
  String operation_nb;
  String id;
  double price;

  //sate 1:is active  2: onwait  3 :onprogress

  int complete_operation = 0;

  Worker_operation(
      {this.customer_name, this.price, this.date_all, this.operation_nb});
  Worker_operation.fromMap(Map snapshot, String id)
      : id = id ?? '',
        price = snapshot['price'] ?? 0,
        date_all = snapshot['date_all'] ?? '',
        operation_nb = snapshot['operation_nb'] ?? '',
        customer_name = snapshot['customer_name'] ?? '';

  toJson() {
    return {
      "price": price,
      "customer_name": customer_name,
      "date_all": date_all,
      "operation_nb": operation_nb,
    };
  }
}
