import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

//MODELS
import "../../../business_logic/models.dart";

//PROVIDERS
import "../../../business_logic/providers.dart";

//ROUTES
import "../../../config/routes/routes.dart";

//OTHER
import '../../../network/api/api_response.dart';
import "./hotel_search_item.dart";

class HotelSearchPage extends StatefulWidget {
  @override
  _HotelSearchPageState createState() => _HotelSearchPageState();
}

class _HotelSearchPageState extends State<HotelSearchPage> {
  
  HotelProvider hotelProvider;
  TripCreationProvider tripManager;

  //LOGIC
  bool firstFetch = false;
  List<Widget> hotelsList = [];

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripCreationProvider>(context);
    hotelProvider = Provider.of<HotelProvider>(context);

    String posId = tripManager.positionId;
    String chckIn = tripManager.destinationDate;
    String chckOut = tripManager.returnDate;
    
    if (!firstFetch) {
      Timer(Duration(milliseconds: 500), () {
        hotelProvider.fetchHotels(context, posId, chckIn, chckOut, '500');
      });
      setState(() {
        firstFetch = true;
      });
    }

    if (hotelProvider.isLoaded) {
      hotelsList = hotelProvider.hotels.map((h) => 
        HotelSearchItem(
          hotel: h,
          isSelected: hotelProvider.selectedHotel != null ? hotelProvider.selectedHotel.name == h.name:false,
          onTapHandler: () {
            hotelProvider.saveSelectedHotel(h);
          },
        )
      ).toList();
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Search")
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            SizedBox(height: 8,),
            Material(
              elevation: 8.0,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              child: ListTile(
                title: Text('Nothing like a good place to stay!'),
                trailing: Icon(Icons.hotel),
              )
            ),
            SizedBox(height: 16,),
            Expanded(
              child: hotelProvider.isLoaded ?
                ListView.builder(
                  itemCount: hotelsList.length,
                  itemBuilder: (ctx, idx) =>
                    hotelsList[idx]
                  ):
                Container(
                  child: Center(
                    child: Lottie.asset("assets/circle-loader.json"),
                  )
                ),
            ),
            SizedBox(height: 16,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                autofocus: false,
                clipBehavior: Clip.none,
                child: Text("Continue"),
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
              )
            ),
            SizedBox(height: 8,),
          ],)
        )
      )
    );
  }
}