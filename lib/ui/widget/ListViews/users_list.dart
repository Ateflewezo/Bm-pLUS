import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/control/services/users.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Adapters/user_row.dart';
import 'package:easy_localization/easy_localization.dart';

Widget List_users(String type) {
  Users_provider users_provider = Users_provider();
  List<User> users;

  return FutureBuilder(
    future: Store().getStore_Info(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return StreamBuilder(
            stream: users_provider.fetchUser_bytype_AsStream(
                type, snapshot.data.store_id),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                users = snapshot.data.docs
                    .map((doc) => User.fromsnapshot(doc, doc.id))
                    .toList();
                print("users ${users.toString()}");
                if (users.length > 0) {
                  return GridView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 1,
                              childAspectRatio: 0.7),
                      itemBuilder: (BuildContext context, int index) {
                        return Users_Row(user: users[index]);
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
      } else {
        return Center(
            child: Text(
          'loading'.tr().toString(),
          style: Styles().textStyle_nodata,
        ));
      }
    },
  );
}
