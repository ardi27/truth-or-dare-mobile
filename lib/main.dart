import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:truthordare/blocs/truth_or_dare/authentication/auth_bloc.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/constants/Dictionary.dart';
import 'package:truthordare/constants/FontsFamily.dart';
import 'package:truthordare/screen/dashboard.dart';
import 'package:truthordare/screen/truth_or_dare/home.dart';
import 'package:truthordare/service_locator.dart';
import 'package:truthordare/utilities/bloc_observer.dart';
import 'package:truthordare/utilities/http.dart';
import 'package:truthordare/utilities/logging_interceptors.dart';
import 'package:truthordare/utilities/navigation_service.dart';
import 'package:truthordare/config/router.dart' as router;
import 'package:truthordare/service_locator.dart' as di;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FlavorConfig(
  //     flavor: Flavor.PRODUCTION,
  //     color: ColorBase.green,
  //     values: FlavorValues(
  //         baseUrl: Environment.baseUrl,
  //         clientId: Environment.clientId,
  //         loginUrl: Environment.loginUrl));
  // init DIO options
  dio.options.connectTimeout = 50000;
  dio.options.receiveTimeout = 50000;
  dio.options.contentType = "application/json";

  // add interceptors
  dio.interceptors.add(LoggingInterceptors());
  await di.init();
  Bloc.observer=SimpleBlocObserver();
  runApp(
    BlocProvider<AuthBloc>(
      create: (BuildContext context) =>sl<AuthBloc>()..add(AppStarted()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return ConnectivityAppWrapper(
      app: MaterialApp(
        title: Dictionary.pikobarTestMasif,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              centerTitle: true,
              brightness: Brightness.dark
            ),
            primaryColor: ColorBase.kPrimaryColor,


            primaryColorBrightness: Brightness.dark,
            fontFamily: FontsFamily.lato),
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigationKey,
        onGenerateRoute: router.generateRoute,
        home: BlocBuilder<AuthBloc,AuthState>(builder:(context,state) {
          return Dashboard();
        }),
        // home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        //     builder: (BuildContext context, AuthenticationState state) {
        //   if (state is AuthenticationAuthenticated) {
        //     // show home page
        //     return EventListPage();
        //   } else if (state is AuthenticationLoading) {
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   } else {
        //     // otherwise show login page
        //     return BottomBar();
        //   }
        // }),
      ),
    );
  }
}
