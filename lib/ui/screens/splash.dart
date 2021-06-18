import 'package:flutter/material.dart';

import 'package:service_app/ui/widget/onBoarding/onboardingscreen.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Saplash extends StatefulWidget {
  @override
  _SaplashState createState() => _SaplashState();
}

class _SaplashState extends State<Saplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
// Here you can write your code

      setState(() {
        hasFinishedOnBoarding(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF021F44),
              Color(0xFF021F44),
              Color(0xFF021F44),
              Color(0xFF021F44),
            ],
            // transform: GradientRotation(4),
          ),
        ),
        child: Center(
          child: Image(
            image: AssetImage("res/images/logo_white.png"),
          ),
        ),
      ),
    );
    //  Center(
    //   child: SplashScreen(
    //       seconds: 5,
    //       navigateAfterSeconds: OnBoardingScreen(), // hasFinishedOnBoarding(),
    //       // title: new Text(
    //       //   'Welcome In washing car app',
    //       //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    //       // ),
    //       image: Image(
    //         image: AssetImage("res/images/logo.png"),
    //       ),

    //       //new Image.network('https://i.imgur.com/TyCSG9A.png'),
    //       // backgroundColor: Colors.white,
    //       gradientBackground: Gradient(
    //         transform: GradientTransform(),
    //        stops: <double>[200,300,500],
    //                     colors: <Color>[
    //                       Colors.blue[100],
    //                       Colors.blue[200],
    //                       Colors.blue[300],
    //                       Colors.blue[500]
    //                     ],
    //                     // transform: GradientRotation(4),
    //                   ),
    //       ),

    //       // styleTextUnderTheLoader: new TextStyle(),
    //       photoSize: 150.sp,
    //       // onClick: () => print("Flutter Egypt"),
    //       loaderColor: Colors.white),
    // );
  }
}
