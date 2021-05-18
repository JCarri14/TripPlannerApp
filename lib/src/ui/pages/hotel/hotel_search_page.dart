import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//MODELS
import "../../../business_logic/models.dart";

//PROVIDERS
import "../../../business_logic/providers.dart";

//OTHER
import '../../../network/api/api_response.dart';

class HotelSearchPage extends StatefulWidget {
  @override
  _HotelSearchPageState createState() => _HotelSearchPageState();
}

class _HotelSearchPageState extends State<HotelSearchPage> {
  
  HotelProvider hotelBloc;
  TripCreationProvider tripManager;

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
                    ); //CardItem(hotel: hotels[index]);
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
    tripManager = Provider.of<TripCreationProvider>(context);
    hotelBloc = new HotelProvider();

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