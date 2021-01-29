import 'package:flutter/material.dart';

class LocationForm extends StatefulWidget {
  @override
  _LocationFormState createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Choose Location'),
        ),
        body: SafeArea(
            child: Column(children: [
          Expanded(
              flex: 8,
              child: Form(
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            
                          ])))))
        ])));
  }
}

/*
onChanged: (value) => async {
                              if (value.length > 0) {
                                
                              }
                              */
