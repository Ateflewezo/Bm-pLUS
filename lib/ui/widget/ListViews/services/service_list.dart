import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Adapters/services/service_row.dart';
import 'package:service_app/ui/widget/Popups/Offers/add_new.dart';
import '../../../../control/modules/service.dart';
import '../../../../control/services/services.dart';
import 'package:service_app/ui/widget/Popups/Servieces/add_new.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class List_Services extends StatefulWidget {
  bool isoffer;
  List_Services({@required this.isoffer});
  @override
  _List_ServicesState createState() => _List_ServicesState();
}

class _List_ServicesState extends State<List_Services> {
  @override
  Widget build(BuildContext context) {
    List<Service> Services;
    Services_provider services_provider = Services_provider();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, right: 32.0, left: 32.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Color(0xFF69ADFC),
          child: Container(
            alignment: Alignment.center,
            // width: 90,
            height: 80.w,
            child: Text(
              "add_service_to_oper".tr().toString(),
              style: TextStyle(color: Colors.white, fontSize: 28.sp),
            ),
          ),
          onPressed: () {
            Stream userStream = Stream.fromFuture(Store().getStore_Info());
            userStream.listen((event) {
              User user = event;
              print(
                  'services_permissions ${event.services_permissions[0].value}');
              if (user.services_permissions[0].value) {
                Service_addnew(context);
              } else {
                NO_Permissions(context);
              }
            });
          },
        ),
      ),
      body: StreamBuilder(
          stream: services_provider.fetchServicesAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              Services = snapshot.data.docs
                  .map((doc) => Service.fromMap(doc.data(), doc.id))
                  .toList();
              if (Services.isEmpty) {
                return Center(
                    child: Text(
                  'nodata'.tr().toString(),
                  style: Styles().textStyle_nodata,
                ));
              }
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: Services.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkResponse(
                      child: Service_Row(context, Services[index]),
                      onTap: () {
                        widget.isoffer
                            ? showAlertDialog_new_offer(
                                context, null, Services[index], false)
                            : null;
                      },
                    );
                  });
            } else {
              return Center(
                  child: Text(
                'Loading',
                style: TextStyle(fontSize: 18.sp),
              ));
            }
          }),
    );
  }
}
