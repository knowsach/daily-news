import 'package:flutter/material.dart';
import 'package:tasks_status_architecture/routes/route_names.dart';
import 'package:tasks_status_architecture/screens/home.dart';

class SetupRoutes {
  static String initialRoute = Routes.HOME;
  static String currentAtSign;
  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.HOME: (context) => Home(),
    };
  }

  static Future push(BuildContext context, String value,
      {Object arguments, Function callbackAfterNavigation}) {
    return Navigator.of(context)
        .pushNamed(value, arguments: arguments)
        .then((response) {
      if (callbackAfterNavigation != null) {
        callbackAfterNavigation();
      }
    });
  }

  static replace(BuildContext context, String value,
      {dynamic arguments, Function callbackAfterNavigation}) {
    Navigator.of(context)
        .pushReplacementNamed(value, arguments: arguments)
        .then((response) {
      if (callbackAfterNavigation != null) {
        callbackAfterNavigation();
      }
    });
  }

  static pushAndRemoveAll(BuildContext context, String value,
      {dynamic arguments, Function callbackAfterNavigation}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(
      value,
      (_) => false,
      arguments: arguments,
    )
        .then((response) {
      if (callbackAfterNavigation != null) {
        callbackAfterNavigation();
      }
    });
  }
}
