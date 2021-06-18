import 'package:flutter/material.dart';
import 'package:service_app/control/modules/date.dart';
import 'package:service_app/control/modules/expancess.dart';
import 'package:service_app/control/services/expancess.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../../../control/modules/service.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../tooles/constants/colors_app.dart' as color;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class New_expancess extends StatefulWidget {
  @override
  _New_expancessState createState() => _New_expancessState();
}

class _New_expancessState extends State<New_expancess> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  double _price;

  Future uploadFile(BuildContext context) async {
    Progress progress = Progress();
    progress.OnProgress(context, false);

    Expancess_provider expancess_provider = Expancess_provider();
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy/MM/dd');
    String date = formatter.format(now);

    Expancess expancess = Expancess(
        name: _name,
        price: _price,
        date_all: date,
        date: Date(
            day: now.day.toString(),
            month: now.month.toString(),
            year: now.year.toString(),
            week: Date().isoWeekNumber(now).toString()));
    expancess_provider.addExpancess(expancess);
    progress.cancelTimer();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          width: 700.w,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.w)),
                          color: Colors.grey[200]),
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 22.sp,
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
                    width: 120.w,
                    height: 120.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: color.color3,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Text(
                      "\$",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Styles().fontSize_name,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return " ";
                    } else {
                      _name = value;
                    }
                    return null;
                  },
                  cursorHeight: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: "name".tr().toString(),
                    labelStyle: Styles().textStyle_labelstyle,
                  ),
                  onChanged: (value) {},
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return " ";
                  } else {
                    _price = double.parse(value);
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: "price".tr().toString(),
                  labelStyle: Styles().textStyle_labelstyle,
                ),
                onChanged: (value) {},
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
                    color: Color(0xFF69ADFC),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100.w,
                      height: 50.h,
                      child: Text(
                        "verf".tr().toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Styles().fontSize_name),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        uploadFile(context);
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
                      width: 100.w,
                      height: 50.h,
                      child: Text(
                        "cancel".tr().toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Styles().fontSize_name),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///////////////******Add new  Service */

New_expancess_alert(BuildContext context) {
  // set up the button
  final _formKey = GlobalKey<FormState>();
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: New_expancess(),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
