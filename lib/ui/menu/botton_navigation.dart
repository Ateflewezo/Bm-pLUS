import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/modules/date.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/control/services/operation.dart';
import 'package:service_app/ui/widget/Popups/operations/added_succ.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import '../widget/Popups/operations/add_new.dart';

import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/widget/Popups/Store/nopermssions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

int _cIndex = 4;

class BottonNavigation extends StatefulWidget {
  // bool isoperator = false;
  // BottonNavigation({this.isoperator});

  //  BottonNavigation(_cIndex);
  @override
  _BottonNavigationState createState() => _BottonNavigationState();
}

class _BottonNavigationState extends State<BottonNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _cIndex,
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          title: Text(""),
          icon: Image(
            image: AssetImage("res/images/workers.png"),
            color: _cIndex == 0 ? Colors.blue : Colors.black,
          ),
        ),
        BottomNavigationBarItem(
            title: Text(""),
            icon: Image(
              image: AssetImage("res/images/car.png"),
              color: _cIndex == 1 ? Colors.blue : Colors.black,
            )

            // Icon(
            //   Icons.settings,
            // ),
            ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_border,
              color: Colors.transparent,
            ),
            title: Text('   ')),
        BottomNavigationBarItem(
          title: Text(""),
          icon: Image(
            image: _cIndex == 3
                ? AssetImage("res/images/cart_select.png")
                : AssetImage("res/images/cart.png"),
          ),
        ),
        BottomNavigationBarItem(
          title: Text(""),
          icon: Image(
            image: _cIndex == 4
                ? AssetImage("res/images/home_select.png")
                : AssetImage("res/images/home.png"),
          ),
        )
      ],
      onTap: (index) {
        print(index);
        setState(() {
          _cIndex = index;
        });

        switch (index) {
          case 1:
            Navigator.pushNamed(context, '/services');
            break;
          case 0:
            Navigator.pushNamed(context, '/workers');
            break;
          case 3:
            Navigator.pushNamed(context, '/products');
            break;
          case 4:
            Navigator.pushNamed(context, '/home');
            break;
        }
      },
    );
  }
}

class FloatinButton extends StatefulWidget {
  bool isopearation;
  FloatinButton({@required this.isopearation});
  @override
  _FloatinButtonState createState() => _FloatinButtonState();
}

bool begin_operation = false;
var bloc;

class _FloatinButtonState extends State<FloatinButton> {
  @override
  Widget build(BuildContext context) {
    print("namerout  ${widget.isopearation}");

    bloc = Provider.of<Operation_provider>(context, listen: true);

    return
        // FloatingActionButtonLocation.endFloat,
        bloc.have_custom == true
            ? FloatingActionButton(
                onPressed: () {
                  // _Add_operation(context);

                  widget.isopearation
                      ? _Add_operation(context)
                      : Navigator.pushNamed(context,
                          '/add_operation/${bloc.customer.phone_number}');
                },
                tooltip: 'Increment',
                child: new Icon(
                  Icons.save_outlined,
                  size: 35.sp,
                  color: Colors.white,
                ),
              )
            : FloatingActionButton(
                onPressed: () {
                  Stream userStream =
                      Stream.fromFuture(Store().getStore_Info());
                  userStream.listen((event) {
                    User user = event;
                    print(
                        'operations_permissions ${event.operations_permissions[0].value}');
                    if (user.operations_permissions[0].value) {
                      Start_operation(context);
                    } else {
                      NO_Permissions(context);
                    }
                  });
                },
                tooltip: 'Increment',
                child: new Icon(
                  Icons.add,
                  size: 35.sp,
                ),
              );
  }

  Future<void> _Add_operation(BuildContext context) async {
    var bloc = Provider.of<Operation_provider>(context, listen: false);
    if (bloc.serviceslist.isEmpty && bloc.productslist.isEmpty) {
      EasyLoading.showInfo('empty_operation'.tr().toString());
      return;
    }
    if (bloc.serviceslist.isEmpty) {
      double tot = bloc.product_total + bloc.service_total;
      if (tot - bloc.paid > 0) {
        EasyLoading.showError("should_paid".tr().toString());
        return;
      }
      bloc.state = 4;
    } else {
      bloc.state = 1;
    }

    Progress progress = Progress();
    progress.OnProgress(context, false);

    Operations_provider operations_provider = Operations_provider();

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy/MM/dd');
    String date = formatter.format(now);
    bloc.date_all = date;
    bloc.date = Date(
        day: now.day.toString(),
        month: now.month.toString(),
        year: now.year.toString(),
        week: Date().isoWeekNumber(now).toString());
    print(DateTime.now().millisecondsSinceEpoch);
    bloc.id = (now.millisecondsSinceEpoch - 1607000000000).toString();

    operations_provider.add_operation(bloc).then((value) {});

    //////libre le bloc
    bloc.liber();

    Navigator.of(context).pushNamed("/home");
    operation_added_succ(context, progress);
  }
}
