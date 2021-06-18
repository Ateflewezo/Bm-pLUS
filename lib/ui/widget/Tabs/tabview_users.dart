import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/widget/ListViews/users_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../tooles/constants/styles.dart';

class TabView_Users extends StatefulWidget {
  @override
  _TabView_UsersState createState() => _TabView_UsersState();
}

class _TabView_UsersState extends State<TabView_Users> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: getTabs().length,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(top: 40.w),
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
          ),
          Expanded(
            child: _page(_tab_nb),
          ),
        ],
      ),
    );
  }
}

Widget _page(int tab_nb) {
  EdgeInsets padding = EdgeInsets.only(top: 30.h, right: 50.w, left: 50.w);
  switch (_tab_nb) {
    case 0:
      return Container(padding: padding, child: List_users('boss'));
      break;
    case 1:
      return Container(padding: padding, child: List_users('acounter'));
      break;
    case 2:
      return Container(padding: padding, child: List_users('admin'));
      break;
    default:
  }
}

List<Tab> getTabs() {
  return <Tab>[
    Tab(
      child: Text(
        'boss'.tr().toString(),
        style: TextStyle(fontSize: Styles().fontSize_seeall),
      ),
    ),
    Tab(
      child: Text(
        'acounter'.tr().toString(),
        style: TextStyle(fontSize: Styles().fontSize_seeall),
      ),
    ),
    Tab(
      child: Text(
        'admin'.tr().toString(),
        style: TextStyle(fontSize: Styles().fontSize_seeall),
      ),
    ),
  ];
}

int _tab_nb = 0;
