import "package:flutter/material.dart";
class BaseScrollableContainer extends StatelessWidget {

  final Widget child;

  BaseScrollableContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: child
          )
        )
      );
  }
}