import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner_app/widgets/carousels/carousel.dart';

// NETWORK
import '../../api/api_response.dart';
import '../../providers/trip_provider.dart';
import '../../blocs/hotel_bloc.dart';
import '../../models/hotel/hotel.dart';

// CAROUSEL
import '../carousels/item_carousel.dart';
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

  // NETWORKING & STATE
  TripManager tripManager;
  HotelBloc hotelBloc;
  // INNER LOGIC
  final List<String> categories = ['Cat 1', 'Cat 2', 'Cat 3', 'Cat 4',];
  double _sliderValue;
  dynamic _valueChoose;

  Function onChangeLocation;
  bool didFetch;

  @override
  void initState() {
    super.initState();
    _sliderValue = 30;
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
      hotelBloc.fetchHotels(context, posId, chckIn, chckOut, '500');
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
                    max: 100,
                    divisions: 5,
                    label: _sliderValue.round().toString(),
                    onChanged: (value) {
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
                            value: _valueChoose,
                            onChanged: (newValue) {
                              setState(() {
                                _valueChoose = newValue;
                              });
                            },
                            items: categories.map((item) {
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