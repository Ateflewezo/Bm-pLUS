import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:service_app/control/services/worker.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Adapters/worker/worker_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/widget/Charts/worker.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:service_app/ui/widget/Popups/Workers/add_new.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class List_Workers extends StatefulWidget {
  @override
  _List_WorkersState createState() => _List_WorkersState();
}

class _List_WorkersState extends State<List_Workers> {
  Workers_provider workers_provider = Workers_provider();
  List<Worker> workers;
  @override
  Widget build(BuildContext context) {
    var _padding = EdgeInsets.symmetric(horizontal: 50.w);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50.h, right: 50.w, left: 50.w),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Color(0xFF69ADFC),
          child: Container(
            alignment: Alignment.center,
            // width: 90,
            height: 80.h,
            child: Text(
              "add_worker".tr().toString(),
              style: TextStyle(
                  color: Colors.white, fontSize: Styles().fontSize_name),
            ),
          ),
          onPressed: () {
            Stream userStream = Stream.fromFuture(Store().getStore_Info());
            userStream.listen((event) {
              User user = event;
              if (user.operations_permissions[0].value) {
                New_workerAlert(context);
              } else {
                NO_Permissions(context);
              }
            });
          },
        ),
      ),
      body: StreamBuilder(
          stream: workers_provider.fetchWrokerAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              workers = snapshot.data.docs
                  .map((doc) => Worker.fromMap(doc.data(), doc.id))
                  .toList();
              if (workers.length > 0) {
                return ListView(
                  children: [
                    Container(
                      width: 750.w,
                      child: Worker_Chart(
                        workers: workers,
                      ),
                    ),
                    SizedBox(
                      height: 0.h,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: _padding,
                      height: 1330.h,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: workers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Worker_Row(worker: workers[index]);
                          }),
                    ),
                  ],
                );
              } else {
                return Center(
                    child: Text(
                  'nodata'.tr().toString(),
                  style: Styles().textStyle_nodata,
                ));
              }
            } else {
              return Center(
                  child: Text(
                'loading'.tr().toString(),
                style: Styles().textStyle_nodata,
              ));
            }
          }),
    );
  }
}
