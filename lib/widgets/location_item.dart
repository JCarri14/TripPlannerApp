import 'package:flutter/material.dart';
import '../models/geo/city.dart';

class LocationItem extends StatelessWidget {
  
  final City city;
  final int index;
  final Function onTapHandler;

  LocationItem({this.city, this.index, this.onTapHandler});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.city.name),
      subtitle: Text(this.city.country),
      onTap: () => onTapHandler(this.index),
    );
  }
}