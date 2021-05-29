import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/carousel_item.dart';

import '../../widgets/carousels/carousel.dart';
import '../../widgets/bottom_sheets/event_details_bottom_sheet.dart';
import "../../pages/events/category_selector.dart";

//PROVIDERS
import "../../../business_logic/providers.dart";

//ROUTES
import "../../../config/routes/routes.dart";
import "../../pages.dart";

//MODELS
import "../../../business_logic/models.dart";

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
  bool didFetch;

  @override
  void initState() {
    super.initState();
    numItems = 5;
    didFetch = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripCreationProvider>(context);
    eventProvider = Provider.of<EventProvider>(context);

    List<Event> events = eventProvider.categoryEvents;
    
    Widget eventsContent;

    if (eventProvider.isLoading) {
      eventsContent = Container(
        child: Center(
          child: Text('Loading'),
        ),
      );
    }
    if (eventProvider.isLoaded) {
      eventsContent = CustomCarousel(
        items: events.map((e) {
          return CarouselItem(title: e.name, subtitle: e.category, isSelected: tripManager.isEventSelected(e));
        }).toList(),
        onTapHandler: (idx) { showEventDetailsBottomSheet(context, events[idx]);},
        onPageChanged: (idx) {},
      );
    }

    if (eventProvider.isError) {
      eventsContent = Container(
        child: Center(child: Text("No items found\nfor this category"),)
      );
    }

    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.55,
      minChildSize: 0.08,
      maxChildSize: 0.55,
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
                Text('Events', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                //Text('Activities (day'+ tripManager.currDay.toString() +')', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),   
                EventCategorySelector(
                  key: Key("EventCategorySelectorMap")
                ),
                SizedBox(height: 8),
                Container(
                  child: eventsContent
                ),
                SizedBox(height: 8,),
                Container(
                  height: 45,
                  width: double.infinity,
                  margin: EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        tripRoute,
                        arguments: TripPageArguments(
                          trip: tripManager.generateTrip(),
                          saveMode: true
                        )
                      );
                    },
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