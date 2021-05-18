import 'package:flutter/material.dart';

class ItemCarousel extends StatelessWidget {

  final dynamic item;
  final int index;
  final Function onTapHandler;

  ItemCarousel({this.index, this.item, this.onTapHandler});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.onTapHandler(index),
      child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 8.0,
          child: Column(children: [
            Text(item.title),
            Text(item.subtitle)
          ],),
        ),
    );     
  }
}