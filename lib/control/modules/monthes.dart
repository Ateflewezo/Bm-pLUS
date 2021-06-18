import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class Month {
  String name;
  String value;
  Month({this.name, this.value});
}

getmonthes(BuildContext context) {
  return EasyLocalization.of(context).locale == Locale("ar", "SA")
      ? ar_monthes
      : en_monthes;
}

String getmonthe(
    //BuildContext context,
    int month) {
  return ar_monthes[month].name;
  // return EasyLocalization.of(context).locale == Locale("ar", "SA")
  //     ? ar_monthes[month].name
  //     : en_monthes[month].name;
}

List<Month> ar_monthes = [
  Month(name: "الأشهر", value: "00"),
  Month(name: "يناير", value: "1"),
  Month(name: "فبراير", value: "2"),
  Month(name: "مارس", value: "3"),
  Month(name: "أبريل", value: "4"),
  Month(name: "مايو", value: "5"),
  Month(name: "يونيو", value: "6"),
  Month(name: "يوليو", value: "7"),
  Month(name: "أغسطس", value: "8"),
  Month(name: "سبتمبر", value: "9"),
  Month(name: "اكتوبر", value: "10"),
  Month(name: "نوفمبر", value: "11"),
  Month(name: "ديسمبر", value: "12"),
];

List<Month> en_monthes = [
  Month(name: "Mounthes", value: "00"),
  Month(name: "January", value: "1"),
  Month(name: "February", value: "2"),
  Month(name: "March", value: "3"),
  Month(name: "April", value: "4"),
  Month(name: "May", value: "5"),
  Month(name: "June", value: "6"),
  Month(name: "July", value: "7"),
  Month(name: "August", value: "8"),
  Month(name: "September", value: "9"),
  Month(name: "October", value: "10"),
  Month(name: "November", value: "11"),
  Month(name: "December", value: "12"),
];
