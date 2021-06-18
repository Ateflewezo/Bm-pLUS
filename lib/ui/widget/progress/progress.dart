import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Progress {
  Timer _timer;
  cancelTimer() {
    // _timer.cancel();
    // EasyLoading.dismiss();
    // notifyListeners();
  }

  OnProgress(BuildContext context, bool show) {
    if (show) {
      EasyLoading.show(status: 'uploading'.tr().toString());
    }
  }
}
