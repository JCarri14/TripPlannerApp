import 'package:flutter/material.dart';

//MODELS
import "../../../business_logic/models.dart";

void showHotelBottomSheet(BuildContext ctx, Hotel hotel) {
  showModalBottomSheet(context: ctx, builder: (BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(hotel.name, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                IconButton(
                  icon: Icon(Icons.close), 
                  onPressed: () => Navigator.of(context).pop(),),       
              ],
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(hotel.address, overflow: TextOverflow.ellipsis,),
            ),
            Row(children: [
              Expanded(
                child: ListTile(
                leading: Icon(Icons.star),
                title: Text(hotel.userRating.toString() + " / 10"),
            ),
              ),
            Expanded(
              child: ListTile(
              leading: Icon(Icons.attach_money),
              title: Text(hotel.pricePerNight.toString() + "€ / night"),
              ),
            )
            ],),
            ExpansionTile(
              title: Text('More Details:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              leading: Icon(Icons.info),
              children: hotel.landmarks.map((l) {
                return ListTile(
                  title: Text(l.label + ": " + l.distance),
                );
              }).toList()
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Select'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor
                )
              ),
            ), 
          ],)
      ),
    );
  });
}