import 'package:flutter/material.dart';

Widget showHotelBottomSheet(ctx) {
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
                Text('Hotel name', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.close), 
                  onPressed: () => Navigator.of(context).pop(),),       
              ],
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('address', overflow: TextOverflow.ellipsis,),
            ),
            Row(children: [
              Expanded(
                child: ListTile(
                leading: Icon(Icons.star),
                title: Text('rating'),
            ),
              ),
            Expanded(
              child: ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('price'),
              ),
            )
            ],),
            ExpansionTile(
              title: Text('More Details:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              leading: Icon(Icons.info),
              children: [
                ListTile(
                  title: Text('5 min from Aquarium')
                ),
                ListTile(
                  title: Text('5 min from Aquarium')
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {},
                color: Colors.blue,
                child: Text('Select'),
              ),
            ), 
          ],)
      ),
    );
  });
}

Widget showEventBottomSheet(ctx) {
  showModalBottomSheet(context: ctx, builder: (BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )
      ),
      child: SingleChildScrollView(
        child: Container()
      ),
    );
  });
}