import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import '../providers/trip_provider.dart';
import 'package:trip_planner_app/utils/load_fetch_timer.dart';

// FLUTTER MAP
import 'package:flutter_map/flutter_map.dart';

// UI
import '../widgets/cards/card_item.dart';


//MODELS
import '../models/hotel/hotel.dart';

//DRAGGABLES
import '../widgets/draggables/hotel_draggable.dart';
import '../widgets/draggables/events_draggable.dart';


class MapPage extends StatefulWidget {
  static const routeName = '/map';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LoadFetchTimer loadFetchTimer = new LoadFetchTimer();
  final String mapBoxToken = env['API_TOKEN_MAPBOX'];
  final String mapBoxUrl = env['API_URL_TEMPL_MAPBOX'];

  String valueChoose;
  double _sliderValue;

  final MapController _mapController = MapController();
  List<Marker> markers;
  double _mapZoom;
  LatLng _cityCenter;
  LatLng _currPoint;
  TripManager tripManager;

  @override
  void initState() {
    super.initState();
    _sliderValue = 30.0;
    _mapZoom = 13.0;
    markers = [];
  }

  @override
  void dispose() {
    super.dispose();
  }


  void addMarker(double lat, double lng) {
    bool exists = markers.contains((e) {
      if (e.point.latitude == lat && e.point.longitude == lng) return true;
      return false;
    });

    if (!exists) {
      _currPoint = new LatLng(lat, lng);
      //setState(() {
        markers.add(new Marker(
          width: 30.0,
          height: 30.0,
          point: _currPoint,
          builder: (ctx) =>
          new Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Icon(Icons.my_location, color: Colors.white,),
          ),)
        );
      //});
      _mapController.move(_currPoint, _mapZoom);

    }
  }

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripManager>(context);
    bool isHotels = ModalRoute.of(context).settings.arguments;

    _cityCenter = LatLng(tripManager.destinationCity.latitude, tripManager.destinationCity.longitude);
    _currPoint = _cityCenter;

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
                mapController: _mapController,
                options: new MapOptions(
                  center: _cityCenter,
                  minZoom: 5.0,
                  maxZoom: 15.0,
                  zoom: _mapZoom,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: mapBoxUrl,
                    additionalOptions: {
                      'accessToken': mapBoxToken,
                      'id': 'mapbox.mapbox-streets-v7'
                    }
                  ),
                  new MarkerLayerOptions(
                    markers: markers
                  )
                ]
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(right: 8, top: 8),
                child: Column(children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: IconButton(
                      onPressed: () {
                        _mapZoom += 2.5;
                        _mapController.move(_currPoint, _mapZoom);
                      },
                      icon: Icon(Icons.add),),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: IconButton(
                      onPressed: () {
                        _mapZoom -= 2.5;
                        _mapController.move(_currPoint, _mapZoom);
                      },
                      icon: Icon(Icons.remove),),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: IconButton(
                      onPressed: () {
                        _currPoint = _cityCenter;
                        _mapController.move(_currPoint, _mapZoom);
                      },
                      icon: Icon(Icons.my_location),),
                  ),

                ],
                ),
              ),
            ),
            Container(
              child: isHotels ? HotelDraggable(
                onChangeLocation: (Hotel h) => addMarker(h.latitude, h.longitude))
                : EventsDraggable()
            )
          ],)
        )
      ),
    );
  }
}
