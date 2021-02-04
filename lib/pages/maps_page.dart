import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';


class MapPage extends StatefulWidget {
  static const routeName = '/map';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  String mapBoxToken = env['API_TOKEN_MAPBOX'];
  String mapBoxUrl = env['API_URL_TEMPL_MAPBOX'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Stack(children: [
            Container(
              child: FlutterMap(
                options: new MapOptions(
                  center: new LatLng(-5.95, -35.9258), 
                  minZoom: 12.0
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: mapBoxUrl,
                    additionalOptions: {
                      'accessToken': mapBoxToken,
                      'id': 'mapbox.mapbox-streets-v7'
                    }
                  )
                ]
              ),
            ),
            Container(
              
            )
          ],)
        )
      ),
    );
  }
}