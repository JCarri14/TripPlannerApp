import 'package:flutter/material.dart';
import 'package:trip_planner_app/pages/search/flight_arguments.dart';

import '../../api/api_response.dart';
import '../../widgets/flight_card.dart';
import '../../widgets/card_item.dart';

class FlightSearch extends StatelessWidget {
  static const routeName = '/flight-search';

  FlightSearch();

  @override
  Widget build(BuildContext context) {
    final FlightArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Airport Selection'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            SizedBox(height: 8,),
            Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(8),
              child: ListTile(
                title: Text('Barcelona Airport'),
                subtitle: args.isOrigin ? Text('Origin'):Text('Destination'),
                trailing: Icon(args.isOrigin ? Icons.flight_takeoff:Icons.flight_land),
              )
            ),
            SizedBox(height: 16,),
            Expanded(
              child: StreamBuilder(
                stream: null,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return Text('Loading data...');
                      case Status.COMPLETED:
                        List flights = [];
                        //List<Flight> flights = snapshot.data.data ?? [];
                        return ListView.builder(
                          itemCount: flights.length,
                          itemBuilder: (_, i) {
                            return FlightCard();
                          },
                        );
                      case Status.ERROR:
                        return Text('Error while fetching...');
                    }
                  }
                  return Container(
                    child: Center(
                      child: Text("No data received"),
                    )
                  );
                },),
            ),
            Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Expanded(
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Text("Continuar")),
                )
            ),
          ],),
        ),
      ),
    );
  }
}