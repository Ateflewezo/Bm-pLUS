import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String phone_number;
  String password;
  String id;
  String imageURL;
  String type;
  String store_id = 'uid_of_store_number01';

  List<Permission> operations_permissions = [
    Permission(name: "add", value: false),
    Permission(name: "edit", value: false),
    Permission(name: "remove", value: false)
  ];
  List<Permission> services_permissions = [
    Permission(name: "add", value: false),
    Permission(name: "edit", value: false),
    Permission(name: "remove", value: false)
  ];
  List<Permission> products_permissions = [
    Permission(name: "add", value: false),
    Permission(name: "edit", value: false),
    Permission(name: "remove", value: false)
  ];
  List<Permission> users_permissions = [
    Permission(name: "add", value: false),
    Permission(name: "edit", value: false),
    Permission(name: "remove", value: false)
  ];
  //sate 1:is active  2: onwait  3 :onprogress

  int complete_operation = 0;

  User(
      {this.name,
      this.phone_number,
      this.imageURL,
      this.type,
      this.store_id,
      this.password,
      this.operations_permissions,
      this.services_permissions,
      this.products_permissions,
      this.users_permissions});
  User.fromsnapshot(DocumentSnapshot snap, String id)
      : id = id ?? '',
        name = snap.get('name') ?? '',
        store_id = snap.get('store_id') ?? '',
        type = snap.get('type') ?? '',
        phone_number = snap.get('phone_number') ?? '',
        imageURL = snap.get('imageURL') ?? '';

  User.fromsnapshot_details(DocumentSnapshot snap, String id)
      : id = id ?? '',
        operations_permissions = snap
                .get('operations_permissions')
                .map<Permission>((p) => Permission.fromMap(p, id))
                .toList() ??
            [],
        services_permissions = snap
                .get('services_permissions')
                .map<Permission>((p) => Permission.fromMap(p, id))
                .toList() ??
            [],
        products_permissions = snap
                .get('products_permissions')
               
                .map<Permission>((p) => Permission.fromMap(p, id))
                .toList() ??
            [],
        users_permissions = snap
                .get('users_permissions')
                
                .map<Permission>((p) => Permission.fromMap(p, id))
                .toList() ??
            [],
        name = snap.get('name') ?? '',
        password = snap.get('password') ?? '',
        type = snap.get('type') ?? '',
        store_id = snap.get('store_id') ?? '',
        phone_number = snap.get('phone_number') ?? '',
        imageURL = snap.get('imageURL') ?? '';
  toJson() {
     operations_permissions = [
    Permission(name: "add", value: false),
    Permission(name: "edit", value: false),
    Permission(name: "remove", value: false)
  ];
   services_permissions = [
    Permission(name: "add", value: false),
    Permission(name: "edit", value: false),
    Permission(name: "remove", value: false)
  ];
   products_permissions = [
    Permission(name: "add", value: false),
    Permission(name: "edit", value: false),
    Permission(name: "remove", value: false)
  ];
  users_permissions = [
    Permission(name: "add", value: false),
    Permission(name: "edit", value: false),
    Permission(name: "remove", value: false)
  ];
    return {
      "complete_operation": complete_operation,
      "name": name,
      "store_id": store_id,
      "type": type,
      "phone_number": phone_number,
      "password": password,
      "imageURL": imageURL,
      "operations_permissions":
          operations_permissions.map((p) => p.toJson()).toList(),
      "products_permissions":
          products_permissions.map((p) => p.toJson()).toList(),
      "services_permissions":
          services_permissions.map((p) => p.toJson()).toList(),
      "users_permissions": users_permissions.map((p) => p.toJson()).toList(),
    };
  }

  toJson_inf() {
    return {
      "store_id": store_id,
      "name": name,
      "type": type,
      "imageURL": imageURL,
    };
  }
}

class Permission {
  String name;
  bool value;
  String id;
  Permission({this.name, this.value});
  Permission.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['name'] ?? '',
        value = snapshot['value'] ?? false;

  toJson() {
    return {
      "name": name,
      "value": value,
    };
  }
}
