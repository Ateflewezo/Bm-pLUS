import 'package:currency_pickers/country.dart';
import 'package:currency_pickers/currency_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/provider/operation.dart';
import '../../../../control/services/store.dart';

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import 'package:path/path.dart' as Path;
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class Edite_Info extends StatefulWidget {
  Store_classe store;
  Edite_Info({this.store});
  @override
  _Edite_InfoState createState() => _Edite_InfoState();
}

class _Edite_InfoState extends State<Edite_Info> {
  String _currentlan = "USD";

  //  =
  //     CurrencyPickerUtils.getCountryByIsoCode('tr');
  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CurrencyPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.currencyCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );
  Widget _buildCupertinoItem(Country country) {
    return DefaultTextStyle(
      style: TextStyle(
        color: CupertinoColors.white,
        fontSize: Styles().fontSize_subname,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 8.0),
          CurrencyPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.currencyCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      ),
    );
  }

  void _openCurrencyPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CurrencyPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your phone code'),
                itemBuilder: _buildDialogItem,
                onValuePicked: (Country country) async {
                  var bloc =
                      Provider.of<Operation_provider>(context, listen: false);
                  // Currency curr = Currency.create(country.currencyCode, 2);
                  // bloc.usd = Currency.create(country.currencyCode, 2);
                  await bloc.setcurrency(country);

                  Money lowPrice = Money.fromInt(10335, bloc.currency);
                  print(lowPrice.format('SCC000.000'));
                  print(lowPrice.format('CCC 0.0'));
                  print('country ${country.currencyCode}');
                  setState(() {
                    selectedCupertinoCountry = country;
                    _unite = country.currencyCode;
                    _iso = country.isoCode;
                  });
                })),
      );

  void openCupertinoCurrencyPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CurrencyPickerCupertino(
            backgroundColor: Colors.black,
            itemBuilder: _buildCupertinoItem,
            pickerSheetHeight: 500.h,
            pickerItemHeight: 100.h,
            initialCountry: selectedCupertinoCountry,
            onValuePicked: (Country country) async {
              var bloc =
                  Provider.of<Operation_provider>(context, listen: false);
              // Currency curr = Currency.create(country.currencyCode, 2);
              // bloc.usd = Currency.create(country.currencyCode, 2);
              await bloc.setcurrency(country);
              // await bloc.getcurrency();

              Money lowPrice = Money.fromInt(10335, bloc.currency);
              print(lowPrice.format('SCC000.000'));
              print(lowPrice.format('CCC 0.0'));
              print('country ${country.currencyCode}');
              setState(() => selectedCupertinoCountry = country);
            });
      });

  Widget buildCupertinoSelectedItem(Country country) {
    return Row(
      children: <Widget>[
        CurrencyPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 8.w),
        Text("+${country.currencyCode}"),
        SizedBox(width: 8.w),
        Flexible(child: Text(country.name))
      ],
    );
  }

  void changedDropDownItem(String selectedlan) {
    setState(() {
      _currentlan = selectedlan;
    });
  }

