import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../api/api_response.dart';

import '../../blocs/hotel_bloc.dart';
import '../../models/hotel/hotel.dart';
import '../../widgets/cards/card_item.dart';
import '../../providers/trip_provider.dart';

class HotelSearch extends StatefulWidget {
  static const routeName = '/hote-search';
  @override
  _HotelSearchState createState() => _HotelSearchState();
}

class _HotelSearchState extends State<HotelSearch> {
  
  HotelBloc hotelBloc;
  TripManager tripManager;

  Widget _buildStreamBuilder(BuildContext ctx) {
    return StreamBuilder(
          stream: hotelBloc.hotelListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  )
                );
                case Status.COMPLETED:
                List<Hotel> hotels = snapshot.data.data ?? [];
                return Container(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: hotels.length,
                    itemBuilder: (_, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(),
                      padding: EdgeInsets.all(8),
                        child: Material(
                        elevation: 4.0,
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(hotels[index].name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text(hotels[index].address)
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.attach_money),
                                  Text(hotels[index].pricePerNight.toString() + "€")
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star),
                                  Text(hotels[index].starRating.toString())
                                ],
                              )
                            ],
                          )
                        )
                      ),
                    );//CardItem(hotel: hotels[index]);
                  },)
                );
              }
            }
            return Container();
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripManager>(context);
    hotelBloc = new HotelBloc();

    String posId = tripManager.positionId;
    String chckIn = tripManager.destinationDate;
    String chckOut = tripManager.returnDate;
    
    hotelBloc.fetchHotels(context, posId, chckIn, chckOut, '500');

    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Search")
      ),
      body: SafeArea(
        child: Container(
          child: Column(children: [
            SizedBox(height: 8,),
            Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(8),
              child: ListTile(
                title: Text('Nothing like a good place to stay!'),
                trailing: Icon(Icons.hotel),
              )
            ),
            SizedBox(height: 16,),
            Expanded(
              child: _buildStreamBuilder(context)
            ),
          ],)
        )
      )
    );
  }
}