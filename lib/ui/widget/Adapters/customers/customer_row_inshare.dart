import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../../widget/currency_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/customer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class Customer_shareOffer extends StatefulWidget {
  Customer customer;
  Customer_shareOffer({this.customer});
  @override
  _Customer_shareOfferState createState() => _Customer_shareOfferState();
}

class _Customer_shareOfferState extends State<Customer_shareOffer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkResponse(
        onTap: () {
          setState(() {
            widget.customer.selected = !widget.customer.selected;
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      border: Border.all(
                        color: widget.customer.selected
                            ? Color(0xFF1A7404)
                            : Colors.green[100],
                        width: 4.w,
                      ),
                    ),
                    width: 90.w,
                    height: 90.w,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("res/images/custom.png"),
                    ),
                  ),
                  Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.w))),
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          size: 40.sp,
                          color: widget.customer.selected
                              ? Color(0xFF1A7404)
                              : Colors.green[100],
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                widget.customer.name,
                style: TextStyle(
                  fontSize: Styles().fontSize_name,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
