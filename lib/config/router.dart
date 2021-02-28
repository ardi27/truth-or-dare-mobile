
import 'package:flutter/material.dart';
import 'package:truthordare/components/ViewPhoto.dart';
import 'package:truthordare/constants/route_paths.dart' as routes;
import 'package:truthordare/screen/dashboard.dart';

import 'package:truthordare/screen/login_screen/login.dart';
import 'package:truthordare/screen/login_screen/register.dart';
import 'package:truthordare/screen/truth_or_dare/submit_tod.dart';
import 'package:truthordare/screen/truth_or_dare/user_tod.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case routes.homeRoute:
      return MaterialPageRoute(builder: (_)=>Dashboard(initialPage: settings.arguments??0,));
    case routes.loginRoute:
      return MaterialPageRoute(builder: (_)=>Login());
    case routes.submitTodRoute:
      return MaterialPageRoute(builder: (_)=>SubmitTod());
    case routes.registerRoute:
      return MaterialPageRoute(builder: (_)=>Register());
    case routes.userTodRoute:
      return MaterialPageRoute(builder: (_)=>UserTod(index: settings.arguments,));
    case routes.viewPhotoRoute:
      return MaterialPageRoute(builder: (_)=>ViewFoto(foto: settings.arguments,));
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
