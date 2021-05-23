import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//TIMER
import '../../../utils/load_fetch_timer.dart';

//PROVIDERS
import "../../../business_logic/providers.dart";

//MODELS
import "../../../business_logic/models.dart";

//ROUTES
import "../../../config/routes/routes.dart";

//DRAGGABLES
import '../../widgets/draggables/events_draggable.dart';


class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  TripCreationProvider tripManager;
  EventProvider eventProvider;

  LoadFetchTimer loadFetchTimer = new LoadFetchTimer();
  final String mapBoxToken = env['API_TOKEN_MAPBOX'];
  final String mapBoxUrl = env['API_URL_TEMPL_MAPBOX'];

  final MapController _mapController = MapController();
  List<Marker> markers;
  double _mapZoom;
  LatLng _cityCenter;
  LatLng _currPoint;

  @override
  void initState() {
    super.initState();
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
    tripManager = Provider.of<TripCreationProvider>(context);
    eventProvider = Provider.of<EventProvider>(context);

    _cityCenter = LatLng(tripManager.destinationCity.latitude, tripManager.destinationCity.longitude);
    _currPoint = _cityCenter;

    return Container(
      height: double.infinity,
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
          child: EventsDraggable()
        )
      ],) 
    );
  }
}