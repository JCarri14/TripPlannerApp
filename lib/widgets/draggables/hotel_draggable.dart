import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner_app/utils/load_fetch_timer.dart';
import 'package:trip_planner_app/widgets/carousels/carousel.dart';

// NETWORK
import '../../api/api_response.dart';
import '../../providers/trip_provider.dart';
import '../../blocs/hotel_bloc.dart';
import '../../models/hotel/hotel.dart';

// CAROUSEL
import '../../models/ui/carousel_item.dart';

// BOTTOM SHEET
import '../bottom_sheets/hotel_bottom_sheet.dart';

class HotelDraggable extends StatefulWidget {

  final Function onChangeLocation;

  HotelDraggable({this.onChangeLocation});

  @override
  _HotelDraggableState createState() => _HotelDraggableState();
}

class _HotelDraggableState extends State<HotelDraggable> {
  LoadFetchTimer loadFetchTimer;
  // NETWORKING & STATE
  TripManager tripManager;
  HotelBloc hotelBloc;

  // INNER LOGIC
  double _sliderValue;

  Function onChangeLocation;
  bool didFetch;

  @override
  void initState() {
    super.initState();
    _sliderValue = 80;
    onChangeLocation = widget.onChangeLocation;
    hotelBloc = new HotelBloc();
    didFetch = false;
  }

  @override
  Widget build(BuildContext context) {

    tripManager = Provider.of<TripManager>(context);

    String posId = tripManager.positionId;
    String chckIn = tripManager.destinationDate;
    String chckOut = tripManager.returnDate;

    if (didFetch == null || !didFetch)
      hotelBloc.fetchHotels(context, posId, chckIn, chckOut, _sliderValue.toString());
      didFetch = true;

    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.65,
      minChildSize: 0.08,
      maxChildSize: 0.65,
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
                Text('Hotels', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                    max: 300,
                    divisions: 5,
                    label: _sliderValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                      loadFetchTimer.loadTimer(() => hotelBloc.fetchHotels(context, posId, chckIn, chckOut, _sliderValue.toString()));
                    },
                  )
                ],
              ),
              SizedBox(height: 16),
              StreamBuilder(
                stream: hotelBloc.hotelListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Hotel> hotels = snapshot.data.data ?? [];

                    switch(snapshot.data.status) {
                      case Status.LOADING:
                        return Container(
                          child: Center(
                            child: Text('Loading'),
                          ),
                        );
                      case Status.COMPLETED:
                        return CustomCarousel(
                          items: hotels.map((h) {
                            return CarouselItem(title: h.name, subtitle: h.address);
                          }).toList(),
                          onTapHandler: (idx) { showHotelBottomSheet(context, hotels[idx]);},
                          onPageChanged: (idx) { onChangeLocation(hotels[idx]);},
                        );
                    }
                  }
                  return Container();
                },
              ),
              SizedBox(height: 8,),
              Container(
                height: 45,
                width: double.infinity,
                margin: EdgeInsets.all(8),
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {},
                  child: Text('Continue')
                ),
              ),
            ]),
          )
        );
      }
    );
  }
}
