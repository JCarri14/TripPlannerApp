import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//PROVIDERS
import "../../../business_logic/providers.dart";

import "../../../business_logic/models.dart";

void showEventDetailsBottomSheet(ctx, Event event) {
  TripCreationProvider tripManager;

  showModalBottomSheet(context: ctx, builder: (BuildContext context) {
    tripManager = Provider.of<TripCreationProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: Colors.transparent
      ),
      child: Container(
        height: double.infinity,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: Colors.white
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    event.name, 
                    style: TextStyle(
                      color: Colors.black87, 
                      fontSize: 18, 
                      fontWeight: FontWeight.bold))),
                SizedBox(height: 8,),
                Divider(),
                SizedBox(height: 4,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(event.ranking.toString()),
                                SizedBox(width: 4),
                                Icon(Icons.star_rate)
                              ],
                            ),
                            SizedBox(width: 8),
                            Row(
                              children: [
                                Text(event.price.toString()),
                                SizedBox(width: 4),
                                Icon(Icons.attach_money)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 4,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Type",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black
                            )
                          )
                        ),
                        SizedBox(height: 4,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(event.category)
                        ),
                        SizedBox(height: 8,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black
                            )
                          )
                        ),
                        SizedBox(height: 4,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(event.description != "" ? event.description:"No description provided")
                        ),                                              
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  autofocus: false,
                  clipBehavior: Clip.none,
                  child: tripManager.isEventSelected(event) ? Text("Remove from Trip") : Text("Add to Trip"),
                  style: ElevatedButton.styleFrom(
                    primary: tripManager.isEventSelected(event) ? Theme.of(context).errorColor : Theme.of(context).primaryColor
                  ),
                  onPressed: () {
                    if (tripManager.isEventSelected(event)) {
                      tripManager.removeTripEvent(event.id);
                    } else {
                      print("Adding trip");
                      tripManager.addTripEvent(event);
                    }
                  },
                )
              ), 
              ],
            )
        ),
      ),
    );
  });
}