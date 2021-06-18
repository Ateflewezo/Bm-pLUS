/// Line chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:service_app/ui/widget/Charts/chart.dart';

class AreaAndLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  AreaAndLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory AreaAndLineChart.withSampleData(var chartData_enquam) {
    return new AreaAndLineChart(
      _createSampleData(chartData_enquam),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return new charts.NumericComboChart(seriesList,
    //     animate: animate,
    //     // Configure the default renderer as a line renderer. This will be used
    //     // for any series that does not define a rendererIdKey.
    //     defaultRenderer: new charts.LineRendererConfig(),
    //     // Custom renderer configuration for the point series.
    //     customSeriesRenderers: [
    //       new charts.PointRendererConfig(
    //           // ID used to link series to this renderer.
    //           customRendererId: 'customPoint')
    //     ]);

    return new charts.NumericComboChart(seriesList,
        animate: animate,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        customSeriesRenderers: [
          new charts.LineRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customArea',
              includeArea: true,
              stacked: false),
        ]);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, double>> _createSampleData(
      var chartData_enquam) {
    List<LinearSales> myData = chartData_enquam;

    return [
      new charts.Series<LinearSales, double>(
        id: 'myData',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.month,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myData,
      )
        // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customArea'),
    ];
  }
}
