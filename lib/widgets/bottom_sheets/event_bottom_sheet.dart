import 'package:flutter/material.dart';

Widget showEventBottomSheet(ctx) {
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
        child: Container()
      ),
    );
  });
}