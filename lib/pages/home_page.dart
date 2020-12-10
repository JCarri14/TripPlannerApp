import 'package:flutter/material.dart';
import 'package:trip_planner_app/pages/trip_list_page.dart';

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
          child: TripListPage(),
        ),
      ),
    );
  }
}
