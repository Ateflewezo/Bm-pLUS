import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/widget/Tabs/tabview_offers.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as styles;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class New_Offers extends StatefulWidget {
  @override
  _New_OffersState createState() => _New_OffersState();
}

var _padding = EdgeInsets.symmetric(horizontal: 50.w);

class _New_OffersState extends State<New_Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 180.w,
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
            'add_offer'.tr().toString(),
            style: styles.title_style,
          ),
        ),
      ),
      body: Padding(
        padding: _padding,
        child: ListView(
          children: [
            SizedBox(
              height: 20.h,
            ),
            TextField(
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
                        borderRadius: BorderRadius.all(Radius.circular(15)),
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
            Container(
              height: 1000.h,
              child: TabView_ADDOffers(),
            )
          ],
        ),
      ),
    );
  }
}
