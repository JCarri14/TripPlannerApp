import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'package:trip_planner_app/pages/trip_form_screen.dart';
import 'pages/unkown_screen.dart';
import 'pages/home_page.dart';

void main() async {
  await DotEnv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TripPlanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        TripFormScreen.routeName: (ctx) => TripFormScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => UnkownPage());
      },
    );
  }
}
