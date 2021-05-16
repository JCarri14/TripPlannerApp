import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../../../config/routes/routes.dart";
import "../../widgets/containers/base_scrollable_container.dart";
import "./home_header.dart";
import "./home_body.dart";

class HomePage extends StatelessWidget {
  
  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      //drawer: MainDrawer(),
      body: BaseScrollableContainer(
        child: Column(
            children: [
              HomeHeader(),
              SizedBox(height: 16,),
              HomeBody(),
              ],
            ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(tripCreationRoute);
        },
      ),
    );
  }
}
