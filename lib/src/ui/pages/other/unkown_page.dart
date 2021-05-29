import 'package:flutter/material.dart';

class UnkownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('Ooops...')
          ),
        ),
      ),
    );
  }
}