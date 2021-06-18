import 'package:flutter/material.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/control/services/locator.dart';
import 'package:service_app/ui/widget/ListViews/products/product_list_addtooferr.dart';
import 'package:service_app/ui/widget/ListViews/offers_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/ui/widget/ListViews/services/service_list_addtooffer.dart';

class TabView_Offers extends StatefulWidget {
  String search_by;
  TabView_Offers({this.search_by});
  @override
  _TabView_OffersState createState() => _TabView_OffersState();
}

class _TabView_OffersState extends State<TabView_Offers> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: myTabs,
              onTap: (int i) {
                Stream<User> user = Stream.fromFuture(Store().getStore_Info());
                user.listen((event) {
                  setState(() {
                    i == 0
                        ? setuplocator_offer(
                            "${event.store_id}/productsINoffers")
                        : setuplocator_offer(
                            "${event.store_id}/servicesINoffers");
                    _tab_nb = i;
                    print(i);
                  });
                });
              },
            ),
          ),
          Expanded(
              child:
                  //  _tab_nb == 0
                  // ?
                  Container(
                      padding: EdgeInsets.only(top: 30.h),
                      child: List_offers(widget.search_by))
              // : Center()
              ),
        ],
      ),
    );
  }
}

final List<Tab> myTabs = <Tab>[
  Tab(
    child: Text('products'.tr().toString(), style: TextStyle(fontSize: 22.sp)),
  ),
  Tab(
    child: Text('services'.tr().toString(), style: TextStyle(fontSize: 22.sp)),
  ),
];
int _tab_nb = 0;

class TabView_ADDOffers extends StatefulWidget {
  @override
  _TabView_ADDOffersState createState() => _TabView_ADDOffersState();
}

class _TabView_ADDOffersState extends State<TabView_ADDOffers> {
  @override
  void initState() {
    // TODO: implement initState
    // setuplocator_offer("/products");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: myTabs,
              onTap: (int i) {
                setState(() {
                  _tab_nb = i;
                  print(i);
                });
              },
            ),
          ),
          Expanded(
            child: _tab_nb == 0
                ? Container(
                    padding: EdgeInsets.only(top: 30.h),
                    child: List_products(context, true))
                : Container(
                    padding: EdgeInsets.only(top: 30.h),
                    child: List_Services(
                      isoffer: true,
                    )),
          )
        ],
      ),
    );
  }
}
