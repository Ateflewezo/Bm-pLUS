import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:service_app/control/services/locator.dart';
import 'package:service_app/control/services/worker.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:service_app/ui/widget/Popups/Workers/paid_worker.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../widget/currency_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../screens/worker_details.dart';

class Worker_Row extends StatefulWidget {
  Worker worker;
  Worker_Row({this.worker});
  @override
  _Worker_RowState createState() => _Worker_RowState();
}

class _Worker_RowState extends State<Worker_Row> {
  @override
  Widget build(BuildContext context) {
    Worker worker = widget.worker;
    return InkResponse(
      onTap: () {
        Stream<User> user = Stream.fromFuture(Store().getStore_Info());
        user.listen((event) {
          setuplocator_workerPayment(worker.id, event.store_id);
          setuplocator_worker_operation(
              '${event.store_id}/workers/${worker.id}/complete_operations');
          Navigator.pushNamed(context, "worker_details/${worker.id}");
        });
      },
      child: Slidable(
        // delegate: new SlidableDrawerDelegate(),+
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.25,

        actions: <Widget>[
          Container(
            width: 60.w,
            height: 150.h,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: IconButton(
              icon: Image(
                image: AssetImage("res/images/pay.png"),
              ),
              onPressed: () {
                Paid_worker(context, worker);
              },
            ),

            // onTap: () => _showSnackBar('Share'),
          ),
        ],
        secondaryActions: <Widget>[
          Container(
            height: 150.h,
            width: 60.w,
            decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 35.sp,
              ),
              onPressed: () {
                if (worker.complete_operation != 0) {
                  EasyLoading.showError("hav_operation".tr().toString());
                  return;
                }

                Workers_provider().removeWroker(worker.id, '');
                Navigator.popAndPushNamed(context, '/workers');
              },
            ),

            // onTap: () => _showSnackBar('Share'),
          ),
        ],
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Colors.grey,
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 50.w),
            height: 150.h,
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    worker.imageURL != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: CachedNetworkImage(
                              height: 100.w,
                              width: 100.w,
                              alignment: Alignment.topCenter,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => CircleAvatar(
                                backgroundImage:
                                    AssetImage("res/images/logo.png"),
                              ),
                              imageUrl: worker.imageURL,
                            ),
                          )
                        : new Container(
                            height: 90.w,
                            width: 90.w,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              // border:
                              //     Border.all(color: const Color(0x33A6A6A6)),
                              image: DecorationImage(
                                  image: AssetImage(
                                    "res/images/profil1.png",
                                  ), // picked file
                                  fit: BoxFit.fill),
                            )),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          worker.name,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: Styles().fontSize_name,
                          ),
                        ),
                        Text(
                          paid(worker)
                              ? "paid".tr().toString()
                              : "unpaid".tr().toString(),
                          style: TextStyle(
                            color: paid(worker) ? Colors.green : Colors.red,
                            fontSize: Styles().fontSize_price_ad,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                adapter_currency(
                  context,
                  worker.total_paid,
                  Colors.grey,
                  Styles().fontSize_price_ad,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
