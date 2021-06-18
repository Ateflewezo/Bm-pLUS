import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/widget/ListViews/operation/operation_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../tooles/constants/styles.dart';

class TabView_Operations extends StatefulWidget {
  String search_by = '';
  String customer_id = '';
  TabView_Operations({this.search_by, this.customer_id});
  @override
  _TabView_OperationsState createState() => _TabView_OperationsState();
}

class _TabView_OperationsState extends State<TabView_Operations> {
  int _tab_nb = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: getTabs().length,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: getTabs(),
              onTap: (int i) {
                setState(() {
                  _tab_nb = i;
                  print(i);
                });
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Container(
                  height: 950.h,
                  padding: EdgeInsets.only(top: 5.h),
                  child: List_operations(_tab_nb + 1, widget.search_by,
                      widget.customer_id, "/operations/")),
            ),
          ),
        ],
      ),
    );
  }
}

List<Tab> getTabs() {
  return <Tab>[
    Tab(
      child: Text(
        'wating'.tr().toString(),
        style: TextStyle(fontSize: Styles().fontSize_seeall),
      ),
    ),
    Tab(
      child: Text(
        'current'.tr().toString(),
        style: TextStyle(fontSize: Styles().fontSize_seeall),
      ),
    ),
    Tab(
      child: Text(
        'complete'.tr().toString(),
        style: TextStyle(fontSize: Styles().fontSize_seeall),
      ),
    ),
    Tab(
      child: Text(
        'given'.tr().toString(),
        style: TextStyle(fontSize: Styles().fontSize_seeall),
      ),
    ),
  ];
}
