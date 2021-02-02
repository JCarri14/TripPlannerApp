import 'package:flutter/material.dart';
import 'package:trip_planner_app/pages/trip_form_screen.dart';
import 'package:trip_planner_app/pages/trip_list_page.dart';
import 'package:trip_planner_app/pages/trip.dart';

import '../widgets/main_drawer.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: Container(
          child: TripFormPage(),
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
