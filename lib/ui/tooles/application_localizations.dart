
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;
  Map<String, String> _localizedStrings;

 Future<bool> load() async {
   // Load JSON file from the "language" folder
   String jsonString =
   await rootBundle.loadString('assets/language/${locale.languageCode}.json');
   Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);
   _localizedStrings = jsonLanguageMap.map((key, value) {
     return MapEntry(key, value.toString());
   });
   return true;
 }
 
  static Map<String, Map<String, String>> _localizedValues = {
    'en':
   {
      'foo': 'Foo',
      'bar': 'Bar'
    },
    'ar': {
      'products': 'المنتجات',
      'offers': 'العروض',
      'reservations': 'الحجوزات',
      'cars': 'السيارات',
      'clients': 'الزبائن',
      'omlier': 'العمال',
      'users': 'المستخدمين',
      'satistique': 'الإحصائيات',
      'logout': 'تسجيل الخروج',
     

    }
  };

  String translate(key) {
    return _localizedValues[locale.languageCode][key];
  }

  static String of(BuildContext context, String key) {
    return Localizations.of<MyLocalizations>(context, 
      MyLocalizations).translate(key);
  }
}

class MyLocalizationsDelegate extends 
  LocalizationsDelegate<MyLocalizations> {
  
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => 
    ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>
      (MyLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class ApplicationLocalizations {
//  final Locale appLocale;

//  ApplicationLocalizations(this.appLocale);

//  static ApplicationLocalizations of(BuildContext context) {
//    return Localizations.of<ApplicationLocalizations>(context, ApplicationLocalizations);
//  }

//  Map<String, String> _localizedStrings;

//  Future<bool> load() async {
//    // Load JSON file from the "language" folder
//    String jsonString =
//    await rootBundle.loadString('assets/language/${appLocale.languageCode}.json');
//    Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);
//    _localizedStrings = jsonLanguageMap.map((key, value) {
//      return MapEntry(key, value.toString());
//    });
//    return true;
//  }

//  // called from every widget which needs a localized text
//  String translate(String jsonkey) {
//    return _localizedStrings[jsonkey];
//  }
// }