import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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

class UpdateService extends StatefulWidget {
  Service service;
  UpdateService({@required this.service});
  @override
  _UpdateServiceState createState() => _UpdateServiceState();
}

class _UpdateServiceState extends State<UpdateService> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  bool _choseimage = false;
  String _uploadedFileURL, _service_name;
  double _price, _commission;
  bool saving = false;
  Future uploadFile(BuildContext context) async {
    Progress progress = Progress();
    progress.OnProgress(context, true);
    saving = true;
    Services_provider services_provider = Services_provider();
    if (!_choseimage) {
      Service service = Service(
          name: _service_name,
          commission: _commission,
          price: _price,
          imageURL: widget.service.imageURL);
      services_provider.updateService(service, widget.service, false);
      progress.cancelTimer();
      Navigator.pop(context);
    }

    print("_image.path ${_image.path}");
    if (_choseimage) {
      print("_image.path enter1");
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('services/${Path.basename(_image.path)}}');
      // UploadTask uploadTask =

      await storageReference.putFile(_image).then((doc) => doc != null
          ? print('File Uploaded ${doc.toString()}')
          : print('error Uploaded'));

      await storageReference.getDownloadURL().then((fileURL) async {
        _uploadedFileURL = fileURL;
        print('File Uploaded url ${_uploadedFileURL.toString()}');
        Service service = Service(
            name: _service_name,
            price: _price,
            commission: _commission,
            imageURL: _uploadedFileURL);
        services_provider.updateService(service, widget.service, true);
        progress.cancelTimer();

        Navigator.pop(context);
      });
    }
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(
            source: ImageSource.gallery, imageQuality: Styles().imageQuality)
        .then((image) {
      setState(() {
        _image = image;
        _choseimage = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    width: 150.w,
                    height: 150.w,
                    child: _image != null
                        ? new Image.file(File(_image.path))
                        : widget.service.imageURL != null
                            ? CachedNetworkImage(
                                height: 150.w,
                                alignment: Alignment.topCenter,
                                // placeholder: (context, url) => CircularProgressIndicator(),
                                imageUrl: widget.service.imageURL,
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: TextFormField(
                  initialValue: widget.service.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return " ";
                      // "service_name".tr().toString();
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
              TextFormField(
                initialValue: widget.service.price.toString(),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return " "; //"price".tr().toString();
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
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                initialValue: widget.service.commission.toString(),
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
                    labelStyle: Styles().textStyle_labelstyle),
                onChanged: (value) {},
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
                      Navigator.pop(context);
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

///////////////******Add new  Service */

Service_update(BuildContext context, Service service) {
  // set up the button
  final _formKey = GlobalKey<FormState>();
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: UpdateService(
      service: service,
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
