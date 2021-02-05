import 'package:flutter/material.dart';

class TripPage extends StatefulWidget {
  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {

  List<Step> steps = [
    Step(
      title: const Text(''),
      isActive: true,
      state: StepState.complete,
      content: Container(),
    ),
    Step(
      title: const Text(''),
      isActive: true,
      state: StepState.complete,
      content: Container(),
    ),
    Step(
      title: const Text(''),
      isActive: true,
      state: StepState.complete,
      content: Container(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}