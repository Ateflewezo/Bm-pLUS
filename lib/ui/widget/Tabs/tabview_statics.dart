import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TabView_Statics extends StatefulWidget {
  @override
  _TabView_StaticsState createState() => _TabView_StaticsState();
}

class _TabView_StaticsState extends State<TabView_Statics> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: getTabs().length,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: TabBar(
              unselectedLabelColor: Colors.white30,
              labelColor: Colors.white,
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
        ],
      ),
    );
  }
}

List<Tab> getTabs() {
  return <Tab>[
    Tab(
      child: Text(
        'thisDay'.tr().toString(),
        style: TextStyle(fontSize: 12),
      ),
    ),
    Tab(
      child: Text(
        'thisweak'.tr().toString(),
        style: TextStyle(fontSize: 12),
      ),
    ),
    Tab(
      child: Text(
        'thismonthe'.tr().toString(),
        style: TextStyle(fontSize: 12),
      ),
    ),
    Tab(
      child: Text(
        'thisyear'.tr().toString(),
        style: TextStyle(fontSize: 12),
      ),
    ),
  ];
}

int _tab_nb = 0;
