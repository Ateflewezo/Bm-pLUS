import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/tooles/constants/colors_app.dart' as Constants;
import 'package:shared_preferences/shared_preferences.dart';
import '../../ui/widget/onBoarding/onboardingscreen.dart' as onbord;

import '../services/locator.dart';

class SMS_number {
  final String user_number;
  final String sms_number;
  final String store_name;
  SMS_number({this.sms_number, this.user_number, this.store_name});
}

class Store_classe {
  String id = 'uid_of_store_number01';
  String name;
  String sms_number;
  String image;
  String unite;
  String iso;
  bool status;
  Store_classe fromsnapshot(DocumentSnapshot snapshot, String id) {
    return Store_classe(
        id: id ?? '',
        name: snapshot.get('name') ?? '',
        unite: snapshot.get('unite') ?? 'USD',
        iso: snapshot.get('iso') ?? 'us',
        sms_number: snapshot.get('sms_number') ?? '',
        image: snapshot.get('image') ?? null,
        status: snapshot.get('status') ?? true);
  }

  Store_classe(
      {this.name,
      this.image,
      this.id,
      this.unite,
      this.sms_number,
      this.status,
      this.iso});
  toJson() {
    return {
      "name": name,
      "iso": iso,
      "unite": unite,
      "sms_number": sms_number,
      "image": image,
    };
  }
}

class Store {
  Future<String> getStore_currency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.CURRENCY) ?? 'USD';
  }

  Future<String> getStore_isocode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.ISO) ?? 'us';
  }

  Future<void> setStore_currency(String currency) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.CURRENCY, currency);
  }

  Future<void> setStore_isocode(String iso) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.ISO, iso);
  }

  Future<SMS_number> getSMSnumber_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return SMS_number(
        sms_number: (prefs.getString(Constants.SMS_NUMBER) ?? "000"),
        user_number: prefs.getString(Constants.USER_PHONE) ?? '001',
        store_name: prefs.getString(Constants.STORE_NAME) ?? 'BM+');
  }

  Future<Store_classe> getStore_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Store_classe(
        id: (prefs.getString(Constants.STOREID) ?? " "),
        name: prefs.getString(Constants.STORE_NAME) ?? 'BM+',
        image: prefs.getString(Constants.STORE_IMG) ?? null,
        unite: prefs.getString(Constants.CURRENCY) ?? 'USD',
        iso: prefs.getString(Constants.ISO) ?? 'us',
        sms_number: prefs.getString(Constants.SMS_NUMBER) ?? '');
  }

  Future<Store_classe> setStore_data(Store_classe store, User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.STORE_NAME, store.name);
    prefs.setString(Constants.SMS_NUMBER, store.sms_number);
    prefs.setString(Constants.STORE_IMG, store.image);
    prefs.setString(Constants.ISO, store.iso);
    prefs.setString(Constants.CURRENCY, store.unite);
    setuplocator_message(store.sms_number, user.phone_number);
  }

  Future<User> getStore_Info() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // name = "مغسلة سوف";
    // image = "res/images/logo_test.png";
    User user = User(
        phone_number: (prefs.getString(Constants.USER_PHONE) ?? " "),
        store_id: (prefs.getString(Constants.STOREID) ?? " "),
        name: (prefs.getString(Constants.NAME) ?? ''),
        type: (prefs.getString(Constants.TYPE) ?? ''),
        imageURL: (prefs.getString(Constants.IMAGE) ?? ''),
        operations_permissions: [
          Permission(
              name: 'add',
              value: prefs.getBool('operations_permissions.add') ?? false),
          Permission(
              name: 'edit',
              value: prefs.getBool('operations_permissions.edit') ?? false),
          Permission(
              name: 'remove',
              value: prefs.getBool('operations_permissions.remove') ?? false),
        ],
        services_permissions: [
          Permission(
              name: 'add',
              value: prefs.getBool('services_permissions.add') ?? false),
          Permission(
              name: 'edit',
              value: prefs.getBool('services_permissions.edit') ?? false),
          Permission(
              name: 'remove',
              value: prefs.getBool('services_permissions.remove') ?? false),
        ],
        products_permissions: [
          Permission(
              name: 'add',
              value: prefs.getBool('products_permissions.add') ?? false),
          Permission(
              name: 'edit',
              value: prefs.getBool('products_permissions.edit') ?? false),
          Permission(
              name: 'remove',
              value: prefs.getBool('products_permissions.remove') ?? false),
        ],
        users_permissions: [
          Permission(
              name: 'add',
              value: prefs.getBool('users_permissions.add') ?? false),
          Permission(
              name: 'edit',
              value: prefs.getBool('users_permissions.edit') ?? false),
          Permission(
              name: 'remove',
              value: prefs.getBool('users_permissions.remove') ?? false),
        ]);

    print(prefs.getString(Constants.NAME));

    print(user.toString());
    return user;
  }

  Future<void> setlogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    onbord.setFinishedOnBoarding();
  }

  Future<void> setloginData(User user, bool login) async {
    setuplocator_Store(user.store_id, user.id);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constants.LOGIN, login);
    prefs.setString(Constants.NAME, user.name);
    prefs.setString(Constants.USER_PHONE, user.phone_number);
    prefs.setString(Constants.STOREID, user.store_id);
    prefs.setString(Constants.TYPE, user.type);
    prefs.setString(Constants.IMAGE, user.imageURL);
    for (var item in user.operations_permissions) {
      prefs.setBool('operations_permissions.${item.name}', item.value);
    }
    for (var item in user.services_permissions) {
      prefs.setBool('services_permissions.${item.name}', item.value);
    }
    for (var item in user.products_permissions) {
      prefs.setBool('products_permissions.${item.name}', item.value);
    }
    for (var item in user.users_permissions) {
      prefs.setBool('users_permissions.${item.name}', item.value);
    }
  }

  Future hasregistdata(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool login = (prefs.getBool(Constants.LOGIN) ?? false);
    String sms_number = prefs.getString(Constants.SMS_NUMBER) ?? '000';
    if (login) {
      Stream<User> user = Stream.fromFuture(Store().getStore_Info());
      user.listen((event) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/home", (Route<dynamic> route) => false);

        setuplocator_message(sms_number, event.phone_number);

        setuplocator_Store(event.store_id, event.phone_number);
      });
    } else {
      EasyLocalization.of(context).locale = Locale("ar", "SA");
      Navigator.pushNamedAndRemoveUntil(
          context, "/login", (Route<dynamic> route) => false);
    }
  }
}
