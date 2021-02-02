import 'package:flutter/material.dart';

class LocationList extends StatelessWidget {

  final List<String> items;

  LocationList({this.items}): super();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(), 
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.location_on),
          title: Text(items[index]),
          onTap: () {},
        );
      },
    );
  }
}