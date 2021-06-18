import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:service_app/control/modules/offer.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../widget/currency_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Popups/Offers/share_offer.dart';

class Offers_Row extends StatelessWidget {
  Offer offer;
  Offers_Row({@required this.offer});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10.h),
                margin: EdgeInsets.only(
                    top: 10.h, right: 10.w, left: 10.w, bottom: 8.h),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 200.h, //MediaQuery.of(context).size.height + 10,
                      child: Card(
                        margin: EdgeInsets.only(top: 5.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 10.w),
                              width: 170.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.blue[100],
                                    Colors.blue[200],
                                    Colors.blue[300],
                                    Colors.blue[500]
                                  ],
                                  // transform: GradientRotation(4),
                                ),
                              ),
                            ),
                            Text(
                              offer.name,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: Styles().fontSize_name,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            adapter_currency(
                              context,
                              offer.price,
                              Colors.black,
                              Styles().fontSize_price_ad,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: CachedNetworkImage(
                        width: 140.w,
                        height: 160.h,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        imageUrl: offer.imageURL,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // // padding: EdgeInsets.all(5),
                width: 60.w,
                height: 60.w,
                // alignment:
                //     EasyLocalization.of(context).locale == Locale("en", "US")
                //         ? Alignment.center
                //         : Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.white, blurRadius: 8, spreadRadius: 3)
                  ],
                  color: Colors.blue,
                ),
                child: Container(
                  width: 60.w,
                  height: 60.w,
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                    onPressed: () {
                      showAlertDialog_share_offer(context, offer);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          width: 60.w,
          height: 60.w,
          alignment: EasyLocalization.of(context).locale == Locale("en", "US")
              ? Alignment.center
              : Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(60.w)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.white, blurRadius: 8, spreadRadius: 3)
            ],
            color: Colors.red,
          ),
          child: Text(
            "${offer.persent}%",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
        ),
      ],
    );
  }
}
