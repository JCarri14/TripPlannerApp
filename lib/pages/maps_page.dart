import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:trip_planner_app/utils/LoadFetchTimer.dart';

import '../widgets/card_item.dart';


class MapPage extends StatefulWidget {
  static const routeName = '/map';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LoadFetchTimer loadFetchTimer = new LoadFetchTimer();
  String mapBoxToken = env['API_TOKEN_MAPBOX'];
  String mapBoxUrl = env['API_URL_TEMPL_MAPBOX'];

  List listItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String valueChoose;

  double _sliderValue = 30.0;

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
                  minZoom: 17.0
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
              child: DraggableScrollableSheet(
                expand: true,
                initialChildSize: 0.5,
                minChildSize: 0.08,
                maxChildSize: 0.68,
                builder: (_, controller) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16)),
                    ),
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 16),
                          Text('Activities (Day 1)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ListTile(
                          title: Text('Total Budget left:'),
                          trailing: Text('400'),
                        ),   
                        ExpansionTile(
                          title: Text('Filter Cost'),
                          trailing: Icon(Icons.keyboard_arrow_down),
                          children: [
                            Slider(
                              value: _sliderValue,
                              min: 0,
                              max: 100,
                              divisions: 5,
                              label: _sliderValue.round().toString(),
                              onChanged: (value) {
                                //loadFetchTimer.loadTimer(() => dataBloc.fetchCitiesByPrefix(autocompleteValue, 5));
                                setState(() {
                                  _sliderValue = value;
                                });
                              },
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            width: 150,
                                 child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                     hint: Text('Categories'),
                                     value: valueChoose,
                                     onChanged: (newValue) {
                                       setState(() {
                                         valueChoose = newValue;
                                       });
                                     },
                                     items: listItems.map((item) {
                                       return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                       );
                                     }).toList()
                                   ),
                                 ),
                               )
                        ),
                        SizedBox(height: 16),
                        CardItem(title: 'Item 1', subtitle: 'subtitle', imageUrl: '',),
                        SizedBox(height: 16),
                        Container(
                          height: 45,
                          width: double.infinity,
                          child: RaisedButton(
                              onPressed: () {},
                              color: Colors.blue,
                              child: Text('Continue')
                            ),
                        )
                      ]),
                    )                
                  );
                }),
            )
          ],)
        )
      ),
    );
  }
}