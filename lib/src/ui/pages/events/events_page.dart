import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'dart:async';

//PROVIDERS
import "../../../business_logic/providers.dart";

//MODELS
import "../../../business_logic/models.dart";

//ROUTES
import "../../../config/routes/routes.dart";

import 'list_view_page.dart';

class EventSelectionPage extends StatefulWidget {

  EventSelectionPage();

  @override
  _EventSelectionPageState createState() => _EventSelectionPageState();
}

class _EventSelectionPageState extends State<EventSelectionPage> {
  
  // NETWORKING & STATE
  TripCreationProvider tripManager;
  EventProvider eventProvider;
  String selectedCategory;
  double cityLat;
  double cityLong;
  int numItems;

  // LOGIC
  bool firstFetch = false;

  void fetchEvents(ContentType eventType) {
    eventProvider.fetchEvents(
      eventType: eventType,
      latitude: cityLat.toString(), 
      longitude: cityLong.toString()
    );
  }

  ContentType getCategoryKey(String value) {
    return categories.keys.firstWhere(
    (k) => categories[k] == value, orElse: () => categories.keys.first);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripCreationProvider>(context);
    eventProvider = Provider.of<EventProvider>(context);

    cityLat = tripManager.destinationCity.latitude;
    cityLong = tripManager.destinationCity.longitude;

    String oldCategory = selectedCategory;
    selectedCategory = eventProvider.currentCategory;

    if (!firstFetch || (oldCategory != selectedCategory)) {

      if (!firstFetch) {
        Timer(Duration(seconds: 1), () {
          fetchEvents(getCategoryKey(selectedCategory));
        });
      } else {
        fetchEvents(getCategoryKey(selectedCategory));
      }
      setState(() {
        firstFetch = true;
      });
    }
    
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event Selection'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.list),
                child: Text("List View")
              ),
              Tab(
                icon: Icon(Icons.map),
                child: Text("Map View")
              )
            ])
        ),
        body: SafeArea(
          child: TabBarView (
              children: [
                ListViewPage(),
                Container(
                  child: Center(
                    child: Text("Map View")
                  )
                )
              ],
            ),
        )
      ),
    );
  }
}