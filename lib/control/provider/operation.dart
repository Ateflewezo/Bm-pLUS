import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:service_app/control/modules/customer.dart';
import 'package:service_app/control/modules/date.dart';
import 'package:service_app/control/modules/product.dart';
import 'package:service_app/control/modules/service.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:currency_pickers/country.dart';

class Operation_provider with ChangeNotifier {
  Currency currency = Currency.create('USD', 2);
  void setcurrency(Country currency) {
    print(
        "contry ${currency.iso3Code.toString() + '/ ' + currency.isoCode.toString()}");
    Store().setStore_currency(currency.currencyCode);
    Store().setStore_isocode(currency.isoCode);
    notifyListeners();
  }

  Future<void> getcurrency() async {
    currency = Currency.create(await Store().getStore_currency(), 2);
    notifyListeners();
  }

  Future<String> getmoney(double amount, String format) async {
    await getcurrency();
    Money lowPrice = Money.from(amount, currency);
    print(lowPrice.format('SCC000.000'));
    print(lowPrice.format('CCC 0.0'));

    return lowPrice.format(format);
  }

  //////////
  Customer customer = null;
  bool new_operation = true;

  bool _have_custom = false;
  bool get have_custom => _have_custom;
  String id;
  String uid;
  String date_all;
  int state = 0;
  double product_total = 0.0;
  double service_total = 0.0;
  double paid = 0.0;
  Date date = null;
// void liber() {notifyListeners();}

  void liber() {
    _have_custom = false;
    state = 0;
    new_operation = true;
    product_total = 0.0;
    service_total = 0.0;
    paid = 0.0;
    customer = null;
    _serviceslist = [];
    _productslist = [];
  }

  // Operation_provider();
  toJson() {
    return {
      "id": id,
      "date": date.toJson(),
      "date_all": date_all,
      "product_total": product_total,
      "service_total": service_total,
      "paid": paid,
      "state": state,
      "customer": customer.toJson_addOperation(),
      "productslist": _productslist.map((p) => p.toJson()).toList(),
      "serviceslist": _serviceslist.map((p) => p.toJson()).toList(),
    };
  }

  Add_Payment(double moment) {
    return {
      "paid": moment,
    };
  }

  Update_state() {
    return {
      "state": state,
      "paid": paid,
    };
  }

  Operation_provider.fromMap(Map snapshot, String id)
      : id = id ?? '',
        _productslist =
            List.from(snapshot['productslist'] as Iterable<dynamic>) ?? [],
        date_all = snapshot['date_all'] ?? '',
        state = snapshot['state'] ?? 1,
        customer =
            Customer.fromMap(snapshot['customer'], snapshot['customer.id']) ??
                '',
        date = Date.fromMap(snapshot['date'], id) ?? '';
  Operation_provider.fromsnapshotTOstatic(DocumentSnapshot snap, String id)
      : uid = id ?? '',
        service_total = snap.get('service_total') ?? 0.0,
        product_total = snap.get('product_total') ?? 0.0,
        date = Date.fromMap(snap['date'], id) ?? '';

  Operation_provider.fromsnapshot(DocumentSnapshot snap, String id)
      : uid = id ?? '',
        _productslist = snap
                .get('productslist')
                .map<Product>((p) => Product.fromMap(p, p['id']))
                .toList() ??
            [],
        date = Date.fromMap(snap.get('date'), id) ?? '',
        date_all = snap.get('date_all') ?? '',
        id = snap.get('id') ?? '',
        service_total = snap.get('service_total') ?? 0.0,
        product_total = snap.get('product_total') ?? 0.0,
        paid = snap.get('paid') ?? 0.0,
        state = snap.get('state') ?? 1,
        customer = Customer.fromMap(snap.get('customer'), '') ?? '',
        _serviceslist = snap
                .get('serviceslist')
                .map<Service>((p) => Service.fromMap(p, p['id']))
                .toList() ??
            [];

  ////////////////

  // Customer get customer => customer;
  void addCustomer(Customer _customer) {
    print("customer ${_customer.toJson().toString()}");
    customer = null;
    customer = new Customer(
      name: _customer.name,
      phone_number: _customer.phone_number,
      complete_operation: _customer.complete_operation,
    );
    _have_custom = true;
    // notifyListeners();
  }

////////
  void Paid(double moment) {
    paid += moment;
    notifyListeners();
  }

  ////////////////////////////////////////////////
  List<Product> _productslist = [];
  List<Product> get productslist => _productslist;
  void addToProducts(index, Product product) {
    if (contains(product)) {
      print('Already exists! bbbbbb');
 
      _productslist[
              _productslist.indexWhere((element) => element.id == product.id)]
          .quantity += 1;
      product_total += product.price;

      print(
          "quantity ${_productslist[_productslist.indexWhere((element) => element.id == product.id)].quantity}");
    } else {
      _productslist.add(product);
      product_total += product.price * product.quantity;
    }
    notifyListeners();
  }

