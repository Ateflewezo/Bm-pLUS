import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/messages.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class Add_Payment extends StatefulWidget {
  Store_classe store_classe;
  String path;
  Operation_provider operation;
  Add_Payment({@required this.operation, this.path, this.store_classe});
  @override
  _Add_PaymentState createState() => _Add_PaymentState();
}

double _moment = 0.0;

class _Add_PaymentState extends State<Add_Payment> {
  @override
  Widget build(BuildContext context) {
    _moment =
        (widget.operation.product_total + widget.operation.service_total) -
            widget.operation.paid;
    final _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
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
                      onPressed: () async {
                        await EasyLoading.dismiss();
                        Navigator.of(context).pop();
                      },
                    ))
              ],
            ),
            _info2(),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Checkbox(
                      value: true,
                      activeColor: Colors.white,
                      // focusColor: Colors.grey,

                      checkColor: Colors.blue,
                      onChanged: (value) {}),
                ),
                Text(
                  "pai_all_mont".tr().toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Styles().fontSize_name,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: _moment.toString(),
                  validator: (value) {
                    if (value.isEmpty || double.parse(value) == 0.0) {
                      return "paidup".tr().toString();
                    } else {
                      _moment = double.parse(value);
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: "paidup".tr().toString(),
                    labelStyle: Styles().textStyle_labelstyle,
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF69ADFC),
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.w,
                    height: 80.h,
                    child: Text(
                      "verf".tr().toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Styles().fontSize_name),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Stream.fromFuture(Operation_provider()
                              .getmoney(_moment, 'CCC 00.00'))
                          .listen((amount) {
                        if (widget.operation.state != 0) {
                          Message_provider().Send_Message_(
                              "operation_paid_sms".tr(namedArgs: {
                                'state0': amount.toString(),
                                'state1': widget.operation.id,
                              }, args: [
                                ''
                              ])
                              // +
                              // "\n" +
                              // widget.store_classe.name
                              ,
                              [widget.operation.customer.phone_number]);
                        }

                        _add_paiment(context, widget.operation, widget.path);
                      });
                    }
                  },
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF808080),
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.w,
                    height: 80.h,
                    child: Text(
                      "cancel".tr().toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Styles().fontSize_name),
                    ),
                  ),
                  onPressed: () async {
                    await EasyLoading.dismiss();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _info2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 150.w,
          height: 150.w,
          child: CircleAvatar(
            //  fit: BoxFit.cover,
            backgroundImage: AssetImage(
              "res/images/custom.png",
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'paid_oper_txt'.tr().toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Styles().fontSize_name,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }

  void _add_paiment(
      BuildContext context, Operation_provider operation, String path) {
    double total = operation.product_total + operation.service_total;
    if (_moment > (total - operation.paid)) {
      EasyLoading.showError("${_moment} > ${(total + operation.paid)}");
      return;
    }
    Progress progress = Progress();
    progress.OnProgress(context, false);

    Operations_provider operations_provider = Operations_provider();
// if(operation.state>1){

// }
    var bloc = Provider.of<Operation_provider>(context, listen: false);

    operation.state > 0
        ? operations_provider.updateOperation_Paid(
            operation.Add_Payment(operation.paid + _moment), operation.uid) //;
        : bloc.Paid(_moment);
    progress.cancelTimer();
    Navigator.of(context).pop();
    path != null ? Navigator.popAndPushNamed(context, path) : null;
  }
}

Paid_operation(BuildContext context, Operation_provider operation, String s,
    Store_classe store_classe) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      content: Add_Payment(
    operation: operation,
    path: s,
    store_classe: store_classe,
  ));
  ;

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
