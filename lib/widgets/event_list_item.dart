import 'package:flutter/material.dart';

class EventListTile extends StatelessWidget {
  
  final String title;
  final String subtitle;
  final int price;

  EventListTile({this.title, this.subtitle, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        leading: Icon(Icons.event, size: 32, color: Colors.blue),
        title: Text(this.title),
        subtitle: Text(this.subtitle),
        trailing: Text(this.price.toString() + '€', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}