import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/trip_provider.dart';
import '../../blocs/events_bloc.dart';

class EventsDraggable extends StatefulWidget {
  @override
  _EventsDraggableState createState() => _EventsDraggableState();
}

class _EventsDraggableState extends State<EventsDraggable> {

  TripManager tripManager;
  EventsBloc eventsBloc;
  List<dynamic> categories;
  double _sliderValue = 30;
  dynamic _valueChoose;

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripManager>(context);
    eventsBloc = new EventsBloc();

    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.5,
      minChildSize: 0.08,
      maxChildSize: 0.6,
      builder: (_, controller) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16)),
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 16),
                Text('Activities (day'+ tripManager.currDay.toString() +')', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListTile(
                title: Text('Total Budget left:'),
                trailing: Text('400'),
              ),   
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  width: 150,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('Categories'),
                            value: _valueChoose,
                            onChanged: (newValue) {
                              setState(() {
                                _valueChoose = newValue;
                              });
                            },
                            items: categories.map((item) {
                              return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                              );
                            }).toList()
                          ),
                        ),
                      )
              ),
              SizedBox(height: 16),
              StreamBuilder(
                stream: null,
              ),
              //CardItem(title: 'Item 1', subtitle: 'subtitle', imageUrl: '',),
              SizedBox(height: 16),
              Container(
                height: 45,
                width: double.infinity,
                child: RaisedButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Text('Continue')
                  ),
              )
            ]),
          )                
        );
      }
    );
  }
}