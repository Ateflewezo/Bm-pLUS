class Worker {
  bool salaire;
  String salaire_month;
  String salaire_date;
  String salaire_year;
  String name;
  String phone_number;
  String id;
  String imageURL;
  double salery;
  bool selected = false;
  bool with_comission = true;
  //sate   0:is avilabel 1:is active  2: onwait  3 :onprogress
  int state = 1;
  int complete_operation = 0;
  double total_salary = 0.0;
  double total_paid = 0.0;
  double comission_paid = 0.0;
  double comission = 0.0;

  Worker(
      {this.name,
      this.salery,
      this.state,
      this.phone_number,
      this.imageURL,
      this.with_comission});
  Worker.fromMap(Map snapshot, String id)
      : id = id ?? '',
        total_salary = snapshot['total_salary'] ?? 0.0,
        salery = snapshot['salery'] ?? 0.0,
        state = snapshot['state'] ?? 1,
        complete_operation = snapshot['complete_operation'] ?? 0,
        total_paid = snapshot['total_paid'] ?? 0.0,
        comission = snapshot['comission'] ?? 0.0,
        comission_paid = snapshot['comission_paid'] ?? 0.0,
        name = snapshot['name'] ?? '',
        salaire_month = snapshot['salaire_month'] ?? '',
        salaire_year = snapshot['salaire_year'] ?? '',
        salaire_date = snapshot['salaire_date'] ?? '',
        salaire = snapshot['salaire'] ?? false,
        with_comission = snapshot['with_comission'] ?? true,
        imageURL = snapshot['imageURL'] ?? '',
        phone_number = snapshot['phone_number'] ?? '0021365289652';

  toJson() {
    return {
      "id": id,
      "salery": salery,
      "with_comission": with_comission,
      "complete_operation": complete_operation,
      "total_paid": total_paid,
      "comission": comission,
      "total_salary": total_salary,
      "state": state,
      "name": name,
      "phone_number": phone_number,
      "imageURL": imageURL,
    };
  }

  toJson_total_paid() {
    return {
      "total_paid": total_paid,
      "comission_paid": comission_paid,
      "salaire": salaire,
      "salaire_month": salaire_month,
      "salaire_year": salaire_year,
      "salaire_date": salaire_date,
    };
  }

  toJson_state() {
    return {
      "state": state,
    };
  }

  toJson_comission() {
    return {
      "comission": comission,
      "complete_operation": complete_operation,
      "state": 0,
    };
  }
}
