import 'package:flutter/material.dart';

import '../../models/hotel/hotel.dart';

class CardItem extends StatelessWidget {

  final Hotel hotel;

  CardItem({this.hotel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: this.hotel.thumbnailUrl != null ? Image.network(this.hotel.thumbnailUrl):Icon(Icons.hotel)
          ),
          title: Text(
            this.hotel.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(this.hotel.address, overflow: TextOverflow.ellipsis,),
          trailing: Row(children: [
            Column(children: [
              Icon(Icons.attach_money),
              Text(this.hotel.pricePerNight.toString() + "€")
            ],),
            Column(children: [
              Icon(Icons.star),
              Text(this.hotel.starRating.toString())
            ],),
          ],
        ),
      ),
      ),
    );
  }
}