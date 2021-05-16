import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// THEME
import "./config/theme/app_themes.dart";

// ROUTES
import "./config/routes/routes.dart";

// PROVIDERS


// PAGES
import "./ui/pages.dart";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TripPlanner',
        theme: AppThemes.lightTheme,
        routes: {
          homeRoute: (ctx) => HomePage(),
          loginRoute: (ctx) => LoginPage(),
          registerRoute: (ctx) => RegisterPage(),
          searchRoute: (ctx) => SearchPage(),
          //LocationSearch.routeName: (ctx) => LocationSearch(),
          //AirportSearch.routeName: (ctx) => AirportSearch(),
          //FlightSearch.routeName: (ctx) => FlightSearch(),
          //HotelSearch.routeName: (ctx) => HotelSearch(),
          //TripResume.routeName: (ctx) => TripResume(),
          //MapPage.routeName: (ctx) => MapPage(),
          //AutoCompleteSearch.routeName: (ctx) => AutoCompleteSearch(),
          //TripFormScreen.routeName: (ctx) => TripFormScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (_) => UnkownPage());
        },
    );

  }
}