  bool contains(Product product) {
    if ((_productslist.singleWhere((it) => it.id == product.id,
            orElse: () => null)) !=
        null) {
      print('Already exists!');
      return true;
    } else {
      print('Added!');
      return false;
    }
  }

  void removToProducts(Product product) {
    if (contains(product)) {
      _productslist[_productslist
                      .indexWhere((element) => element.id == product.id)]
                  .quantity >
              1
          ? _productslist[_productslist
                  .indexWhere((element) => element.id == product.id)]
              .quantity -= 1
          : clearProducts(product);
      product_total -= product.price;
      notifyListeners();
    }
  }

  void clearProducts(Product product) {
    print("remove object");
    if (contains(product)) {
      print("remove1 object");

      _productslist.removeAt(
          _productslist.indexWhere((element) => element.id == product.id));
      notifyListeners();
    }
  }

  void updatebloc(Operation_provider op) {
    for (var item in op.serviceslist) {
      if (!contains_service(item)) addToServices(item, false);
    }
    for (var item in op.productslist) {
      if (!contains(item)) addToProducts(item.id, item);
    }

    paid = op.paid;
    date = op.date;
    id = op.id;
    uid = op.uid;
    date_all = op.date_all;
    state = op.state;
    customer = op.customer;
  }

/////////////////////////////////////////////////////
  List<Service> _serviceslist = [];
  List<Service> get serviceslist => _serviceslist;
  Service _waiting_service = null;
  Service get waiting_service => _waiting_service;
  void addWaiting_service(Service service, Worker worker) {
    if (_waiting_service != null && _waiting_service.id == service.id) {
      if (worker != null) {
        if (contains_worker(worker)) {
          _waiting_service.workers.removeAt(_waiting_service.workers
              .indexWhere((element) => element.id == worker.id));
        } else {
          _waiting_service.workers.add(worker);
        }
      }
    } else {
      _waiting_service = service;
      if (worker != null) _waiting_service.workers.add(worker);
    }

    notifyListeners();
  }

  bool contains_worker(Worker worker) {
    if ((_waiting_service.workers
            .singleWhere((it) => it.id == worker.id, orElse: () => null)) !=
        null) {
      print('Already exists!');
      return true;
    } else {
      print('Added!');
      return false;
    }
  }

  Worker get_worker(Worker worker) {
    return _waiting_service.workers[_waiting_service.workers
        .indexWhere((element) => element.id == worker.id)];
  }

  void addToServices(Service service, bool can_delete) {
    if (contains_service(service)) {
      if (can_delete) {
        _serviceslist[_serviceslist
            .indexWhere((element) => element.id == service.id)] = service;
      } else {
        _serviceslist[
                _serviceslist.indexWhere((element) => element.id == service.id)]
            .quantity += 1;
        service_total += service.price;
      }
    } else {
      _serviceslist.add(service);
    }
    _waiting_service = null;
    service_total += service.price;
    notifyListeners();
  }

  bool contains_service(Service service) {
    if ((_serviceslist.singleWhere((it) => it.id == service.id,
            orElse: () => null)) !=
        null) {
      print('Already exists!');
      return true;
    } else {
      print('Added!');
      return false;
    }
  }

  Service get_service(Service service) {
    return _serviceslist[
        _serviceslist.indexWhere((element) => element.id == service.id)];
  }

  void removoneToservice(Service service) {
    if (contains_service(service)) {
      _serviceslist[_serviceslist
                      .indexWhere((element) => element.id == service.id)]
                  .quantity >
              1
          ? _serviceslist[_serviceslist
                  .indexWhere((element) => element.id == service.id)]
              .quantity -= 1
          : clearServices(service);
      service_total -= service.price;
      notifyListeners();
    }
  }

  void removToServices(Service service) {
    if (contains_service(service)) {
      // _serviceslist[_serviceslist
      //                 .indexWhere((element) => element.id == service.id)]
      //             .quantity >
      //         1
      //     ? _productslist[_productslist
      //             .indexWhere((element) => element.id == service.id)]
      //         .quantity -= 1
      //     :
      clearServices(service);
      service_total -= service.price;

      notifyListeners();
    }
  }

  void clearServices(Service service) {
    print("remove object");
    if (contains_service(service)) {
      print("remove1 object");

      _serviceslist.removeAt(
          _serviceslist.indexWhere((element) => element.id == service.id));
      notifyListeners();
    }
  }

  Operation_provider(
      // {
      // this.id,
      // this.state,
      // this.customer,
      // this.product_total,
      // this.service_total,
      // this.paid,
      // }
      );
}
