import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:passwordfield/passwordfield.dart';
import 'package:service_app/control/services/users.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service_app/ui/tooles/passwordfeild.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

String _phone, _password;
bool _show_pw = true;

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // final productProvider = Provider.of<Products>(context);
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                width: 350.w,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("res/images/logintop.png"),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "مرحبا بك مرة أخرى !",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue, fontSize: 35.sp),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "يمكنك تسجيل الدخول باستخدام اسم المستخدم وكلمة المرور",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 25.sp),
                        ),
                        SizedBox(
                          height: 30.sp,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: Center(
                              child: PasswordField(
                                obscureText: false,
                                keybordtype: TextInputType.number,
                                suffixIconEnabled: false,
                                inputStyle: TextStyle(
                                    fontFamily: 'Tajawal',
                                    // color: Colors.black,
                                    fontSize: 25.sp),

                                perffixIcon: Image(
                                  image: AssetImage("res/images/phone.png"),
                                ),
                                color: Colors.blue,
                                hasFloatingPlaceholder: true,
                                floatingText: 'phone_number'.tr().toString(),

                                // pattern: r'.*[@$#.*].*',
                                onSubmit: (value) {
                                  print('phone_number ${value}');
                                  if (value.isEmpty) {
                                    return "phone_number".tr().toString();
                                  } else {
                                    _phone = value;
                                  }
                                },
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue)),
                                errorMessage:
                                    'must contain special character either . * @ # \$',
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: Center(
                              child: PasswordField(
                                inputStyle: TextStyle(
                                    fontFamily: 'Tajawal',
                                    // color: Colors.black,
                                    fontSize: 25.sp),
                                suffixIcon: Image(
                                  image: AssetImage("res/images/eye.png"),
                                ),
                                perffixIcon: Image(
                                  image: AssetImage("res/images/lock.png"),
                                ),
                                color: Colors.blue,
                                hasFloatingPlaceholder: true,
                                floatingText: 'password'.tr().toString(),
                                // pattern: r'.*[@$#.*].*',
                                onSubmit: (value) {
                                  print('password ${value}');
                                  if (value.isEmpty) {
                                    return "password".tr().toString();
                                  } else {
                                    _password = value;
                                  }
                                },
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue)),
                                errorMessage:
                                    'must contain special character either . * @ # \$',
                              ),
                            )),
                        SizedBox(
                          height: 30.sp,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 200.w,
                              height: 200.h,
                              child: Text(
                                "login".tr().toString(),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 30.sp),
                              ),
                            ),
                            Container(
                              width: 60.w,
                              height: 60.w,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: IconButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Users_provider()
                                          .login(_phone, _password, context);
                                    }
                                  },
                                  icon: Center(
                                    child: Icon(Icons.arrow_forward,
                                        size: 20.sp, color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.sp,
                  ),
                  Image(
                    image: AssetImage("res/images/loginbotton.png"),
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
