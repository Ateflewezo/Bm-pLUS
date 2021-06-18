import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/expancess.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/expancess.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../tooles/constants/colors_app.dart' as color;

Widget SplineChart() {
  return SfCartesianChart(
    legend: Legend(
        isVisible: true,
        iconHeight: 10,
        iconWidth: 10,
        // تبديل عرض السلسلة
        toggleSeriesVisibility: true,
        // موقف عرض التوضيح
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
        // توضيح موقف اليسار واليمين
        alignment: ChartAlignment.center),
    // title: ChartTitle(text: "Spine Chart"),
    series: <ChartSeries>[
      SplineSeries<LinearSales, double>(
          dataSource: chartData,
          cardinalSplineTension: 0.9,
          splineType: SplineType.natural,
          dashArray: <double>[1, 1],
          xValueMapper: (LinearSales sales, _) => sales.month,
          yValueMapper: (LinearSales sales, _) => sales.sales),
    ],
  );
}

Widget AreaChart() {
  return SfCartesianChart(
      // title: Text(text: "Area Chart"),
      series: <ChartSeries>[
        AreaSeries<LinearSales, double>(
            dataSource: chartData,
            xValueMapper: (LinearSales sales, _) => sales.month,
            yValueMapper: (LinearSales sales, _) => sales.sales)
      ]);
}

List<LinearSales> chartData = [
  LinearSales(2, 120),
  LinearSales(3, 90),
  LinearSales(4, 220),
  LinearSales(5, 300),
  LinearSales(6, 100),
  LinearSales(7, 120),
  LinearSales(8, 90),
  LinearSales(9, 220),
  LinearSales(10, 300),
  LinearSales(11, 220),
  LinearSales(12, 300)
];

Future<LinearSales> getExpan(double month) async {
  LinearSales linearSales = LinearSales(month, 0);
  StreamBuilder(
      stream: Expancess_provider().getstatistic('date.month', month.toString()),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        for (var item in snapshot.data.docs) {
          linearSales.sales += Expancess.fromMap(item.data(), item.id).price;
        }
      });

//  QuerySnapshot docs=  Expancess_provider().getstatistic('date.month', month);
  await for (var items
      in Expancess_provider().getstatistic('date.month', month.toString())) {
    for (var doc in items.docs) {
      linearSales.sales += Expancess.fromMap(doc.data(), doc.id).price;
    }
  }
  return linearSales;
}

class LinearSales {
  double month;
  double sales;

  LinearSales(this.month, this.sales);
}

class LinearSales_worker {
  double month;
  double sales;

  LinearSales_worker({this.month, this.sales});
}
