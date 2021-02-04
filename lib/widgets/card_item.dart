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
        width: 200,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 3.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Image.network(
                    'https://static.toiimg.com/thumb/66440952/road-trip.jpg?width=1200&height=900',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                    title: Text(
                      this.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(this.subtitle)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}