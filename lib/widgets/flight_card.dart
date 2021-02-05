import 'package:flutter/material.dart';

import '../models/flight/flight.dart';

class FlightCard extends StatelessWidget {

  final Flight flight;

  FlightCard({this.flight});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { print("Card tapped");},
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        shadowColor: Colors.black,
        elevation: 8.0,
        child: Container(
          //height: 180,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("NYC", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: SizedBox(
                    height: 8, 
                    width: 8, 
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(10)
                      )
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Transform.rotate(child: Icon(Icons.local_airport), angle: 1.5,)
                  )
                ),
                Container(
                  margin: EdgeInsets.only(right: 4),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: SizedBox(
                    height: 8, 
                    width: 8, 
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(10)
                      )
                    )
                  ),
                ),
                Text("SFO", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 100, child: Text("New York", style: TextStyle(fontSize: 12, color: Colors.grey))),
                SizedBox(width: 100, child: Text("San Francisco", textAlign: TextAlign.end, style: TextStyle(fontSize: 12, color: Colors.grey))),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("08:00 AM", style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold)),
                Expanded(child: Text("1 May 2021", style: TextStyle(fontSize: 16, color: Colors.black54), textAlign: TextAlign.center,),),
                Text("02:30 PM", style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.flight_takeoff, color: Colors.blue.shade400)
                ),
                SizedBox(width: 16,),
                Text("Airbus", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                Expanded(child: Text("100 €", textAlign: TextAlign.end, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54))),
              ],
            ),
            ],
          )
        ),
      ),
    );
  }
}