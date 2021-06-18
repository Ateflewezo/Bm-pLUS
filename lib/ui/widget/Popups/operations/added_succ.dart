import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class added_operation_succ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      width: 700.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text('add_user_info'.tr().toString()),
              Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.grey[200]),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 18.sp,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 300.w,
                  height: 300.w,
                  child: FutureBuilder(
                    future: Store().getStore_data(),
                    builder: (context, snapshot_store) {
                      if (snapshot_store.hasData) {
                        return snapshot_store.data.image != null
                            ? Container(
                                width: 150.w,
                                height: 150.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10000.0),
                                  child: CachedNetworkImage(
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        new Container(
                                            decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "res/images/logo.png",
                                          ), // picked file
                                          fit: BoxFit.fill),
                                    )),
                                    imageUrl: snapshot_store.data.image,
                                  ),
                                ),
                              )
                            : Container(
                                width: 150.w,
                                height: 150.w,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "res/images/logo.png",
                                      ), // picked file
                                      fit: BoxFit.fill),
                                ));
                      } else {
                        return Center(
                          child: Text(
                            'loading'.tr().toString(),
                            style: Styles().textStyle_nodata,
                          ),
                        );
                      }
                    },
                  )

                  //  Image(
                  //   image: AssetImage(
                  //     "res/images/compelet.png",
                  //   ),
                  // )
                  ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 80.h,
                // alignment: Alignment.center,
                child: Row(
                  children: [
                    Text(
                      'operation_added'.tr().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Styles().fontSize_name,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Image(
                      image: AssetImage(
                        "res/images/good.png",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.blue,
                child: Container(
                  alignment: Alignment.center,
                  width: 400.w,
                  height: 80.h,
                  child: Text(
                    "go_operation".tr().toString(),
                    style: TextStyle(
                        color: Colors.white, fontSize: Styles().fontSize_name),
                  ),
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/operations/');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

operation_added_succ(BuildContext context, Progress progress) {
  progress.cancelTimer();
  // set up the button
  final _formKey = GlobalKey<FormState>();
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(content: added_operation_succ());

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
