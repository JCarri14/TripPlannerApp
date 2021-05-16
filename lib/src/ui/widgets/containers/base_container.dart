import "package:flutter/material.dart";
class BaseContainer extends StatelessWidget {

  final Widget child;

  BaseContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: child
        )
      );
  }
}