import 'package:flutter/material.dart';

import '../widgets/list-items/trip_flight_item.dart';
import '../widgets/list-items/event_list_item.dart';

class TripResume extends StatelessWidget {
  static const routeName = '/trip-resume';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.blue),
        title: Text('Trip Resume', style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.white
        //shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.blue.shade100),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Flight', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ),
                SizedBox(height: 8),
                PhysicalModel(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent,
                  shadowColor: Colors.black,
                  elevation: 4.0,
                  child: Container(
                    //height: 200,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.flight_takeoff, color: Colors.blue,)
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Origen', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                  Text('San Francisco', overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('SFO', textAlign: TextAlign.end, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
                          ],
                        ),
                        SizedBox(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.swap_vert, color: Colors.blue)),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.flight_land, color: Colors.blue,)
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Destino', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                Text('New york', overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              ],
                            ),
                            Expanded(
                              child: Text('NYC', textAlign: TextAlign.end, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: TripFlightItem(title: 'Departure', content: '22 Oct, 2021', icon: Icons.calendar_today)),
                        SizedBox(width: 16),
                        Expanded(child: TripFlightItem(title: 'Return', content: '27 Oct, 2021', icon: Icons.calendar_today)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: TripFlightItem(title: 'Passengers', content: 'x1 Adult(s)', icon: Icons.people)),
                        SizedBox(width: 16),
                        Expanded(child: TripFlightItem(title: 'Cost', content: '100 €', icon: Icons.attach_money)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Hotel', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ),
                SizedBox(height: 8),
                PhysicalModel(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent,
                  shadowColor: Colors.black,
                  elevation: 4.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Icon(Icons.hotel, color: Colors.blue,)
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hotel name hotel name hotel name', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text('street name, number', overflow: TextOverflow.ellipsis, style: TextStyle())
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: Column(children: [
                              Align(alignment: Alignment.centerRight, child: Text('100€', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                              Align(alignment: Alignment.centerRight, child: Text('per pers', style: TextStyle(fontSize: 12, color: Colors.grey))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Events', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ),
                SizedBox(height: 4),
                EventListTile(title: 'Event title', subtitle: 'Street name, number', price: 50),
                EventListTile(title: 'Event title', subtitle: 'Street name, number', price: 50),
                EventListTile(title: 'Event title', subtitle: 'Street name, number', price: 50),                
              ],
            ),
          )
        )
      )
    );
  }
}