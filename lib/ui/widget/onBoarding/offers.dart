import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/offer.dart';
import 'package:service_app/control/services/offers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../tooles/constants/colors_app.dart' as Constants;

final _currentPageNotifier = ValueNotifier<int>(0);

Future<bool> setFinishedOnBoarding() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool(Constants.FINISHED_ON_BOARDING, true);
}

BuildContext _context;

class OffersScreen extends StatelessWidget {
  final List<Widget> _pages = [];

  pages() {
    Offers_provider offers_provider = Offers_provider();
    List<Offer> offers;
    return StreamBuilder(
        stream: offers_provider.fetchOffersAsStream(''),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            offers = snapshot.data.docs
                .map((doc) => Offer.fromMap(doc.data(), doc.id))
                .toList();
            return new Scaffold(
                body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: PageView(
                    controller: controller,
                    children: populatePages(
                        context, offers), //populatePages(context),
                    onPageChanged: (int index) {
                      _currentPageNotifier.value = index;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildSmothIndicator(offers.length),
                  ),
                )
              ],
            ));
          } else {
            return Center(
                child: Text(
              'loading'.tr().toString(),
              style: TextStyle(fontSize: 18.sp),
            ));
          }
        });
  }

  List<Widget> populatePages(BuildContext context, List<Offer> offers) {
    _pages.clear();
    offers.asMap().forEach((index, value) => _pages.add(getPage(
          value,
        )));

    return _pages;
  }

  final controller = PageController(viewportFraction: 0.8);
  Widget _buildSmothIndicator(int lenght) {
    if (lenght > 0) {
      return SmoothPageIndicator(
        controller: controller,
        count: lenght,
        axisDirection: Axis.horizontal,
        effect: ExpandingDotsEffect(
            spacing: 8.0,
            radius: 15.0,
            dotWidth: 8.0,
            dotHeight: 5.0,
            dotColor: Colors.grey,
            activeDotColor: Colors.indigo),
      );
    } else {
      return Center(
        child: Text(
          'nooffers'.tr().toString(),
          style: TextStyle(fontSize: 18.sp),
        ),
      );
    }
  }

  Widget getPage(Offer offer) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(15.h))),
      // color: Color(Constants.COLOR_PRIMARY),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CachedNetworkImage(
              width: 200.w,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
              // placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl: offer.imageURL,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    offer.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.sp,
                    ),
                  ),
                  Text(
                    "${offer.persent}%",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return pages();
  }
}
