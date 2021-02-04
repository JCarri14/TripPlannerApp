import 'package:flutter/material.dart';
import 'location_item.dart';

class LocationList extends StatelessWidget {

  final List<Object> items;

  LocationList({this.items}): super();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(), 
      itemCount: items.length,
      itemBuilder: (context, index) {
        return LocationItem(city: items[index], index: index, onTapHandler: (index) {});
      },
    );
  }
}