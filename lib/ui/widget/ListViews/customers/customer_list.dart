import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/customer.dart';
import 'package:service_app/control/services/customers.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/widget/Adapters/customers/customer_row.dart';

Widget List_customer() {
  Customers_provider customers_provider = Customers_provider();
  List<Customer> customers;
  return StreamBuilder(
      stream: customers_provider.fetchCustomerAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          customers = snapshot.data.docs
              .map((doc) => Customer.fromMap(doc.data(), doc.id))
              .toList();
          print("payments ${customers.toString()}");
          if (customers.length > 0) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: customers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Customer_Row(context, customers[index]);
                });
          } else {
            return Center(
                child: Text(
              'nodata'.tr().toString(),
              style: Styles().textStyle_nodata,
            ));
          }
        } else {
          return Center(child: Text('loading'.tr().toString()));
        }
      });
}
