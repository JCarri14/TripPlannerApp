import "package:flutter/material.dart";
import 'package:trip_planner_app/src/config/routes/routes.dart';
import '../../widgets/custom_shape.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 250.0,
            color: Theme.of(context).primaryColor,                        
          ),
        ),
        Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Align(
              alignment: Alignment.topLeft, 
              child: IconButton(
                icon: Icon(Icons.menu), 
                iconSize: 32,
                onPressed: () => {/*scaffoldState.currentState.openDrawer()*/},
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Find your next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24)),
                  Text(
                  'Destination',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28, 
                    fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(height: 16,),
          InkWell(
              onTap: () { 
                //showHotelBottomSheet(context);
                Navigator.of(context).pushNamed(searchRoute);
              },
              child: Container(
                width: 180,
              //margin: EdgeInsets.symmetric(vertical: 16, horizontal:52),
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Search destination'),
                      SizedBox(width: 8),
                      Icon(Icons.search, color: Colors.blue)
                    ]
                  ),
                ),
              )
            ),
          ),
        ],)
      ],
    )
    ;
  }
}