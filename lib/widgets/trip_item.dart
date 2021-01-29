import 'package:flutter/material.dart';

class TripItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 3.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
              child: SizedBox(
                height: 140,
                width: 300,
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
                    'Trip title',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('From: dd/mm/yy To: dd/mm/yy')),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8,left: 16, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text('4 days'),
                          ],
                        ),
                        SizedBox(
                              width: 6,
                            ),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                            ),
                            Text('1224'),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
