import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/offer.dart';
import 'package:service_app/control/modules/product.dart';
import 'package:service_app/control/modules/service.dart';
import 'package:service_app/control/services/offers.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';
import '../../currency_text.dart';

/////add new
int _persant = 00;
showAlertDialog_new_offer(
    BuildContext context, Product product, Service service, bool isproduct) {
  // set up the button
  final _formKey = GlobalKey<FormState>();
  ;
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: SingleChildScrollView(
      child: Container(
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
                // Text('share_offer'.tr().toString()),
                InkResponse(
                  onTap: () async {
                    await EasyLoading.dismiss();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.grey[200]),
                      child: Icon(
                        Icons.close,
                        size: 18.sp,
                      )),
                )
              ],
            ),
            isproduct
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10000.0),
                    child: CachedNetworkImage(
                      height: 150.w,
                      width: 150.w,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      imageUrl: product.imageURL,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10000.0),
                    child: CachedNetworkImage(
                      height: 150.w,
                      width: 150.w,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      imageUrl: service.imageURL,
                    ),
                  ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              isproduct ? product.name : service.name,
              style: TextStyle(
                fontSize: Styles().fontSize_name,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Satictic_currency(
                context,
                isproduct ? product.price : service.price,
                Colors.red,
                Styles().fontSize_price),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Container(
                height: 90.h,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "persent_offer".tr().toString();
                      } else {
                        _persant = int.parse(value);
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      labelText: "persent_offer".tr().toString(),
                      labelStyle: Styles().textStyle_labelstyle,
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Color(0xFF539EFF),
                    child: Container(
                      alignment: Alignment.center,
                      width: 150.w,
                      height: 50.h,
                      child: Text(
                        "verf".tr().toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _add_newOffer(context, isproduct, product, service);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<void> _add_newOffer(BuildContext context, bool isproduct,
    Product product, Service service) async {
  Progress progress = Progress();

  progress.OnProgress(context, false);

  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy/MM/dd');
  String date = formatter.format(now);
  Offer offer = Offer(
      name: isproduct ? product.name : service.name,
      price: isproduct ? product.price : service.price,
      persent: _persant,
      imageURL: isproduct ? product.imageURL : service.imageURL,
      date: date);
  Offers_provider offers_provider = Offers_provider();
  await offers_provider.addOffer(offer);
  progress.cancelTimer();

  Navigator.popAndPushNamed(context, "/offers");
}
