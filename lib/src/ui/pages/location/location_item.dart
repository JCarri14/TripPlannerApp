import 'package:flutter/material.dart';
//MODELS
import "../../../business_logic/models.dart";

class LocationItem extends StatelessWidget {
  
  final Object city;
  final int index;
  final Function onTapHandler;

  LocationItem({this.city, this.index, this.onTapHandler});

  @override
  Widget build(BuildContext context) {
    if (city is City) {
      City c = city;
      return ListTile(
        title: Text(c.name),
        subtitle: Text(c.country),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () => onTapHandler(),
      );
    }
    return ListTile(
        title: Text(city),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () => onTapHandler(this.index),
      );
  }
}