import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import "./src/app.dart";

void main() async {
  await DotEnv.load();
  runApp(MyApp());
}