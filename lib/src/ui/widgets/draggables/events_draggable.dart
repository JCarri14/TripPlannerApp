import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/carousel_item.dart';

import '../../widgets/carousels/carousel.dart';
import '../../widgets/bottom_sheets/event_bottom_sheet.dart';

//PROVIDERS
import "../../../business_logic/providers.dart";

//MODELS
import "../../../business_logic/models.dart";


//OTHER
import '../../../network/api/api_response.dart';


class EventsDraggable extends StatefulWidget {
  @override
  _EventsDraggableState createState() => _EventsDraggableState();
}

class _EventsDraggableState extends State<EventsDraggable> {

  // NETWORKING & STATE
  TripCreationProvider tripManager;
  EventProvider eventProvider;
  double cityLat;
  double cityLong;
  int numItems;

  // INNER LOGIC
  final List<String> categories = ['Restaurants', 'Shopping', 'Sights', 'Night life',];
  String _valueChoose;
  final Map<String, Function> catFunctions = new Map();
  int currCat;
  bool didFetch;

  @override
  void initState() {
    super.initState();
    currCat = 0;
    numItems = 5;
    didFetch = false;
    _valueChoose = categories[0];
  }

  @override
  void dispose() {
    eventProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripCreationProvider>(context);
    eventProvider = Provider.of<EventProvider>(context);

    cityLat = tripManager.destinationCity.latitude;
    cityLong = tripManager.destinationCity.longitude;
    

    //if (didFetch == null || !didFetch) {
      eventProvider.fetchFreeRestaurantEvents(cityLat.toString(), cityLong.toString(), numItems);
      //didFetch = true;
    //}

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
                Text('Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                //Text('Activities (day'+ tripManager.currDay.toString() +')', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                stream: eventProvider.eventsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Event> events = snapshot.data.data ?? [];

                    switch(snapshot.data.status) {
                      case Status.LOADING:
                        return Container(
                          child: Center(
                            child: Text('Loading'),
                          ),
                        );
                      case Status.COMPLETED:
                        return Container(
                          width: double.infinity,
                          height: 200,
                          child: ListView.builder(
                            itemCount: events.length,
                            itemBuilder: (_, i) {
                              return ListTile(
                                title: Text(events[i].name),
                                subtitle: Text(events[i].id),
                              );
                            },
                          ),
                        );
                        return CustomCarousel(
                          items: events.map((e) {
                            return CarouselItem(title: e.name, subtitle: e.category);
                          }).toList(),
                          onTapHandler: (idx) { showEventBottomSheet(context);},
                          onPageChanged: (idx) {},
                        );
                    }
                  }
                  return Container(
                    child: Center(child: Text("No items found"),)
                  );
                },
              ),
              SizedBox(height: 8,),
              Container(
                height: 45,
                width: double.infinity,
                margin: EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Continue'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor
                  )
                ),
              ),
            ]),
          )                
        );
      }
    );
  }
}