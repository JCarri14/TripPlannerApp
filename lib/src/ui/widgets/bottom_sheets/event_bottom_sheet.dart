import 'package:flutter/material.dart';

void showEventBottomSheet(ctx, Widget content) {
  showModalBottomSheet(context: ctx, builder: (BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )
      ),
      child: SingleChildScrollView(
        child: Container(
          child: content
        )
      ),
    );
  });
}