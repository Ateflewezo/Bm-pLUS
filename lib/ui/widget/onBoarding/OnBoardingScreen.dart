import 'dart:io';

import 'package:flutter/material.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../tooles/constants/colors_app.dart' as Constants;

final _currentPageNotifier = ValueNotifier<int>(0);

final List<String> _titlesList = ["تطبيق مغسلة سيارات", "تطبيق مغسلة ملابس"];
String txt1 =
    "يقوم تطبيق مغسله بتسهيل تنظيم خدمات حفظ بيانات عملائك اذا كنت تزور تطبيقنا لاول مره يمكنك التواصل معنا لفتح حساب لشركتك";
String txt2 =
    "تطبيق مغسله يساعدك بالحصول على احصائيات دقيقه حول الخدمات التي تقدمها اذا كنت تزور تطبيقنا لاول مره قم بالتواصل معنا لفتح حساب لشركتك";

final List<String> _subtitlesList = [txt1, txt2];

final List<Image> _imageList = [
  Image(
    width: 750.w,
    height: 350.h,
    fit: BoxFit.fill,
    image: AssetImage("res/images/loading1.png"),
  ),
  Image(
    width: 750.w,
    height: 350.h,
    fit: BoxFit.fill,
    image: AssetImage("res/images/loading2.png"),
  ),
];
final List<Widget> _pages = [];

List<Widget> populatePages(BuildContext context) {
  _pages.clear();
  _titlesList.asMap().forEach((index, value) => _pages.add(getPage(context,
      _imageList.elementAt(index), value, _subtitlesList.elementAt(index))));

  return _pages;
}

final controller = PageController(viewportFraction: 0.8);
Widget _buildSmothIndicator() {
  return SmoothPageIndicator(
    controller: controller,
    count: _pages.length,
    axisDirection: Axis.horizontal,
    effect: ScrollingDotsEffect(
        spacing: 8.0,
        radius: 15.0,
        dotWidth: 30.0,
        dotHeight: 5.0,
        dotColor: Colors.grey,
        activeDotColor: Colors.indigo),
  );
}

Widget getPage(
    BuildContext context, Image image, String title, String subTitle) {
  return Container(
    width: 750.w,
    height: 400.h,
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(80.w),
          child: image,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.all(20.w),
          width: 750.w,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28.sp),
            ),
          ),
        ),
      ],
    ),
  );
}

Future<bool> setFinishedOnBoarding() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool(Constants.FINISHED_ON_BOARDING, true);
}

Future hasFinishedOnBoarding(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool finishedOnBoarding =
      (prefs.getBool(Constants.FINISHED_ON_BOARDING) ?? false);

  if (finishedOnBoarding) {
    Store().hasregistdata(context);
  } else {
    EasyLocalization.of(context).locale = Locale("ar", "SA");
    Navigator.popAndPushNamed(context, "/onboarding");
  }
}

BuildContext _context;

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hasFinishedOnBoarding(context);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Center(
      child: CircularProgressIndicator(backgroundColor: Colors.blue),
    );
  }
}

void launchWhatsApp({
  @required String message,
}) async {
  String phone = '+971522499374';
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
    
     }
     else {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
     
      }
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    throw 'Could not launch ${url()}';
  }
}

_launchURL() async {
  const url = 'http://bmplus.me/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Onboard extends StatefulWidget {
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(20.w),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            height: 800.h,
            width: 750.w,
            child: PageView(
              controller: controller,
              children: populatePages(context),
              onPageChanged: (int index) {
                _currentPageNotifier.value = index;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Align(
              alignment: Alignment.center,
              child: _buildSmothIndicator(),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Color(0xFF13AC97),
                child: Container(
                  alignment: Alignment.center,
                  width: 200.w,
                  height: 50.h,
                  child: Text(
                    "تواصل عبر الواتس آب",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  launchWhatsApp(message: 'hello');
                  // FlutterOpenWhatsapp.sendSingleMessage(
                  //     "918179015345", "Hello");
                },
              ),
              SizedBox(
                width: 1.w,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // side: BorderSide(color: Colors.red),
                ),
                color: Color(0xFF438BE8),
                child: Container(
                  width: 200.w,
                  alignment: Alignment.center,
                  height: 50.h,
                  child: Text(
                    "زيارة موقعنا",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  _launchURL();
                },
              ),
            ],
          ),
          SizedBox(
            height: 50.w,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "هل لديك حساب ؟",
                    style: TextStyle(
                        fontSize: 20.sp,
                        // color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    onPressed: () {
                      setFinishedOnBoarding();
                      Navigator.pushNamed(context, "/login");
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
