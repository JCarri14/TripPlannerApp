import "package:flutter/material.dart";
import 'package:provider/provider.dart';

//PROVIDERS
import "../../../business_logic/providers.dart";

import "./trips_carousel.dart";
//MODELS

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Your Trips', 
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18, 
              fontWeight: FontWeight.bold)
          )
        ),
        SizedBox(height: 8),
        TripsCarousel(),
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Visited', 
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18, 
              fontWeight: FontWeight.bold)
          )
        ),

      ])
    )
  ;
  }
}