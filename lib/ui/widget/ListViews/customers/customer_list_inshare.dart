import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:service_app/control/modules/customer.dart';
import 'package:service_app/control/services/customers.dart';
import 'package:service_app/control/services/messages.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/ui/widget/Adapters/customers/customer_row_inshare.dart';
import '../../../../control/modules/offer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _formKey = GlobalKey<FormState>();
String _share_txt;

const platform = const MethodChannel('sendSms');
Future<Null> sendSms() async {
  print("SendSMS");
  try {
    final String result = await platform.invokeMethod('send', <String, dynamic>{
      "phone": "+213672886642",
      "msg": "Hello! I'm sent programatically."
    }); //Replace a 'X' with 10 digit phone number
    print(result);
  } on PlatformException catch (e) {
    print(e.toString());
  }
}

void _sendSMS(String message, List<String> recipents) async {
  // sendSms();

  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}

class List_customer_inshare extends StatefulWidget {
  Offer offer;
  List_customer_inshare({this.offer});
  @override
  _List_customer_inshareState createState() => _List_customer_inshareState();
}

_offer_info(Offer offer) {
  int _maxSMSlenght = 100;
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 200.w,
        height: 200.w,
        child: offer.imageURL != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child: CachedNetworkImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                  // placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: offer.imageURL,
                ),
              )
            : CircleAvatar(
                //  fit: BoxFit.cover,
                backgroundImage: AssetImage(
                  "res/images/service1.png",
                ),
              ),
      ),
      SizedBox(
        height: 10.h,
      ),
      Text(
        offer.name,
        maxLines: 1,
        style: TextStyle(
          fontSize: Styles().fontSize_name,
          fontWeight: FontWeight.normal,
        ),
      ),
      SizedBox(
        height: 5.h,
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Container(
          height: 200.h,
          child: Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 10,

              onChanged: (value) {
                _formKey.currentState.validate();
                return "share_txt".tr().toString();
              },
              // inputFormatters: [
              //   new LengthLimitingTextInputFormatter(3),
              // ],
              validator: (value) {
                if (value.length > _maxSMSlenght) {
                  return "maxlenght".tr(
                      namedArgs: {'lang': _maxSMSlenght.toString()},
                      args: ['']);

                  // return "maxlenght".tr(
                  //   namedArgs: {'lenght': _maxSMSlenght.toString()},
                  //   args: ['Easy localization'],
                  // ).toString();
                }
                if (value.isEmpty) {
                  return "share_txt".tr().toString();
                } else {
                  _share_txt = value;
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: "share_txt".tr().toString(),
                  hintStyle: Styles().textStyle_labelstyle),
            ),
          ),
        ),
      ),
    ],
  );
}

class _List_customer_inshareState extends State<List_customer_inshare> {
  @override
  Widget build(BuildContext context) {
    Customers_provider customers_provider = Customers_provider();
    List<Customer> customers;
    return StreamBuilder(
        stream: customers_provider.fetchCustomerAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            customers = snapshot.data.docs
                .map((doc) => Customer.fromMap(doc.data(), doc.id))
                .toList();
            print("payments ${customers.toString()}");
            if (customers.length > 0) {
              return customers_list(
                customers: customers,
                offer: widget.offer,
              );
            } else {
              return Center(
                  child: Text(
                'nodata'.tr().toString(),
                style: Styles().textStyle_nodata,
              ));
            }
          } else {
            return Center(
                child: Text(
              'loading'.tr().toString(),
              style: Styles().textStyle_nodata,
            ));
          }
        });
  }
}

class customers_list extends StatefulWidget {
  List<Customer> customers;
  Offer offer;
  customers_list({this.customers, this.offer});
  @override
  _customers_listState createState() => _customers_listState();
}

bool _selectAll = false;

class _customers_listState extends State<customers_list> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900.h,
      child: ListView(
        children: [
          Expanded(
            // height: 200,
            child: _offer_info(widget.offer),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "select_custom".tr().toString(),
                style: TextStyle(
                    fontSize: Styles().fontSize_name,
                    fontWeight: FontWeight.bold
                    // color: Colors.white,
                    ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectAll = !_selectAll ? true : false;
                    //!_selectAll;
                    for (var item in widget.customers) {
                      item.selected = _selectAll;
                    }
                    // widget.customers.map((e) => e.selected = _selectAll);
                  });
                },
                child: Text(
                  "all".tr().toString(),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: Styles().fontSize_seeall,
                      fontWeight: FontWeight.bold
                      // color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.h,
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.customers.length,
                itemBuilder: (BuildContext context, int index) {
                  // return Product_Row();
                  return Customer_shareOffer(customer: widget.customers[index]);
                }),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "share_by".tr().toString(),
            style: TextStyle(
                fontSize: Styles().fontSize_name, fontWeight: FontWeight.bold
                // color: Colors.white,
                ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF531C4AF),
                  child: Container(
                    alignment: Alignment.center,
                    width: 180.w,
                    height: 80.h,
                    child: Text(
                      "whatsup".tr().toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Styles().fontSize_name),
                    ),
                  ),
                  onPressed: () {
                    // if (_formKey.currentState.validate()) {
                    //   Navigator.of(context).pop();
                    //   Navigator.pushNamed(context, '/add_operation');
                    // }
                  },
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF539EFF),
                  child: Container(
                    alignment: Alignment.center,
                    width: 180.w,
                    height: 80.h,
                    child: Text(
                      "sms".tr().toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Styles().fontSize_name),
                    ),
                  ),
                  onPressed: () {
                    String message = _share_txt;
                    List<String> recipents = [];

                    for (var item in widget.customers) {
                      item.selected ? recipents.add(item.phone_number) : null;
                    }

                    // _sendSMS(message, recipents);
                    Message_provider().Send_Message_(message, recipents);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
