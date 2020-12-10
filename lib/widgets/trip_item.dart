import 'package:flutter/material.dart';

class TripItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 3.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
              child: SizedBox(
                height: 140,
                width: 120,
                child: Image.network(
                  'https://scoutmytrip.com/blog/wp-content/uploads/2018/05/Road-trip-with-family-Featured-1024x1024.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              height: 140,
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trip title',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'From: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('dd/mm/yy')
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'To: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('dd/mm/yy')
                        ],
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ],
        ),
      ),
    );
  }
}

class TripItemImgTop extends StatelessWidget {
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
                width: double.infinity,
                child: Image.network(
                  'https://scoutmytrip.com/blog/wp-content/uploads/2018/05/Road-trip-with-family-Featured-1024x1024.jpg',
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
