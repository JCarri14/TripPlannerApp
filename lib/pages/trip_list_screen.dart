import 'package:flutter/material.dart';
import '../widgets/trip_item.dart';

class TripListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (ctx, i) => TripItem(),
      ),
    );
  }
}