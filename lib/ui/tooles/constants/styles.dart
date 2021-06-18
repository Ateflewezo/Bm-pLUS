import 'package:flutter/material.dart';
import '../constants/colors_app.dart' as constance;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  final double fontSize_seeall = 20.sp;
  final double fontSize_name = 26.sp;
  final double fontSize_subname = 24.sp;
  final double fontSize_price_ad = 28.sp;
  final double fontSize_price = 28.sp;
  final double fontSize_statistic_tit1 = 20.sp;
  final TextStyle textStyle_nodata = TextStyle(fontSize: 20.sp);
  final TextStyle textStyle_labelstyle = TextStyle(fontSize: 20.sp);
  final int imageQuality = 1;
}

get title_style {
  return new TextStyle(color: Colors.black, fontSize: 28.sp);
}

get suptitle_style {
  return new TextStyle(color: Colors.black, fontSize: 28.sp);
}

get title_product_details_style {
  return new TextStyle(color: constance.product_details1, fontSize: 22.sp);
}

get drawer_items_style {
  return new TextStyle(color: Colors.grey, fontSize: 22.sp);
}
