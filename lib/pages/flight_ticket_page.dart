import 'package:flutter/material.dart';

import '../api/api_response.dart';

class FlightTicketPage extends StatelessWidget {

  // final hotelBloc = new HotelBloc()

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    return ListTile(
                      title: Text(flights[i].name),
                    );
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
        },)
    );
  }
}