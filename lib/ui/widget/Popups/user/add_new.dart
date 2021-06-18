import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:service_app/control/services/users.dart';
import 'package:service_app/control/services/worker.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import 'package:path/path.dart' as Path;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

Future New_UserAlert(BuildContext context) async {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: AddNew_user(),
  );

  // show the dialog
  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class AddNew_user extends StatefulWidget {
  @override
  _AddNew_userState createState() => _AddNew_userState();
}

class _AddNew_userState extends State<AddNew_user> {
  File _image = null;
  String _uploadedFileURL, _full_name, _phone_number, _password;
  bool saving = false;

  Future uploadFile(BuildContext context) async {
    if (_image == null) {
      EasyLoading.showError("upload_image".tr().toString());
      return;
    }
    Progress progress = Progress();
    progress.OnProgress(context, true);
    saving = true;
    Users_provider().addUser_test(_phone_number).then((value) async {
      if (value) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('users/${Path.basename(_image.path)}}');
        // UploadTask uploadTask =
        await storageReference.putFile(_image).then((doc) => doc != null
            ? print('File Uploaded ${doc.toString()}')
            : print('error Uploaded'));

        await storageReference.getDownloadURL().then((fileURL) async {
          _uploadedFileURL = fileURL;
          print('File Uploaded url ${_uploadedFileURL.toString()}');
          User user;

          Stream<User> user_Data = Stream.fromFuture(Store().getStore_Info());
          user_Data.listen((data) {
            user = User(
                store_id: data.store_id,
                name: _full_name,
                password: _password,
                type: _currentlan,
                phone_number: _phone_number,
                imageURL: _uploadedFileURL);

            Users_provider users_provider = Users_provider();
            users_provider.addUser(user).then((value) {
              progress.cancelTimer();
              Navigator.pop(context);
            });
          });
        });
      }
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

  String _currentlan = "admin";
  void changedDropDownItem(String selectedlan) {
    setState(() {
      _currentlan = selectedlan;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(new DropdownMenuItem(
      value: "admin",
      child: new Text(
        "admin".tr().toString(),
        style: Styles().textStyle_labelstyle,
      ),
      onTap: () {},
    ));
    items.add(new DropdownMenuItem(
      value: "acounter",
      child: new Text(
        "acounter".tr().toString(),
        style: Styles().textStyle_labelstyle,
      ),
      onTap: () {},
    ));
    items.add(new DropdownMenuItem(
      value: "boss",
      child: new Text(
        "boss".tr().toString(),
        style: Styles().textStyle_labelstyle,
      ),
      onTap: () {},
    ));
    return items;
  }

/////////

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Container(
        height: 900.h,
        width: 700.h,
        child: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
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
                  SizedBox(
                    height: 20.h,
                  ),
                  new Container(
                      height: 150.w,
                      width: 150.w,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        // border:
                        //     Border.all(color: const Color(0x33A6A6A6)),
                        image: _image != null
                            ? DecorationImage(
                                image: FileImage(_image), // picked file
                                fit: BoxFit.fill)
                            : DecorationImage(
                                image: AssetImage(
                                  "res/images/upload.png",
                                ), // picked file
                                fit: BoxFit.fill),
                      )),
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
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "fullname".tr().toString();
                    } else {
                      _full_name = value;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: "fullname".tr().toString(),
                    labelStyle: Styles().textStyle_labelstyle,

                    // labelText: "name".tr().toString(),
                  ),
                  onChanged: (value) {},
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "phone_number".tr().toString();
                  } else {
                    _phone_number = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: "phone_number".tr().toString(),
                  labelStyle: Styles().textStyle_labelstyle,

                  // labelText: "name".tr().toString(),
                ),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "password".tr().toString();
                  } else {
                    _password = value;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: "password".tr().toString(),
                  labelStyle: Styles().textStyle_labelstyle,

                  // labelText: "name".tr().toString(),
                ),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 90.h,
                width: 600.w,
                child: DropdownButton(
                  value: _currentlan,
                  items: getDropDownMenuItems(),
                  onChanged: changedDropDownItem,
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
                          fontSize: Styles().fontSize_name,
                        ),
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
