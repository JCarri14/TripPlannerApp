import "package:flutter/material.dart";

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Popular Destinations', 
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18, 
              fontWeight: FontWeight.bold)
          )
        ),
        SizedBox(height: 8),
        Container(),
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