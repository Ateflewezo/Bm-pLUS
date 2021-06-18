import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:service_app/ui/screens/worker_operations.dart';
import '../../ui/screens/add_operation.dart';
import '../../ui/screens/add_product_to_operation.dart';
import '../../ui/screens/add_service_to_operation.dart';
import '../../ui/screens/customer_details.dart';
import '../../ui/screens/customers.dart';
import '../../ui/screens/home.dart';
import '../../ui/screens/login.dart';
import '../../ui/screens/new_offers.dart';
import '../../ui/screens/offers.dart';
import '../../ui/screens/operation_details.dart';
import '../../ui/screens/operations.dart';
import '../../ui/screens/products.dart';
import '../../ui/screens/products_details.dart';
import '../../ui/screens/satistics.dart';
import '../../ui/screens/services.dart';
import '../widget/Popups/Store/edite_setting.dart';
import '../../ui/screens/splash.dart';
import '../../ui/screens/user_details.dart';
import '../../ui/screens/users.dart';
import '../../ui/screens/worker_details.dart';
import '../../ui/screens/workers.dart';
import '../widget/onBoarding/onboardingscreen.dart';
import '../../ui/widget/search.dart';

class CustomRouts {
  static Route<dynamic> allRouts(RouteSettings setting) {
    // Handle '/'
    // if (setting.name == '/') {
    //   return MaterialPageRoute(builder: (context) => Home());
    // }
    // if (setting.name == '/products') {
    //   return MaterialPageRoute(builder: (context) => Products());
    // }

    // Handle '/details/:id'
    var uri = Uri.parse(setting.name);
    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'details') {
      var id = uri.pathSegments[1];
      print("id: $id");
      return MaterialPageRoute(builder: (context) => Products_Details(id: id));
    }
// Handle '/worker_details/:id'
    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'worker_details') {
      var id = uri.pathSegments[1];
      print("id: $id");
      return MaterialPageRoute(builder: (context) => Worker_Details(id: id));
    }
    // Handle '/customer_details/:id'
    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'customer_details') {
      var id = uri.pathSegments[1];
      print("id: $id");
      return MaterialPageRoute(builder: (context) => Customer_Details(id: id));
    }

    // Handle '/user_details/:id'
    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'user_details') {
      var id = uri.pathSegments[1];
      print("id: $id");
      return MaterialPageRoute(builder: (context) => User_Details(id: id));
    }
    // Handle '/operation_details/:id'
    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'operation_details') {
      var id = uri.pathSegments[1];
      print("id: $id");
      return MaterialPageRoute(builder: (context) => Operation_Details(id: id));
    }
    // Handle '/operation_add/:id'
    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'add_operation') {
      var id = uri.pathSegments[1];
      print("id: $id");
      return MaterialPageRoute(builder: (context) => Add_operation(id: id));
    }
    // Handle '/operations/:id'
    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'operations') {
      var id = uri.pathSegments[1];
      print("id: $id");
      return MaterialPageRoute(
          builder: (context) => Operations(customer_id: id));
    }

    switch (setting.name) {
      case '/splash':
        return MaterialPageRoute(builder: (context) => Saplash());
        break;
      case '/onboarding':
        return MaterialPageRoute(builder: (context) => Onboard());
        break;
      case '/app_setting':
        return MaterialPageRoute(builder: (context) => Edite_Info());
        break;
      case '/new_offer':
        return MaterialPageRoute(builder: (context) => New_Offers());
        break;
      case '/satistics':
        return MaterialPageRoute(builder: (context) => Satistics());
        break;
      case '/workers':
        return MaterialPageRoute(builder: (context) => Workers());
        break;
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
        break;
      case '/test_onboarding':
        return MaterialPageRoute(builder: (context) => OnBoardingScreen());
        break;
      case '/services':
        return MaterialPageRoute(builder: (context) => Services());
        break;

      case '/users':
        return MaterialPageRoute(builder: (context) => Users());
        break;
      case '/customers':
        return MaterialPageRoute(builder: (context) => Customers());
        break;
      case '/worker_operations':
        return MaterialPageRoute(builder: (context) => Worker_operation());
        break;
      case '/add_service_to_oper':
        return MaterialPageRoute(
            builder: (context) => Add_Service_To_Operation());
        break;
      case '/add_product_to_oper':
        return MaterialPageRoute(
            builder: (context) => Add_Product_To_Operation());
        break;

      case '/search':
        return MaterialPageRoute(builder: (context) => Search());
        break;
      case '/home':
        return MaterialPageRoute(builder: (context) => Home());
        break;
      case '/products':
        return MaterialPageRoute(builder: (context) => Products());
        break;
      case '/offers':
        return MaterialPageRoute(builder: (context) => Offers());
        break;
      default:
        return MaterialPageRoute(builder: (context) => UnknownScreen());
    }
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: CircularProgressIndicator(),
        // Text('404!'),
      ),
    );
  }
}
