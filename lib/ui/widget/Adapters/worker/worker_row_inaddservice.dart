import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/modules/service.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import '../../../tooles/constants/colors_app.dart' as _color;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Worker_row_inADDservice extends StatefulWidget {
  Worker worker;
  Service service;
  Worker_row_inADDservice({this.worker, this.service});
  @override
  _Worker_row_inADDserviceState createState() =>
      _Worker_row_inADDserviceState();
}

bool selected = false;
// double _commission;

class _Worker_row_inADDserviceState extends State<Worker_row_inADDservice> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    var bloc = Provider.of<Operation_provider>(context, listen: false);

    return InkResponse(
      onTap: () {
        if (_formKey.currentState.validate()) {
          setState(() {
            // Service service = widget.service;
            // if (!widget.worker.with_comission) {
            //   service.commission = 0;
            // }
            bloc.addWaiting_service(widget.service, widget.worker);
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    border: Border.all(
                      color: (bloc.waiting_service != null &&
                              bloc.contains_worker(
                                  widget.worker)) //widget.worker.selected
                          ? _color.product_details1
                          : Colors.transparent,
                      width: 2.w,
                    ),
                  ),
                  width: 90.w,
                  height: 90.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10000.0),
                    child: CachedNetworkImage(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircleAvatar(
                        backgroundImage: AssetImage("res/images/logo.png"),
                      ),
                      imageUrl: widget.worker.imageURL,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(3.w),
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                      color:
                          widget.worker.state == 1 ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              widget.worker.name,
              maxLines: 1,
              style: TextStyle(
                fontSize: Styles().fontSize_name,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 80.h,
              width: 150.w,
              child: Form(
                key: _formKey,
                child: !widget.worker.with_comission
                    ? SizedBox()
                    : TextFormField(
                        textAlign: TextAlign.center,
                        initialValue: (bloc.waiting_service != null &&
                                bloc.contains_worker(widget.worker))
                            ? bloc
                                .get_worker(widget.worker)
                                .comission
                                .toString()
                            : widget.service.commission.toString(),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (!widget.worker.with_comission) {
                            widget.worker.comission = 0.0;
                          } else {
                            if (value.isEmpty) {
                              // return "work_commission".tr().toString();
                              widget.worker.comission = 0.0;
                            } else {
                              widget.worker.comission = double.parse(value);
                            }
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: "work_commission".tr().toString(),
                            labelStyle: Styles().textStyle_labelstyle),
                        onChanged: (value) {},
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
