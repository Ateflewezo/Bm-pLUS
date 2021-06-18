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
import '../../../tooles/constants/colors_app.dart' as _color;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class Product_addnew extends StatefulWidget {
  @override
  _Product_addnewState createState() => _Product_addnewState();
}

class _Product_addnewState extends State<Product_addnew> {
  File _image;
  String _uploadedFileURL, _product_name;
  double _price;
  bool saving = false;
  Future uploadFile(BuildContext context) async {
    if (_image == null) {
      EasyLoading.showError("upload_image".tr().toString());
      return;
    }
    Progress progress = Progress();
    progress.OnProgress(context, true);
    saving = true;
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
          name: _product_name,
          // description: "des1",
          price: _price,
          imageURL: _uploadedFileURL);

      Products_provider products = Products_provider();
      products.addProduct(product);
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
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            //  fit: BoxFit.cover,
                            backgroundImage: AssetImage(
                              "res/images/upload.png",
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      chooseFile();
                    },
                    child: Text(
                      "upload_image".tr().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return "product_name".tr().toString();
                    } else {
                      _product_name = value;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    counterStyle: TextStyle(fontSize: Styles().fontSize_name),
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
                    counterStyle: TextStyle(fontSize: Styles().fontSize_name),
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

Product_addnew_alert(BuildContext context) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(content: Product_addnew());

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
