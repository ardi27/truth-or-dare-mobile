
import 'package:flutter/material.dart';
import 'package:truthordare/constants/route_paths.dart' as routes;
import 'package:truthordare/screen/dashboard.dart';

import 'package:truthordare/screen/login_screen/login.dart';
import 'package:truthordare/screen/login_screen/register.dart';
import 'package:truthordare/screen/truth_or_dare/user_tod.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case routes.homeRoute:
      return MaterialPageRoute(builder: (context)=>Dashboard());
    case routes.loginRoute:
      return MaterialPageRoute(builder: (context)=>Login());
    case routes.registerRoute:
      return MaterialPageRoute(builder: (context)=>Register());
    case routes.userTodRoute:
      return MaterialPageRoute(builder: (context)=>UserTod(index: settings.arguments,));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
