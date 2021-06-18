import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/expancess.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/expancess.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Charts/chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:service_app/ui/widget/Charts/bare_chart.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../tooles/constants/colors_app.dart' as color;
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// satistics chart

class Satistics_Chart extends StatefulWidget {
  @override
  _Satistics_ChartState createState() => _Satistics_ChartState();
}

class _Satistics_ChartState extends State<Satistics_Chart> {
  List<LinearSales> _chartData_expan = [
    // LinearSales(1, 200),
    // LinearSales(6, 200),
    // LinearSales(3, 500),
  ];
  List<LinearSales> _chartData_enquam = [
    // LinearSales(1, 200),
    // LinearSales(6, 200),
    // LinearSales(3, 500),
  ];

  @override
  Future<void> initState() {
    super.initState();

    print("Creating a sample stream...");

    Stream<QuerySnapshot> stream_expan =
        Expancess_provider().fetchExpancessAsStream();
    print("Created the stream");
    stream_expan.listen((data) {
      // setState(() {
      //   _chartData_enquam.add(LinearSales(1, 200));
      // });
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
        Expancess expancess = Expancess.fromMap(item.data(), item.id);
        print("DataReceived1: " + expancess.name.toString());

        switch (expancess.date.month) {
          case "1":
            linearSales1.sales += expancess.price;

            break;
          case "2":
            linearSales2.sales += expancess.price;

            break;
          case "3":
            linearSales3.sales += expancess.price;

            break;
          case "4":
            linearSales4.sales += expancess.price;

            break;
          case "5":
            linearSales5.sales += expancess.price;

            break;
          case "6":
            linearSales6.sales += expancess.price;

            break;
          case "7":
            linearSales7.sales += expancess.price;

            break;
          case "8":
            linearSales8.sales += expancess.price;

            break;
          case "9":
            linearSales9.sales += expancess.price;

            break;
          case "10":
            linearSales10.sales += expancess.price;

            break;
          case "11":
            linearSales11.sales += expancess.price;

            break;
          case "12":
            linearSales12.sales += expancess.price;

            break;
          default:
        }
        setState(() {
          _chartData_expan.add(linearSales1);
          _chartData_expan.add(linearSales2);
          _chartData_expan.add(linearSales3);
          _chartData_expan.add(linearSales4);
          _chartData_expan.add(linearSales5);
          _chartData_expan.add(linearSales6);
          _chartData_expan.add(linearSales7);
          _chartData_expan.add(linearSales8);
          _chartData_expan.add(linearSales9);
          _chartData_expan.add(linearSales10);

          _chartData_expan.add(linearSales11);

          _chartData_expan.add(linearSales12);
        });
      }
      print("DataReceived: " + data.docs.toString());
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });

    Stream<QuerySnapshot> stream_enquam =
        Operations_provider().fetchOperation_bystate_AsStream(4, '', '');
    print("Created the stream");
    stream_enquam.listen((data) {
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

  int _operation_page = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 80.w,
          padding: const EdgeInsets.all(0.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  new RotatedBox(
                    quarterTurns: 3,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _operation_page = 1;
                        });
                      },
                      child: new Text(
                        'enters'.tr().toString(),
                        style: TextStyle(
                            fontSize: Styles().fontSize_statistic_tit1,
                            color: color.product_details1,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.product_details1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                children: [
                  new RotatedBox(
                      quarterTurns: 3,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _operation_page = 2;
                          });
                        },
                        child: new Text(
                          'expance'.tr().toString(),
                          style: TextStyle(
                              fontSize: Styles().fontSize_statistic_tit1,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: 1000.h,
          width: 650.w,
          child: ChartsDemo(
            chartData_enquam: _chartData_enquam,
            chartData_expan: _chartData_expan,
          ),
        )
        // Expanded(
        //   child: Container(
        //     width: MediaQuery.of(context).size.width,
        //     // alignment: Alignment.center,
        //     child: Transform.translate(
        //       offset: EasyLocalization.of(context).locale == Locale("ar", "SA")
        //           ? Offset(-MediaQuery.of(context).size.width * 0.8, 0) //-295
        //           : Offset(0, 0),
        //       child: SfCartesianChart(
        //         zoomPanBehavior: ZoomPanBehavior(
        //           enableMouseWheelZooming: true,
        //           enablePanning: true,
        //           selectionRectBorderColor: Colors.red,
        //           enableDoubleTapZooming: true,
        //           enableSelectionZooming: true,
        //         ),
        //         series: <ChartSeries>[
        //           // Renders column chart
        //           ColumnSeries<LinearSales, double>(
        //               width: 1,
        //               spacing: 0.2,
        //               color: color.product_details1,
        //               borderRadius: BorderRadius.all(Radius.circular(5)),
        //               dataSource: _chartData_enquam,
        //               xValueMapper: (LinearSales sales, _) => sales.month,
        //               yValueMapper: (LinearSales sales, _) => sales.sales),
        //           ColumnSeries<LinearSales, double>(
        //               width: 1,
        //               spacing: 0.2,
        //               color: Colors.red[300],
        //               borderRadius: BorderRadius.all(Radius.circular(5)),
        //               dataSource: _chartData_expan,
        //               xValueMapper: (LinearSales sales, _) => sales.month,
        //               yValueMapper: (LinearSales sales, _) => sales.sales)
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
