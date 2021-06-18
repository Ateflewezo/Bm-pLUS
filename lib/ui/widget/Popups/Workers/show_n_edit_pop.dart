import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/worker.dart';
import 'package:service_app/control/services/worker.dart';
import 'package:service_app/ui/widget/progress/progress.dart';
import '../../../widget/currency_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tooles/constants/styles.dart';

class Show_info extends StatefulWidget {
  Worker worker;
  Show_info({@required this.worker});
  @override
  _Show_infoState createState() => _Show_infoState();
}

class _Show_infoState extends State<Show_info> {
  bool edite = false;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Container(
      height: 950.w,
      width: 700.w,
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
            width: 700.w,
            // height: 500.h,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                SizedBox(
                  height: 20.h,
                ),
                edite
                    ? Edite_Info(worker: widget.worker)
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 150.w,
                              height: 150.w,
                              child: widget.worker.imageURL != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10000.0),
                                      child: CachedNetworkImage(
                                        width: 150.w,
                                        height: 150.w,
                                        alignment: Alignment.topCenter,
                                        fit: BoxFit.cover,
                                        // placeholder: (context, url) => CircularProgressIndicator(),
                                        imageUrl: widget.worker.imageURL,
                                      ),
                                    )
                                  : new Container(
                                      width: 150.w,
                                      height: 150.w,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "res/images/pfofil1.png",
                                            ), // picked file
                                            fit: BoxFit.fill),
                                      )),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 50.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "fullname".tr().toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Styles().fontSize_name,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      " ${widget.worker.name} ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: Styles().fontSize_name,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "phone_number".tr().toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Styles().fontSize_name,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      " ${widget.worker.phone_number} ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: Styles().fontSize_name,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "salaire".tr().toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Styles().fontSize_name,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    adapter_currency(
                                      context,
                                      widget.worker.salery,
                                      Colors.grey,
                                      Styles().fontSize_price,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "salaire_type".tr().toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Styles().fontSize_name,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      "salaire1".tr().toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: Styles().fontSize_name,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                              ],
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Color(0xFF69ADFC),
                              child: Container(
                                alignment: Alignment.center,
                                // width: 90,
                                height: 80.h,
                                child: Text(
                                  "edite_info".tr().toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Styles().fontSize_name,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  edite = true;
                                });
                                // if (_formKey.currentState.validate()) {
                                //   // Navigator.of(context).pop();
                                //   // Navigator.pushNamed(context, '/add_operation');
                                // }
                              },
                            ),
                          ],
                        ),
                      ),
                ////
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future Open_WorkerSettingAlert(BuildContext context, Worker worker) async {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Show_info(
      worker: worker,
    ),
  );

  // show the dialog
  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class Edite_Info extends StatefulWidget {
  Worker worker;
  Edite_Info({@required this.worker});

  @override
  _Edite_InfoState createState() => _Edite_InfoState();
}

class _Edite_InfoState extends State<Edite_Info> {
  String _currentlan = "salaire1".tr().toString();
  void changedDropDownItem(String selectedlan) {
    setState(() {
      _currentlan = selectedlan;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(new DropdownMenuItem(
      value: "salaire1".tr().toString(),
      child: new Text("salaire1".tr().toString()),
      onTap: () {
        // setState(() {
        //   EasyLocalization.of(context).locale = Locale("ar", "SA");
        // });
      },
    ));
    items.add(new DropdownMenuItem(
      value: "salaire2".tr().toString(),
      child: new Text("salaire2".tr().toString()),
      onTap: () {
        // setState(() {
        //   EasyLocalization.of(context).locale = Locale("en", "US");
        // });
      },
    ));
    return items;
  }

/////////
  File _image;
  String _uploadedFileURL, _full_name, _phone_number;
  double _salary;
  bool _choseimage = false;
  bool _with_commesion = true;
  bool saving = false;

  Future uploadFile(BuildContext context) async {
    Progress progress = Progress();
    progress.OnProgress(context, true);
    saving = true;
    if (_choseimage == false) {
      print('_choseimage ${_choseimage}');

      Worker worker = Worker(
          with_comission: _with_commesion,
          name: _full_name,
          salery: _salary,
          phone_number: _phone_number,
          imageURL: widget.worker.imageURL);

      Workers_provider workers_provider = Workers_provider();
      workers_provider.updateWroker(worker, widget.worker, false);
      progress.cancelTimer();
      Navigator.pop(context);
    } else {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('workers/${Path.basename(_image.path)}}');
      // UploadTask uploadTask =
      await storageReference.putFile(_image).then((doc) => doc != null
          ? print('File Uploaded ${doc.toString()}')
          : print('error Uploaded'));
      // await uploadTask.onComplete;
      // print('File Uploaded');
      await storageReference.getDownloadURL().then((fileURL) async {
        setState(() {
          _uploadedFileURL = fileURL;
          print('File Uploaded url ${_uploadedFileURL.toString()}');

          Worker worker = Worker(
              name: _full_name,
              salery: _salary,
              phone_number: _phone_number,
              imageURL: _uploadedFileURL);

          Workers_provider workers_provider = Workers_provider();

          workers_provider.updateWroker(worker, widget.worker, true);

          progress.cancelTimer();
          Navigator.pop(context);
        });
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _with_commesion = widget.worker.with_comission;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.worker.imageURL != null && _image == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10000.0),
                        child: CachedNetworkImage(
                          height: 150.w,
                          width: 150.w,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          imageUrl: widget.worker.imageURL,
                        ),
                      )
                    : new Container(
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
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: _with_commesion ? Colors.blue : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: _with_commesion ? Colors.blue : Colors.grey,
                        width: 1),
                  ),
                  child: Center(
                    child: IconButton(
                        icon: Icon(
                          Icons.check,
                          color: _with_commesion ? Colors.white : Colors.grey,
                          size: 20.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            _with_commesion = !_with_commesion;
                          });
                        }),
                  ),
                ),
                Text(
                  "comission".tr().toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Styles().fontSize_name,
                    fontWeight: FontWeight.normal,
                    color: _with_commesion ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: TextFormField(
                initialValue: widget.worker.name,
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
              initialValue: widget.worker.phone_number,
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
              initialValue: widget.worker.salery.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return "salaire".tr().toString();
                } else {
                  _salary = double.parse(value);
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                labelText: "salaire".tr().toString(),
                labelStyle: Styles().textStyle_labelstyle,

                // labelText: "name".tr().toString(),
              ),
              onChanged: (value) {},
            ),
            SizedBox(
              height: 20.h,
            ),
            // Container(
            //   padding: EdgeInsets.all(8.w),
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
