import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// For Image Picker
import 'package:path/path.dart' as Path;
import 'package:service_app/control/modules/product.dart';
import 'package:service_app/control/services/products.dart';
import 'package:service_app/ui/widget/progress/progress.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class Product_update extends StatefulWidget {
  Product product;
  Product_update({@required this.product});
  @override
  _Product_updateState createState() => _Product_updateState();
}

class _Product_updateState extends State<Product_update> {
  File _image;
  String _uploadedFileURL, _product_name;
  double _price;
  bool new_image = false, saving = false;

  Future uploadFile(BuildContext context, Product product_old) async {
    Progress progress = Progress();
    progress.OnProgress(context, true);
    saving = true;
    Products_provider products = Products_provider();
    if (!new_image) {
      Product product = Product(
          name: _product_name,
          price: _price,
          imageURL: widget.product.imageURL);

      products.updateProduct(product, product_old.id);
      progress.cancelTimer();
      Navigator.of(context).pop();
      return;
    }
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('products/${Path.basename(_image.path)}}');
    // UploadTask uploadTask =
    await storageReference.putFile(_image).then((doc) => doc != null
        ? print('File Uploaded ${doc.toString()}')
        : print('error Uploaded'));
    // await uploadTask.onComplete;
    // print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) async {
      _uploadedFileURL = fileURL;
      print('File Uploaded url ${_uploadedFileURL.toString()}');

      Product product = Product(
          name: _product_name, price: _price, imageURL: _uploadedFileURL);

      products.updateProduct(product, widget.product.id);
      progress.cancelTimer();
      Navigator.of(context).pop();
    });
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(
            source: ImageSource.gallery, imageQuality: Styles().imageQuality)
        .then((image) {
      setState(() {
        _image = image;
        new_image = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // set up the button
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          width: 700.w,
          // height: 440,
          child: ListView(
            shrinkWrap: true,
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Container(
                      width: 50.w,
                      height: 50.h,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150.w,
                    height: 150.w,
                    child: _image != null
                        ? new Image.file(File(_image.path))
                        : widget.product.imageURL != null
                            ? CachedNetworkImage(
                                height: 150.w,
                                alignment: Alignment.topCenter,
                                // placeholder: (context, url) => CircularProgressIndicator(),
                                imageUrl: widget.product.imageURL,
                              )
                            : null,
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
              Container(
                height: 90.h,
                child: TextFormField(
                  initialValue: widget.product.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "product_name".tr().toString();
                    } else {
                      _product_name = value;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    counterStyle: TextStyle(fontSize: 18.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.h),
                      ),
                    ),
                    labelText: "product_name".tr().toString(),
                    labelStyle: Styles().textStyle_labelstyle,
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: 90.h,
                child: TextFormField(
                  initialValue: widget.product.price.toString(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "price".tr().toString();
                    } else {
                      _price = double.parse(value);
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    counterStyle: TextStyle(fontSize: 18.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.h),
                      ),
                    ),
                    labelText: "price".tr().toString(),
                    labelStyle: Styles().textStyle_labelstyle,
                  ),
                  onChanged: (value) {},
                ),
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
                      if (saving) {
                        return;
                      }
                      if (_formKey.currentState.validate()) {
                        uploadFile(context, widget.product);
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
      ),
    );
  }
}

Product_update_alert(BuildContext context, Product product) {
  // set up the button
  final _formKey = GlobalKey<FormState>();
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(content: Product_update(product: product));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
