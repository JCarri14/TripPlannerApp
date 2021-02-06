import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'package:trip_planner_app/pages/trip_form_screen.dart';

// PROVIDERS
import './providers/session.dart';
import './providers/trip_provider.dart';

// PAGES
import './pages/trip_resume.dart';
import './pages/search/airport_search.dart';
import './pages/search/flights_search.dart';
import './pages/search/hotel_search.dart';
import 'pages/unkown_screen.dart';
import 'pages/home_page.dart';
import 'pages/location_search.dart';
import './pages/maps_page.dart';

ValueNotifier<GraphQLClient> initializeDB(){
  WidgetsFlutterBinding.ensureInitialized();

  final HttpLink link = HttpLink(
    uri: DotEnv.env['GRAPHQL_URI'],
  );

  return ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );
}

void main() async {
  await DotEnv.load();
  runApp(MyApp(client: initializeDB()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ValueNotifier<GraphQLClient> client;

  const MyApp({Key key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MultiProvider(
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
              AirportSearch.routeName: (ctx) => AirportSearch(),
              FlightSearch.routeName: (ctx) => FlightSearch(),
              HotelSearch.routeName: (ctx) => HotelSearch(),
              TripResume.routeName: (ctx) => TripResume(),
              MapPage.routeName: (ctx) => MapPage(),
              //AutoCompleteSearch.routeName: (ctx) => AutoCompleteSearch(),
              TripFormScreen.routeName: (ctx) => TripFormScreen(),
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(builder: (_) => UnkownPage());
            },
          ),
        ),
      ),
    );

  }
}
