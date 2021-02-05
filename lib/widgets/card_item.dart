import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String subtitle;

  CardItem({this.title, this.subtitle, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 175,
        height: 175,
        child: Material(
          borderRadius: BorderRadius.circular(4),
          elevation: 3.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                child: SizedBox(
                  height: 100,
                  width: 175,
                  child: Image.network(
                    'https://static.toiimg.com/thumb/66440952/road-trip.jpg?width=1200&height=900',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  this.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(this.subtitle, overflow: TextOverflow.ellipsis,)),
            ],
          ),
        ),
      ),
    );
  }
}