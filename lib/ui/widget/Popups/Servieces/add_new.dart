import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../control/modules/service.dart';
import '../../../../control/services/services.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import 'package:path/path.dart' as Path;
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  String _uploadedFileURL, _service_name;
  double _price, _commission;
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
        .child('services/${Path.basename(_image.path)}}');
    // UploadTask uploadTask =
    await storageReference.putFile(_image).then((doc) => doc != null
        ? print('File Uploaded ${doc.toString()}')
        : print('error Uploaded'));
    // await uploadTask.onComplete;
    // print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) async {
      _uploadedFileURL = fileURL;
      print('File Uploaded url ${_uploadedFileURL.toString()}');

      Service product = Service(
          name: _service_name,
          price: _price,
          commission: _commission,
          imageURL: _uploadedFileURL);

      Services_provider services_provider = Services_provider();
      services_provider.addService(product);
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Progress progress = Progress();
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          width: 700.w,
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    height: 10.h,
                  ),
                  TextButton(
                    onPressed: () {
                      chooseFile();
                    },
                    child: Text(
                      "upload_image".tr().toString(),
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
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Container(
                  height: 90.h,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "service_name".tr().toString();
                      } else {
                        _service_name = value;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        labelText: "service_name".tr().toString(),
                        labelStyle: Styles().textStyle_labelstyle),
                    onChanged: (value) {},
                  ),
                ),
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
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 90.h,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "work_commission".tr().toString();
                    } else {
                      _commission = double.parse(value);
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: "work_commission".tr().toString(),
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
                      height: 80.w,
                      child: Text(
                        "verf".tr().toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Styles().fontSize_name,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (saving) {
                        return;
                      }
                      if (_formKey.currentState.validate()) {
                        uploadFile(context);
                        // await EasyLoading.showProgress(0.5);
                        // Navigator.of(context).pop();
                        // Navigator.pushNamed(context, '/add_operation');
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
}

Service_addnew(BuildContext context) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(content: AddService());

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
