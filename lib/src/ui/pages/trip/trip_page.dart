import "package:flutter/material.dart";
import 'package:provider/provider.dart';

//WIDGETS
import "../../widgets/containers/base_scrollable_container.dart";

//PROVIDERS
import "../../../business_logic/providers.dart";


class TripPage extends StatefulWidget {
  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  TripCreationProvider tripManager;

  @override
  Widget build(BuildContext context) {  
    tripManager = Provider.of<TripCreationProvider>(context);

    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text("Trip Page"),
      ),
      body: BaseScrollableContainer(
        child: Column(
          children: [

          ]
        ),
      ),
    );
  }
}