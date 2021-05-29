import "package:flutter/material.dart";

//MODELS
import '../../../business_logic/models.dart';

class HotelSearchItem extends StatelessWidget {

  final Hotel hotel;
  final bool isSelected;
  final Function onTapHandler;

  HotelSearchItem({
    this.hotel,
    this.isSelected,
    this.onTapHandler
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.onTapHandler(),
      child: Card(
        elevation: 4,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: this.isSelected ? Theme.of(context).primaryColorLight : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        hotel.name, 
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16, 
                          fontWeight: FontWeight.bold))),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        hotel.address,
                        style: TextStyle(
                          color: Colors.black
                        )
                        )
                      )
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: this.isSelected ? Colors.white: Theme.of(context).primaryColor,
                        ),
                        Text(
                          hotel.pricePerNight.toString() + "€",
                          style: TextStyle(
                            color: Colors.black
                          )
                        )
                      ],
                    ),
                    SizedBox(width: 8,),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: this.isSelected ? Colors.white: Theme.of(context).primaryColor,
                        ),
                        Text(
                          hotel.starRating.toString(),
                          style: TextStyle(
                            color: Colors.black
                          )
                        )
                      ],
                    ),
                  ],
                ),
                ],
            )
          ),
      ),//CardItem(hotel: hotel);
    );
  }
}