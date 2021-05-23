import 'package:flutter/material.dart';

//MODELS
import '../../../business_logic/models.dart';

//WIDGETS
class EventCard extends StatelessWidget {

  final Event event;
  final bool isSelected;
  final Function onTapHandler;

  static defaultTapHandler() {}

  EventCard({
    this.event,
    this.isSelected,
    this.onTapHandler: defaultTapHandler 
  });

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
        onTap: () => this.onTapHandler(),
        child: Card(
          elevation: 4,
          child: Container(
            //height: 180,
            margin: EdgeInsets.symmetric(vertical:4),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: this.isSelected ? Theme.of(context).primaryColorLight : Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          event.ranking.toString(),
                          style: TextStyle(color: Colors.black)
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.star_rate,
                          color: this.isSelected ? Colors.white:Theme.of(context).primaryColor)
                      ],
                    ),
                    SizedBox(width: 8),
                    Row(
                      children: [
                        Text(event.price.toString(),
                          style: TextStyle(color: Colors.black)
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.attach_money,
                          color: this.isSelected ? Colors.white:Theme.of(context).primaryColor)
                      ],
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      );
  }
}