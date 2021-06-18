import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/offer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/ui/widget/ListViews/customers/customer_list_inshare.dart';
import '../../../tooles/constants/styles.dart';

final _formKey = GlobalKey<FormState>();
String _share_txt;

showAlertDialog_share_offer(BuildContext context, Offer offer) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: SingleChildScrollView(
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        width: 750.w,
        height: 900.h,
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'share_offer'.tr().toString(),
                      style: TextStyle(fontSize: Styles().fontSize_name),
                    ),
                    InkResponse(
                      onTap: () async {
                        await EasyLoading.dismiss();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.grey[200]),
                          child: Icon(
                            Icons.close,
                            size: 18.sp,
                          )),
                    )
                  ],
                ),
                // _offer_info(offer),
                Container(
                    height: MediaQuery.of(context).size.height,
                    child: List_customer_inshare(
                      offer: offer,
                    )),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  ;

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// _offer_info(Offer offer) {
//   int _maxSMSlenght = 2;
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Container(
//         width: 150.w,
//         height: 150.w,
//         child: offer.imageURL != null
//             ? ClipRRect(
//                 borderRadius: BorderRadius.circular(10000.0),
//                 child: CachedNetworkImage(
//                   height: 150.w,
//                   width: 150.w,
//                   alignment: Alignment.topCenter,
//                   fit: BoxFit.cover,
//                   // placeholder: (context, url) => CircularProgressIndicator(),
//                   imageUrl: offer.imageURL,
//                 ),
//               )
//             : CircleAvatar(
//                 //  fit: BoxFit.cover,
//                 backgroundImage: AssetImage(
//                   "res/images/service1.png",
//                 ),
//               ),
//       ),
//       SizedBox(
//         height: 10.h,
//       ),
//       Text(
//         offer.name,
//         maxLines: 1,
//         style: TextStyle(
//           fontSize: Styles().fontSize_name,
//           fontWeight: FontWeight.normal,
//         ),
//       ),
//       SizedBox(
//         height: 10.h,
//       ),
//       Padding(
//         padding: EdgeInsets.symmetric(vertical: 20.h),
//         child: Container(
//           height: 300.h,
//           child: Form(
//             key: _formKey,
//             child: TextFormField(
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//               minLines: 10,

//               onChanged: (value) {
//                 _formKey.currentState.validate();
//                 return "share_txt".tr().toString();
//               },
//               // inputFormatters: [
//               //   new LengthLimitingTextInputFormatter(3),
//               // ],
//               validator: (value) {
//                 if (value.length > _maxSMSlenght) {
//                   return "maxlenght".tr(
//                       namedArgs: {'lang': _maxSMSlenght.toString()},
//                       args: ['']);

//                   // return "maxlenght".tr(
//                   //   namedArgs: {'lenght': _maxSMSlenght.toString()},
//                   //   args: ['Easy localization'],
//                   // ).toString();
//                 }
//                 if (value.isEmpty) {
//                   return "share_txt".tr().toString();
//                 } else {
//                   _share_txt = value;
//                 }
//                 return null;
//               },
//               // cursorHeight: 125,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 hintText: "share_txt".tr().toString(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
