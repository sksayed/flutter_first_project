import 'package:flutter/material.dart';
import 'package:ui_practice/route/route_name.dart';
import 'package:ui_practice/ui/another_page.dart';
import 'package:ui_practice/ui/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case RouteName.anotherpage:
        final arg = routeSettings.arguments;
        if (arg is String) {
          return MaterialPageRoute(
            builder: (buildContext) {
              return AnotherPage(text: arg);
            },
          );
        }
        break;

      case RouteName.initial:
        return MaterialPageRoute(builder: (_) => SplashPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("error page"),
        ),
      );
    });
  }
}