/////////
  String _currentactivity = "مغسلة سيارات";
  void changedDropDownItem_activity(String selectedlan) {
    setState(() {
      _currentactivity = selectedlan;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems_activity() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(new DropdownMenuItem(
      value: "مغسلة سيارات",
      child: new Text("مغسلة سيارات"),
      onTap: () {
        // setState(() {
        //   EasyLocalization.of(context).locale = Locale("ar", "SA");
        // });
      },
    ));
    items.add(new DropdownMenuItem(
      value: "مغسلة ملابس",
      child: new Text("مغسلة ملابس"),
      onTap: () {
        // setState(() {
        //   EasyLocalization.of(context).locale = Locale("en", "US");
        // });
      },
    ));
    return items;
  }

  Country selectedCupertinoCountry;
//  =
//       CurrencyPickerUtils.getCountryByIsoCode('DZ');
  @override
  Future<void> initState() {
    // TODO: implement initState
    var bloc = Provider.of<Operation_provider>(context, listen: false);
    Stream<String> stream = Stream.fromFuture(Store().getStore_currency());
    stream.listen((event) {});

    super.initState();
  }

  File _image;
  bool _choseimage = false;
  String _uploadedFileURL, _name, _sms_phone, _unite, _iso;

  Future uploadFile(BuildContext context, Store_classe store_old) async {
    // if (_image == null) {
    //   EasyLoading.showError("upload_image".tr().toString());
    //   return;
    // }
    Progress progress = Progress();
    progress.OnProgress(context, true);
    Store_classe store_new = Store_classe();
    store_new.name = _name;
    store_new.sms_number = _sms_phone;
    store_new.unite = _unite;
    store_new.iso = _iso;
    if (_image == null) {
      Stores_provider stores_provider = Stores_provider();
      store_new.image = store_old.image;
      stores_provider
          .updateStore(store_new, store_old, false)
          .then((value) => Navigator.pop(context));
      return;
    }
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('stores/${Path.basename(_image.path)}}');
    // UploadTask uploadTask =
    await storageReference.putFile(_image).then((doc) => doc != null
        ? print('File Uploaded ${doc.toString()}')
        : print('error Uploaded'));
    // await uploadTask.onComplete;
    // print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) async {
      _uploadedFileURL = fileURL;
      print('File Uploaded url ${_uploadedFileURL.toString()}');

      store_new.image = _uploadedFileURL;

      Stores_provider stores_provider = Stores_provider();
      stores_provider.updateStore(store_new, store_old, true);
      progress.cancelTimer();
      Navigator.pop(context);
    });
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(
            source: ImageSource.gallery, imageQuality: Styles().imageQuality)
        .then((image) {
      setState(() {
        _image = image;
        // _choseimage = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _details(widget.store);
  }

  Widget _details(Store_classe data) {
    print("store data ${data.toJson().toString() + "  " + data.id}");
    // _unite=data.unite;
    //              _iso=data.iso;
    final _formKey = GlobalKey<FormState>();
    return Container(
      width: 750.w,
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    width: 150.w,
                    height: 150.w,
                    child: _image != null
                        ? new ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: Image.file(File(_image.path)),
                          )
                        : data.image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10000.0),
                                child: CachedNetworkImage(
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => new Container(
                                      decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "res/images/logo.png",
                                        ),
                                        fit: BoxFit.fill),
                                  )),
                                  imageUrl: data.image,
                                ),
                              )
                            : new Container(
                                decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                      "res/images/logo.png",
                                    ),
                                    fit: BoxFit.fill),
                              )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    onPressed: () {
                      chooseFile();
                    },
                    child: Text(
                      "edit_image".tr().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Styles().fontSize_name,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: TextFormField(
                  initialValue: data.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "name".tr().toString();
                    } else {
                      _name = value;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: "name".tr().toString(),
                    labelStyle: Styles().textStyle_labelstyle,
                    // labelText: "name".tr().toString(),
                  ),
                  onChanged: (value) {},
                ),
              ),
              TextFormField(
                initialValue: data.sms_number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "sms_phone".tr().toString();
                  } else {
                    _sms_phone = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: "sms_phone".tr().toString(),
                  labelStyle: Styles().textStyle_labelstyle,
                  // labelText: "name".tr().toString(),
                ),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 20.h,
              ),
              // _unite_fun(_iso, Colors.grey),

              FutureBuilder(
                future: Store().getStore_data(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _iso = snapshot.data.iso;
                    _unite = snapshot.data.unite;
                    return _unite_fun(snapshot.data.iso, Colors.grey);
                  } else {
                    return Center(
                      child: Text('loading'.tr(),
                          style: Styles().textStyle_nodata),
                    );
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              // Container(
              //   padding: EdgeInsets.all(8.0),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey, width: 1),
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(10),
              //     ),
              //   ),
              //   height: 60,
              //   width: 250,
              //   child: DropdownButton(
              //     value: _currentlan,
              //     items: getDropDownMenuItems(),
              //     onChanged: changedDropDownItem,
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
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
                      width: 130.w,
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
                        uploadFile(context, data);
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
                      width: 130.w,
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
        ),
      ),
    );
  }

  Widget _unite_fun(String data, Color color) {
    print(data.toString());
    selectedCupertinoCountry =
        CurrencyPickerUtils.getCountryByIsoCode(data.toString());
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      height: 90.h,
      width: 700.w,
      child: ListTile(
        title: buildCupertinoSelectedItem(selectedCupertinoCountry),
        onTap: _openCurrencyPickerDialog,
      ),
    );
  }
}
