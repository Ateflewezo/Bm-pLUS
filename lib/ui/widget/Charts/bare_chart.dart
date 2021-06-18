import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/ui/widget/Charts/chart.dart';
import '../../tooles/constants/colors_app.dart' as Constance;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:service_app/control/modules/expancess.dart';
import 'package:service_app/control/services/expancess.dart';

class ChartsDemo extends StatefulWidget {
  //
  List<LinearSales> chartData_enquam;
  List<LinearSales> chartData_expan;
  ChartsDemo({this.chartData_enquam, this.chartData_expan});

  final String title = "Charts Demo";

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  //
  List<charts.Series> seriesList;

  static List<charts.Series<LinearSales, String>> _createRandomData(
      List<LinearSales> chartData_enquam, List<LinearSales> chartData_expan) {
    return [
      charts.Series<LinearSales, String>(
        id: 'Sales',
        displayName: 'gfdgd',
        domainFn: (LinearSales sales, _) => sales.month.toString(),
        measureFn: (LinearSales sales, _) => sales.sales,
        data: chartData_enquam,
        fillColorFn: (LinearSales sales, _) {
          return charts.MaterialPalette.teal.shadeDefault;
        },
      ),
      charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.month.toString(),
        measureFn: (LinearSales sales, _) => sales.sales,
        data: chartData_expan,
        fillColorFn: (LinearSales sales, _) {
          return charts.MaterialPalette.deepOrange.shadeDefault;
        },
      ),
    ];
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(
              axisLineStyle:
                  new charts.LineStyleSpec(color: charts.MaterialPalette.white),
              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 12, // size in Pts.
                  color: charts.MaterialPalette.white),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.transparent))),
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(
              axisLineStyle:
                  new charts.LineStyleSpec(color: charts.MaterialPalette.white),
              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 12, // size in Pts.
                  color: charts.MaterialPalette.transparent),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white))),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    seriesList =
        _createRandomData(widget.chartData_enquam, widget.chartData_expan);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Constance.product_details2),
        // width: 200.w,
        padding: EdgeInsets.all(20.h),
        child: barChart(),
      ),
    );
  }
}

class Sales {
  final String year;
  final int sales;

  Sales(this.year, this.sales);
}
