import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/date.dart';
import 'package:service_app/control/modules/expancess.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:service_app/control/modules/worker_payments.dart';
import 'package:service_app/control/services/expancess.dart';
import 'package:service_app/control/services/locator.dart';
import 'package:service_app/control/services/worker_payment.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import 'package:service_app/ui/screens/worker_details.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class Paid extends StatefulWidget {
  Worker worker;
  bool comission;
  Paid({@required this.worker, this.comission});
  @override
  _PaidState createState() => _PaidState();
}

double _tot_paid = 0.0;

class _PaidState extends State<Paid> {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _current_select;
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(new DropdownMenuItem(
      value: "salaire",
      child: new Text("salaire".tr().toString()),
      onTap: () {},
    ));
    items.add(new DropdownMenuItem(
      value: "comission",
      child: new Text("comission".tr().toString()),
      onTap: () {},
    ));
    return items;
  }

  void changedDropDownItem(String value, Worker worker, bool comission) {
    switch (value) {
      case "salaire":
        if (paid(worker)) {
          EasyLoading.showInfo(
            "salairy_paided".tr(namedArgs: {
              'date': " ${worker.salaire_date} ",
            }, args: [
              ''
            ]),
          );
        } else {
          _current_select = value;
        }
        break;
      case "comission":
        if (!comission) {
          EasyLoading.showInfo(
            "comisson_paided".tr().toString(),
          );
        } else {
          _current_select = value;
        }
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    if ((widget.worker.comission - widget.worker.comission_paid) > 0) {
      widget.comission = true;
    } else {
      widget.comission = false;
    }
    _current_select = "comission";
    _dropDownMenuItems = getDropDownMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    bool all_amount = true;
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      width: 700.w,
      // height: 440,
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
          _info(widget.worker),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 750.w,
            height: 90.h,
            margin: EdgeInsets.only(top: 20.h),
            child: Container(
              width: 150.w,
              child: DropdownButton(
                focusColor: Colors.transparent,
                value: _current_select,
                items: _dropDownMenuItems,
                onChanged: (value) {
                  setState(() {
                    changedDropDownItem(value, widget.worker, widget.comission);
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Checkbox(
                    value: all_amount,
                    activeColor: Colors.white,

                    // focusColor: Colors.grey,

                    checkColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        all_amount = value;
                      });
                    }),
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
                initialValue: _current_select == "salaire"
                    ? widget.worker.salery.toString()
                    : "",
                keyboardType: TextInputType.number,
                enabled: _current_select == "salaire" ? false : true,
                validator: (value) {
                  if (value.isEmpty) {
                    return "paidup".tr().toString();
                  } else {
                    _tot_paid = double.parse(value);
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
                      fontSize: Styles().fontSize_name,
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Stream<User> user =
                        Stream.fromFuture(Store().getStore_Info());
                    user.listen((event) {
                      _Paid_now(widget.worker, context, event.store_id,
                          _current_select);
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
                      fontSize: Styles().fontSize_name,
                    ),
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
    );
  }
}

Future<void> _Paid_now(Worker worker, BuildContext context, String store_id,
    String _current_select) async {
  Progress progress = Progress();
  setuplocator_workerPayment(worker.id, store_id);
  progress.OnProgress(context, false);
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy/MM/dd');
  String date = formatter.format(now);

  // DateFormat formatter_month = DateFormat('MM');
  // String date = formatter.format(now);
  // String month = formatter.format(now).toString();
  WorkersPayment_provider workersPayment_provider = WorkersPayment_provider();
  Payment payment = Payment(
      salery_rn: worker.salery,
      comission_rn: worker.comission,
      paided: _tot_paid,
      date: date,
      month: now.month.toString(),
      type: _current_select);

  workersPayment_provider.addpayment(payment, worker);
  addExpancev(context, worker, payment);
}

Future addExpancev(BuildContext context, Worker worker, Payment payment) async {
  Expancess_provider expancess_provider = Expancess_provider();
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy/MM/dd');
  String date = formatter.format(now);

  Expancess expancess = Expancess(
      type: payment.type,
      name: worker.name, //+ " (${payment.type.tr().toString()}) "
      price: payment.paided,
      date_all: date,
      date: Date(
          day: now.day.toString(),
          month: now.month.toString(),
          year: now.year.toString(),
          week: Date().isoWeekNumber(now).toString()));
  expancess_provider.addExpancess(expancess);

  Navigator.pop(context);
  Navigator.pop(context);
  // Navigator.popAndPushNamed(context, "worker_details/${worker.id}");
}

Paid_worker(BuildContext context, Worker worker) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: SingleChildScrollView(child: Paid(worker: worker)),
  );

  // show the dialog
  if (paid(worker) && ((worker.comission - worker.comission_paid) <= 0)) {
    EasyLoading.showInfo(
      "salairy_paided".tr(namedArgs: {
            'date': " ${worker.salaire_date} ",
          }, args: [
            ''
          ]) +
          "\n" +
          "comisson_paided".tr().toString(),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

_info(Worker worker) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      worker.imageURL != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10000.0),
              child: CachedNetworkImage(
                height: 150.w,
                width: 150.w,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                    height: 150.w,
                    width: 150.w,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                            "res/images/logo.png",
                          ), // picked file
                          fit: BoxFit.fill),
                    )),
                imageUrl: worker.imageURL,
              ),
            )
          : new Container(
              height: 150.w,
              width: 150.w,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                      "res/images/logo.png",
                    ), // picked file
                    fit: BoxFit.fill),
              )),
      SizedBox(
        height: 10.h,
      ),
      Text(
        'paid_worker_txt'.tr().toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Styles().fontSize_name,
          fontWeight: FontWeight.normal,
        ),
      )
    ],
  );
}
