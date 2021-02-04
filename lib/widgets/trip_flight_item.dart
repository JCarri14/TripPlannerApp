import 'package:flutter/material.dart';

class TripFlightItem extends StatelessWidget {
  
  final String title;
  final String content;
  final IconData icon;

  TripFlightItem({this.title, this.content, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: double.maxFinite, child: Text(this.title, style: TextStyle(color: Colors.black87, fontSize: 14))),
        SizedBox(height: 2),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Icon(this.icon, size: 16)
              ),
              SizedBox(width: 8,),
              Text(this.content),
            ],
          )
        )
      ],
    );
  }
}