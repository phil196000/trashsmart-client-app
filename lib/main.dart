import 'package:flutter/material.dart';
import 'package:trashsmart/Screens/Profile/Profile.dart';
import 'package:trashsmart/Screens/Splash.dart';
import 'package:trashsmart/Screens/market/Market.dart';
// import 'package:tra/core/services/service_locator.dart';
import 'package:trashsmart/app/locator.dart';
import 'Screens/dashboard/dashboard.dart';
import 'Screens/home/home.dart';

void main() {
  // start services
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(17, 105, 57, 1),
        accentColor: Color.fromRGBO(133, 190, 62, 1),
        backgroundColor: Colors.white,

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}
