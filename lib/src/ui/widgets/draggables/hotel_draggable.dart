import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/load_fetch_timer.dart';

//CAROUSEL
import '../../utils/carousel_item.dart';
import '../../widgets/carousels/carousel.dart';

//PROVIDERS
import "../../../business_logic/providers.dart";

//MODELS
import "../../../business_logic/models.dart";

//ROUTES
import "../../../config/routes/routes.dart";

class HotelDraggable extends StatefulWidget {

  final Function onChangeLocation;

  HotelDraggable({this.onChangeLocation});

  @override
  _HotelDraggableState createState() => _HotelDraggableState();
}

class _HotelDraggableState extends State<HotelDraggable> {
  TripCreationProvider tripManager;
  HotelProvider hotelProvider;

  Function onChangeLocation;
  bool didFetch;

  @override
  void initState() {
    super.initState();
    onChangeLocation = widget.onChangeLocation;
    didFetch = false;
  }

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripCreationProvider>(context);
    hotelProvider = Provider.of<HotelProvider>(context);

    String posId = tripManager.positionId;
    String chckIn = tripManager.destinationDate;
    String chckOut = tripManager.returnDate;

    if (!hotelProvider.isLoaded && !hotelProvider.isLoading) {
      hotelProvider.fetchHotels(context, posId, chckIn, chckOut, '500');
    }

    List<Hotel> hotels = hotelProvider.hotels;
    Widget hotelsContent;

    if (hotelProvider.isLoading) {
      hotelsContent = Container(
        child: Center(
          child: Text('Loading'),
        ),
      );
    }
    if (hotelProvider.isLoaded) {
      hotelsContent = CustomCarousel(
        items: hotels.map((h) {
          return CarouselItem(
            title: h.name, 
            subtitle: h.address, 
            isSelected: hotelProvider.selectedHotel.name == h.name);
        }).toList(),
        onTapHandler: (idx) { hotelProvider.saveSelectedHotel(hotels[idx]);},
        onPageChanged: (idx) {},
      );
    }

    if (hotelProvider.isError) {
      hotelsContent = Container(
        child: Center(child: Text("No items found\nfor this category"),)
      );
    }

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
                SizedBox(height: 16),
                Container(
                  child: hotelsContent
                ),
                SizedBox(height: 8,),
                Container(
                  height: 45,
                  width: double.infinity,
                  margin: EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor
                    ),
                    onPressed: () {
                      tripManager.saveHotel(
                        hotelProvider.selectedHotel
                      );
                      Navigator.of(context).pushNamed(
                        eventSelectionRoute, arguments: false);
                    },
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
