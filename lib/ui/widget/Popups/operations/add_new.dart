import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/modules/customer.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/customers.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

Start_operation(BuildContext context) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = _newcustomer(context);

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String name, phone, piace_nb;
Widget _newcustomer(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  return AlertDialog(
    content: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          width: 700.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('add_user_info'.tr().toString()),
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
              SizedBox(height: 20.h),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "phone_number".tr().toString();
                  } else {
                    phone = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Image(
                    image: AssetImage("res/images/phone.png"),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: "phone_number".tr().toString(),
                  labelStyle: Styles().textStyle_labelstyle,
                ),
                onChanged: (value) {},
              ),
              SizedBox(height: 20.h),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    // return "fullname".tr().toString();
                  } else {
                    name = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Image(
                    image: AssetImage("res/images/person.png"),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: "fullname".tr().toString(),
                  labelStyle: Styles().textStyle_labelstyle,
                ),
                onChanged: (value) {},
              ),
              SizedBox(height: 20.h),
              Container(
                alignment: Alignment.center,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      // return "piace_nb".tr().toString();
                    } else {
                      piace_nb = value;
                    }
                    return null;
                  },
                  textAlign: TextAlign.start,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                    prefixIcon: Image(
                      image: AssetImage("res/images/car.png"),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: "details".tr().toString(),
                    labelStyle: Styles().textStyle_labelstyle,
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF13AC97),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200.w,
                    height: 80.h,
                    child: Text(
                      "start_operation".tr().toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Styles().fontSize_name),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _add_customer(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> _add_customer(BuildContext context) async {
  // var bloc = Provider.of<Operation_provider>(context, listen: true);
  // bloc.liber();

  Customer customer = Customer(name: name, phone_number: phone);
  Customers_provider customers_provider = Customers_provider();
  Progress progress = Progress();

  progress.OnProgress(context, false);
  // var bloc = Provider.of<Operation_provider>(context, listen: true);
  // bloc.liber();
  await customers_provider.addcustomerandgetID(customer).then((value) {
    if (value) {
      progress.cancelTimer();
      Navigator.popAndPushNamed(
          context, '/add_operation/${customer.phone_number}');
    }
  });
}
