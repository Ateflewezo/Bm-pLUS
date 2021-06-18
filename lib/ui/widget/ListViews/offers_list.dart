import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/offer.dart';
import 'package:service_app/control/services/offers.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Adapters/offer_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget List_offers(String search_by) {
  Offers_provider offers_provider = Offers_provider();
  List<Offer> offers;
  return StreamBuilder(
      stream: offers_provider.fetchOffersAsStream(search_by),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          offers = snapshot.data.docs
              .map((doc) => Offer.fromMap(doc.data(), doc.id))
              .toList();
          if (offers.isEmpty) {
            return Center(
                child: Text(
              'nodata'.tr().toString(),
              style: Styles().textStyle_nodata,
            ));
          }
          return GridView.builder(
              shrinkWrap: true,
              itemCount: offers.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 1.w,
                  childAspectRatio: 1.1.w),
              itemBuilder: (BuildContext context, int index) {
                return InkResponse(
                  child: Offers_Row(
                    offer: offers[index],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/details/:id1235');
                  },
                );
              });
        } else {
          return Text('loading'.tr().toString());
        }
      });
}
