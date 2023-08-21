import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbloccrud/enums/flavor_enum.dart';
import 'package:flutterbloccrud/presentation/dashboard/dashboard.dart';
import 'package:flutterbloccrud/presentation/sign_in/sign_in.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/product_bloc/product_bloc.dart';
import 'logs/my_logger.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.flavor,
  });

  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      MyLogger.printInfo('CURRENT FLAVOR: ${flavor.description}');
    }

    return DevicePreview(
      enabled: false,
      builder: (context) => MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Container(
                        color: Colors.white,
                        child: Center(
                            child: const SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 50.0,
                        ))),
                  );
                }

                if (snapshot.hasData) {
                  return const DashBoard();
                }

                return const SignIn();
              }),
          // When navigating to the "/second" route, build the SecondScreen widget.
        },
        // home: StreamBuilder<User?>(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (context, snapshot) {
        //       // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.

        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const CircularProgressIndicator();
        //       }
        //       if (snapshot.hasData) {
        //         return const DashBoard();
        //       }

        //       return const SignIn();
        //     }),
        title: '${flavor.title}AFEX Exhibitor',
        debugShowCheckedModeBanner: kDebugMode ? true : false,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          child = ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, child!),
            minWidth: 360,
            defaultName: MOBILE,
            breakpoints: [
              const ResponsiveBreakpoint.resize(360),
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(640, name: 'PHABLET'),
              const ResponsiveBreakpoint.autoScale(850, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1080, name: DESKTOP),
            ],
          );
          child = DevicePreview.appBuilder(context, child);
          return child;
        },
      ),
    );
  }
}
