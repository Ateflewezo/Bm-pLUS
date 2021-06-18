import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/provider/operation.dart';
import 'package:service_app/ui/widget/ListViews/products/product_list_toadd_operation.dart';
import '../tooles/constants/colors_app.dart' as Constance;
import '../tooles/constants/styles.dart' as styles;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Add_Product_To_Operation extends StatefulWidget {
  @override
  _Add_Product_To_OperationState createState() =>
      _Add_Product_To_OperationState();
}

var _padding = EdgeInsets.symmetric(horizontal: 50.w);
var bloc;

class _Add_Product_To_OperationState extends State<Add_Product_To_Operation> {
  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<Operation_provider>(context);
    return Padding(
      padding: _padding,
      child: Scaffold(
        appBar: _appBar(),
        body: Column(
          children: [
            // SizedBox(
            //   height: 40.h,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     RotatedBox(
            //       quarterTurns: 0,
            //       child: IconButton(
            //         icon: Icon(
            //           bloc.productslist.length == 0
            //               ? Icons.arrow_back_ios
            //               : Icons.check,
            //         ),
            //         onPressed: () {
            //           Navigator.popAndPushNamed(context,
            //               '/add_operation/${bloc.customer.phone_number}');
            //           // Navigator.pop(context);
            //         },
            //       ),
            //     ),
            //     Text(
            //       'add_service_to_oper'.tr().toString(),
            //       style: styles.title_style,
            //     ),
            //     RotatedBox(
            //       quarterTurns: 1,
            //       child: IconButton(
            //         icon: Icon(
            //           Icons.search,
            //           // color: Colors.transparent,
            //         ),
            //         onPressed: () {
            //           Navigator.pushNamed(context, "/search");
            //         },
            //       ),
            //     )
            //   ],
            // ),

            SizedBox(
              height: 20.h,
            ),
            Expanded(child: List_products_Add_To_operation(context)),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leadingWidth: 100,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.grey[50],
      leading: IconButton(
        icon: Icon(
          bloc.productslist.length == 0 ? Icons.arrow_back_ios : Icons.check,
          color: Colors.black,
        ),
        onPressed: () {
          // Navigator.popAndPushNamed(
          //     context, '/add_operation/${bloc.customer.phone_number}');
          Navigator.pop(context);
        },
      ),
      actions: [
        Padding(
          padding: _padding,
          child: RotatedBox(
            quarterTurns:
                EasyLocalization.of(context).locale == Locale("en", "US")
                    ? 4
                    : 1,
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.transparent,
              ),
              onPressed: () {
                // Navigator.pushNamed(context, "/search");
              },
            ),
          ),
        )
      ],
      title: Center(
        child: Text(
          'add_service_to_oper'.tr().toString(),
          style: styles.title_style,
        ),
      ),
    );
  }
}
