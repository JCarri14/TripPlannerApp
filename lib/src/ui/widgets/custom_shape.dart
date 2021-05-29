import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);

    var p1 = Offset(size.width * .5, size.height - 35.0);
    var p2 = Offset(size.width * 0.25, size.height - 50.0);
    path.quadraticBezierTo(p2.dx, p2.dy, p1.dx, p1.dy);

    var p3 = Offset(size.width, size.height - 80.0);
    var p4 = Offset(size.width * 0.75, size.height - 10.0);
    path.quadraticBezierTo(p4.dx, p4.dy, p3.dx, p3.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}