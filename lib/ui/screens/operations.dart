import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/ui/widget/Tabs/tabview_operations.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as styles;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Operations extends StatefulWidget {
  String customer_id;
  Operations({this.customer_id});
  @override
  _OperationsState createState() => _OperationsState();
}

String _search_by = '';

class _OperationsState extends State<Operations> {
  var _padding = EdgeInsets.symmetric(horizontal: 50.w);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150.w,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
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
                icon: Icon(Icons.search, color: Colors.transparent),
                onPressed: () {
                  Navigator.pushNamed(context, "/search");
                },
              ),
            ),
          )
        ],
        title: Center(
          child: Text(
            'operations'.tr().toString(),
            style: styles.title_style,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: _padding,
            width: 750.w,
            height: 350.h,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                FutureBuilder(
                    future: Store().getStore_Info(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("wllecom".tr().toString(),
                                style: TextStyle(
                                    fontSize: styles.Styles().fontSize_name)),
                            Text(
                              " ${snapshot.data.name} .!",
                              style: TextStyle(
                                  fontSize: styles.Styles().fontSize_name,
                                  color: Colors.blue),
                            ),
                            Image(
                              image: AssetImage("res/images/good.png"),
                            )
                          ],
                        );
                      } else {
                        return Container(width: 0.0, height: 0.0);
                      }
                    }),
                SizedBox(
                  height: 40.h,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _search_by = value;
                    });
                  },
                  decoration: new InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    fillColor: Color(0XFFFBFBFB),
                    hintStyle: TextStyle(
                        color: Color(0XFF808080),
                        fontSize: styles.Styles().fontSize_name),
                    hintText: "shearch_txt".tr().toString(),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.h)),
                            color: Color(0XFFEBF4FF)),
                        child: new Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.h)),
                      borderSide: const BorderSide(
                        color: Color(0XFFF2F2F2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.h)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          Container(
              height: 980.h,
              child: TabView_Operations(
                search_by: _search_by,
                customer_id: widget.customer_id,
              )),
        ],
      ),
    );
  }
}
