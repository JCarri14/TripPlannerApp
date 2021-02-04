import 'package:flutter/material.dart';
import 'package:trip_planner_app/pages/trip_form_screen.dart';
import 'package:trip_planner_app/pages/trip_list_page.dart';
import 'package:trip_planner_app/pages/trip.dart';
import '../widgets/custom_shape.dart';

import '../widgets/main_drawer.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      drawer: MainDrawer(),
      body: SafeArea(
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
                    SizedBox(height: 0,),
                    InkWell(
                        onTap: () { print("OnTap works");},
                        child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16, horizontal:52),
                        child: Material(
                          elevation: 8.0,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                suffixIcon: Icon(Icons.search),
                                hintText: "Search destination",
                                border: InputBorder.none
                              ),
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
