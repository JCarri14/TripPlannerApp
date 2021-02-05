import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'package:trip_planner_app/pages/trip_form_screen.dart';

// PROVIDERS
import './providers/session.dart';
import './providers/trip_provider.dart';

// PAGES
import './pages/trip_resume.dart';
import './pages/search/flights_search.dart';
import 'pages/unkown_screen.dart';
import 'pages/home_page.dart';
import 'pages/location_search.dart';
import './pages/maps_page.dart';

void main() async {
  await DotEnv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Session()),
        ChangeNotifierProvider(create: (ctx) => TripManager()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TripPlanner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {
          HomePage.routeName: (ctx) => HomePage(),
          LocationSearch.routeName: (ctx) => LocationSearch(),
          FlightSearch.routeName: (ctx) => FlightSearch(),
          TripResume.routeName: (ctx) => TripResume(),
          MapPage.routeName: (ctx) => MapPage(),
          //AutoCompleteSearch.routeName: (ctx) => AutoCompleteSearch(),
          TripFormScreen.routeName: (ctx) => TripFormScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (_) => UnkownPage());
        },
      ),
    );
  }
}
