import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/carousel_item.dart';

import '../../widgets/carousels/carousel.dart';
import '../../widgets/bottom_sheets/event_bottom_sheet.dart';
import '../events/category_selector.dart';

//PROVIDERS
import '../../../business_logic/providers.dart';

//MODELS
import '../../../business_logic/models.dart';

class TripEventsCarousel extends StatefulWidget {
  @override
  _TripEventsCarouselState createState() => _TripEventsCarouselState();
}

class _TripEventsCarouselState extends State<TripEventsCarousel> {

  // NETWORKING & STATE
  TripCreationProvider tripManager;
  EventProvider eventProvider;
  double cityLat;
  double cityLong;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripCreationProvider>(context);

    List<Event> events = tripManager.events;
    
    Widget eventsContent;

    if (events.length > 0) {
      eventsContent = CustomCarousel(
        infiniteScroll: false,
        items: events.map((e) {
          return CarouselItem(title: e.name, subtitle: e.category, isSelected: true);
        }).toList(),
        onTapHandler: (idx) { showEventBottomSheet(context, events[idx]);},
        onPageChanged: (idx) {},
      );
    } else {
      eventsContent = Container(
        child: Center(child: Text("No events selected"),)
      );
    }

    return Container(
      child: eventsContent
    );
  }
}