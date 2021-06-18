import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:service_app/ui/widget/Charts/bare_chart.dart';
import 'package:service_app/ui/widget/Charts/chart.dart';
import 'package:service_app/ui/widget/Charts/line_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/monthes.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartSp extends StatefulWidget {
  @override
  _ChartSpState createState() => _ChartSpState();
}

class _ChartSpState extends State<ChartSp> {
  List<LinearSales> _chartData_enquam = [
    // LinearSales(1, 200),
    // LinearSales(6, 200),
    // LinearSales(3, 500),
  ];
  @override
  Future<void> initState() {
    _dropDownMenuItems = getDropDownMenuItems();

    super.initState();
    listen_enquam();
    print("Creating a sample stream...");
  }

  void listen_enquam() {
    Stream<QuerySnapshot> stream_enquam =
        Operations_provider().fetchOperation_bystate_AsStream(4, '', '');
    print("Created the stream");
    stream_enquam.listen((data) {
      LinearSales linearSales0 = LinearSales(0, 0);
      LinearSales linearSales1 = LinearSales(1, 0);
      LinearSales linearSales2 = LinearSales(2, 0);
      LinearSales linearSales3 = LinearSales(3, 0);
      LinearSales linearSales4 = LinearSales(4, 0);
      LinearSales linearSales5 = LinearSales(5, 0);
      LinearSales linearSales6 = LinearSales(6, 0);
      LinearSales linearSales7 = LinearSales(7, 0);
      LinearSales linearSales8 = LinearSales(8, 0);
      LinearSales linearSales9 = LinearSales(9, 0);
      LinearSales linearSales10 = LinearSales(10, 0);
      LinearSales linearSales11 = LinearSales(11, 0);
      LinearSales linearSales12 = LinearSales(12, 0);
      for (var item in data.docs) {
        Operation_provider operation =
            Operation_provider.fromsnapshotTOstatic(item, item.id);
        print("DataReceived1: " + operation.product_total.toString());

        switch (operation.date.month) {
          case "1":
            linearSales1.sales +=
                operation.product_total + operation.service_total;

            break;
          case "2":
            linearSales2.sales +=
                operation.product_total + operation.service_total;

            break;
          case "3":
            linearSales3.sales +=
                operation.product_total + operation.service_total;

            break;
          case "4":
            linearSales4.sales +=
                operation.product_total + operation.service_total;

            break;
          case "5":
            linearSales5.sales +=
                operation.product_total + operation.service_total;

            break;
          case "6":
            linearSales6.sales +=
                operation.product_total + operation.service_total;

            break;
          case "7":
            linearSales7.sales +=
                operation.product_total + operation.service_total;

            break;
          case "8":
            linearSales8.sales +=
                operation.product_total + operation.service_total;

            break;
          case "9":
            linearSales9.sales +=
                operation.product_total + operation.service_total;

            break;
          case "10":
            linearSales10.sales +=
                operation.product_total + operation.service_total;

            break;
          case "11":
            linearSales11.sales +=
                operation.product_total + operation.service_total;
            break;
          case "12":
            linearSales12.sales +=
                operation.product_total + operation.service_total;

            break;
          default:
        }
        setState(() {
          _chartData_enquam.add(linearSales0);
          _chartData_enquam.add(linearSales1);
          _chartData_enquam.add(linearSales2);
          _chartData_enquam.add(linearSales3);
          _chartData_enquam.add(linearSales4);
          _chartData_enquam.add(linearSales5);
          _chartData_enquam.add(linearSales6);
          _chartData_enquam.add(linearSales7);
          _chartData_enquam.add(linearSales8);
          _chartData_enquam.add(linearSales9);
          _chartData_enquam.add(linearSales10);
          _chartData_enquam.add(linearSales11);
          _chartData_enquam.add(linearSales12);
        });
      }
      print("DataReceived: " + data.docs.toString());
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });

    print("code controller is here");
  }

  @override
  Widget build(BuildContext context) {
    return BarChart();
  }

  List<DropdownMenuItem<int>> getDropDownMenuItems() {
    List<DropdownMenuItem<int>> items = new List();
    for (var item in [0, 1, 2, 3, 4, 6, 7, 8, 9, 10]) {
      items.add(new DropdownMenuItem(
        value: 2020 + item,
        child: new Text((2020 + item).toString()),
        onTap: () {
          setState(() {});
        },
      ));
    }

    return items;
  }

//////fore home
  int _currentlan = 2020;
  Widget BarChart() {
    return SafeArea(
        child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Text('Wills'.tr().toString()),
                ),
                DropdownButton(
                  value: _currentlan,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
              ],
            ),
            Container(
                height: 500.h,
                width: 750.w,
                child: AreaAndLineChart.withSampleData(_chartData_enquam)),

            // Align(
            //   alignment:
            //       EasyLocalization.of(context).locale == Locale("ar", "SA")
            //           ? Alignment.center
            //           : Alignment(0, 0),
            //   child: Container(
            //     height: 500.h,
            //     width: 500.w,
            //     alignment: Alignment.center,
            //     child: Transform.translate(
            //       offset:
            //           EasyLocalization.of(context).locale == Locale("ar", "SA")
            //               ? Offset(0.w, 0)
            //               : Offset(0, 0),
            //       child: SfCartesianChart(
            //         zoomPanBehavior: ZoomPanBehavior(
            //           enableMouseWheelZooming: true,
            //           enablePanning: true,
            //           selectionRectBorderColor: Colors.red,
            //           enableDoubleTapZooming: true,
            //           enableSelectionZooming: true,
            //         ),
            //         series: <ChartSeries>[
            //           SplineSeries<LinearSales, double>(
            //               dataSource: _chartData_enquam,
            //               cardinalSplineTension: 0.9,
            //               splineType: SplineType.natural,
            //               dashArray: <double>[1, 1],
            //               xValueMapper: (LinearSales sales, _) => sales.month,
            //               yValueMapper: (LinearSales sales, _) => sales.sales),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }

  List<DropdownMenuItem<int>> _dropDownMenuItems;

  void changedDropDownItem(int selectedlan) {
    setState(() {
      _currentlan = selectedlan;
    });
  }
}
