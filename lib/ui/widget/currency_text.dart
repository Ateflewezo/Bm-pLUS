import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/provider/operation.dart';

Widget Satictic_currency(
    BuildContext context, double amount, Color textcolor, double textsize) {
  var bloc = Operation_provider();
  return FutureBuilder(
    future: bloc.getmoney(amount, 'CCC 00.00'),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Text(
          "${(snapshot.data.toString())}",
          maxLines: 1,
          style: TextStyle(fontSize: textsize, color: textcolor),
        );
      } else {
        return Text(
          "000.00",
          maxLines: 1,
          style: TextStyle(fontSize: textsize, color: textcolor),
        );
      }
    },
  );
}

Widget adapter_currency(
    BuildContext context, double amount, Color textcolor, double textsize) {
  var bloc = Operation_provider();
  return FutureBuilder(
    future: bloc.getmoney(amount, 'CCC 00'),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Text(
          "${(snapshot.data.toString())}",
          maxLines: 1,
          style: TextStyle(
              fontSize: textsize,
              fontWeight: FontWeight.bold,
              color: textcolor),
        );
      } else {
        return Text(
          "000.00",
          maxLines: 1,
          style: TextStyle(fontSize: textsize, color: textcolor),
        );
      }
    },
  );
}
