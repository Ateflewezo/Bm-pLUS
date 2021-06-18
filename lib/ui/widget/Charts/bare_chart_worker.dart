import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/ui/widget/Charts/chart.dart';

class ChartData_worker extends StatefulWidget {
  //
  List<LinearSales_worker> chartData_worker;
  ChartData_worker({this.chartData_worker});

  final String title = "Charts Demo";

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartData_worker> {
  //
  List<charts.Series> seriesList;
//  static const white_trans = Color(r: 255, g: 255, b: 255, a: 50);

  static List<charts.Series<LinearSales_worker, String>> _createRandomData(
      List<LinearSales_worker> chartData_worker) {
    return [
      charts.Series<LinearSales_worker, String>(
        id: 'Sales',
        displayName: 'gfdgd',
        domainFn: (LinearSales_worker sales, _) => sales.sales.toString(),
        measureFn: (LinearSales_worker sales, _) => sales.month,
        data: chartData_worker,
        fillColorFn: (LinearSales_worker sales, _) {
          return charts.MaterialPalette.white_trans;
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
                  color: charts.MaterialPalette.white),

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
    seriesList = _createRandomData(widget.chartData_worker);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Color(0XFF37DCC6), Color(0XFF175CB2)])),
        padding: EdgeInsets.all(10.h),
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
