import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Charts/bare_chart_worker.dart';

import '../../widget/currency_text.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/worker.dart';

import 'package:service_app/ui/widget/Charts/chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Worker_Chart extends StatefulWidget {
  List<Worker> workers;
  Worker_Chart({this.workers});

  @override
  _Worker_ChartState createState() => _Worker_ChartState();
}

bool contains(Worker worker, List<LinearSales_worker> chartData_worker) {
  if ((chartData_worker.singleWhere((it) => it.sales == worker.salery,
          orElse: () => null)) !=
      null) {
    print('Already exists!');
    return true;
  } else {
    print('Added!');
    return false;
  }
}

class _Worker_ChartState extends State<Worker_Chart> {
  double _total_salary = 0.0;
  List<LinearSales_worker> chartData_worker = [];
  void calcul_worker_salery() {
    for (var worker in widget.workers) {
      print("DataReceived_inworker: " + worker.name.toString());
      _total_salary += worker.salery;

      if (chartData_worker.length == 0) {
        LinearSales_worker linearSales =
            LinearSales_worker(sales: worker.salery, month: 1);
        chartData_worker.add(linearSales);
      } else {
        if (contains(worker, chartData_worker)) {
          print("object added 11");

          int _i = chartData_worker
              .indexWhere((element) => element.sales == worker.salery);
          LinearSales_worker item = chartData_worker[_i];
          item.month ++;
          chartData_worker.removeAt(_i);
          chartData_worker.add(item);
          print("object added ${item.month} + +${item.sales}");
        } else {
          LinearSales_worker linearSales =
              LinearSales_worker(sales: worker.salery, month: 1);
          chartData_worker.add(linearSales);
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     try {
      calcul_worker_salery();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
   
    var _padding = EdgeInsets.symmetric(horizontal: 40.w);
    return Container(
      child: Column(children: [
        Container(
          height: 180.h,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Color(0XFF37DCC6), Color(0XFF175CB2)])),
          child: Column(
            children: [
              SizedBox(
                height: 0.h,
              ),
              Padding(
                padding: _padding,
                child: ListTile(
                  leading: Container(
                    width: 80.w,
                    height: 80.w,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image(
                        color: Colors.blue,
                        image: AssetImage("res/images/celluar.png"),
                      ),
                    ),
                  ),
                  title: Text(
                    "total_year".tr().toString(),
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: Styles().fontSize_name),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Satictic_currency(context, _total_salary,
                        Colors.white, Styles().fontSize_price),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 750.w,
          height: 500.h,
          child: ChartData_worker(
            chartData_worker: chartData_worker,
          ),
        ),
      ]),
    );
  }
}
