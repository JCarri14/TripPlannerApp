import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/events_bloc.dart';
import './location_search.dart';
import 'search/search_page.dart';
import 'package:trip_planner_app/pages/trip_form_screen.dart';
import '../widgets/custom_shape.dart';

import '../widgets/bottom_sheets/event_bottom_sheet.dart';
import '../widgets/main_drawer.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    EventsBloc eb = Provider.of<EventsBloc>(context);
    BuildContext ctx = context;
    return Scaffold(
      key: scaffoldState,
      drawer: MainDrawer(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: CustomShapeClipper(),
                      child: Container(
                        height: 250.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.blue])
                        ),
                      ),
                    ),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Align(
                          alignment: Alignment.topLeft, 
                          child: IconButton(
                            icon: Icon(Icons.menu), 
                            iconSize: 32,
                            onPressed: () => scaffoldState.currentState.openDrawer(),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Find your next',
                              style: TextStyle(fontSize: 24)),
                              Text(
                              'Destination',
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                      InkWell(
                          onTap: () { 
                            //showHotelBottomSheet(context);
                            //Navigator.of(context).pushNamed(AutoCompleteSearch.routeName);
                          },
                          child: Container(
                            width: 180,
                          //margin: EdgeInsets.symmetric(vertical: 16, horizontal:52),
                          child: Material(
                            elevation: 8.0,
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Search destination'),
                                  SizedBox(width: 8),
                                  Icon(Icons.search, color: Colors.blue)
                                ]
                              ),
                            ),
                          )
                        ),
                      ),
                    ],)
                  ],
                ),
                SizedBox(height: 16,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Popular Destinations', 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      )
                    ),
                    SizedBox(height: 8),
                    Container(),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Visited', 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      )
                    ),

                  ])
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(TripFormScreen.routeName);
        },
      ),
    );
  }
}
