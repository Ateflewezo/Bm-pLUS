import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/widget/ListViews/customers/customer_list.dart';
import 'package:service_app/ui/widget/ListViews/worker/complete_operations.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as styles;

class Worker_operation extends StatefulWidget {
  @override
  _Worker_operationState createState() => _Worker_operationState();
}

class _Worker_operationState extends State<Worker_operation> {
  var _padding = const EdgeInsets.symmetric(horizontal: 25);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.grey[50],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Constance.icon_color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: _padding,
            child: RotatedBox(
              quarterTurns:
                  EasyLocalization.of(context).locale == Locale("en", "US")
                      ? 4
                      : 1,
              child: IconButton(
                icon: Icon(Icons.search, color:  Colors.transparent),
                onPressed: () {
                  // Navigator.pushNamed(context, "/search");
                },
              ),
            ),
          )
        ],
        title: Center(
          child: Text(
            'complete_operaction'.tr().toString(),
            style: TextStyle(
                color: Constance.icon_color,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: _padding,
        child: Scaffold(
          body: Column(
            children: [
              //
              Expanded(child: List_Complete_operations()),
            ],
          ),
        ),
      ),
    );
  }
}
