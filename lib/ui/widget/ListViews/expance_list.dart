import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/expancess.dart';
import 'package:service_app/control/services/expancess.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Adapters/expanses_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget List_Expanses(String filterby, String date) {
  Expancess_provider expancess_provider = Expancess_provider();
  List<Expancess> expancess;
  return StreamBuilder(
      stream: expancess_provider.getstatistic(filterby, date),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          expancess = snapshot.data.docs
              .map((doc) => Expancess.fromMap(doc.data(), doc.id))
              .toList();
          print("expancess ${expancess.toString()}");
          if (expancess.length > 0) {
            return ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                // itemExtent: 400.w,
                itemCount: expancess.length,
                itemBuilder: (BuildContext context, int index) {
                  // return Product_Row();
                  return Expanses_Row(context, expancess[index]);
                });
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
      });
}
