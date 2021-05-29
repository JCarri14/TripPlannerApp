import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// THEME
import "./config/theme/app_themes.dart";

// ROUTES
import "./config/routes/routes.dart";

// PROVIDERS
import "./business_logic/providers.dart";

// PAGES
import "./ui/pages.dart";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => HotelProvider()),
        ChangeNotifierProvider(create: (ctx) => TripCreationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TripPlanner',
        theme: AppThemes.lightTheme,
        routes: {
          homeRoute: (ctx) => HomePage(),
          loginRoute: (ctx) => LoginPage(),
          registerRoute: (ctx) => RegisterPage(),
          tripRoute: (ctx) => TripPage(),
          tripFormRoute: (ctx) => TripFormPage(),
          eventSelectionRoute: (ctx) => EventSelectionPage(),
          flightSearchRoute: (ctx) => FlightSearchPage(),
          hotelSearchRoute: (ctx) => HotelSearchPage(),
          airportSearchRoute: (ctx) => AirportSearchPage(),
          locationSearchRoute: (ctx) => LocationSearchPage(),
          searchRoute: (ctx) => SearchPage(),
          mapRoute: (ctx) => MapPage()
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (_) => UnkownPage());
        },
      ),
    );

  }
}
