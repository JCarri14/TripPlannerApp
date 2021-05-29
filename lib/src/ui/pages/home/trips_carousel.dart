import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/carousel_item.dart';
import '../../widgets/carousels/carousel.dart';

//ROUTES
import "../../../config/routes/routes.dart";
import "../../pages.dart";

//PROVIDERS
import '../../../business_logic/providers.dart';

//MODELS
import '../../../business_logic/models.dart';

class TripsCarousel extends StatefulWidget {
  @override
  _TripsCarouselState createState() => _TripsCarouselState();
}

class _TripsCarouselState extends State<TripsCarousel> {

  // NETWORKING & STATE
  AppProvider appProvider;

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
    appProvider = Provider.of<AppProvider>(context);

    List<Trip> trips = appProvider.trips;
    
    Widget eventsContent;

    if (trips.length > 0) {
      eventsContent = CustomCarousel(
        infiniteScroll: false,
        items: trips.map((t) {
          return CarouselItem(
            title: t.originCity.name + "-" + t.destinationCity.name, 
            subtitle: t.destinationDay.toIso8601String().substring(0, 10) + "\n" +
                      t.returnDay.toIso8601String().substring(0, 10), 
            isSelected: false);
        }).toList(),
        onTapHandler: (idx) {
          Navigator.of(context).pushNamed(
            tripRoute,
            arguments: TripPageArguments(
              trip: trips[idx],
              saveMode: false
            )
          );
        },
        onPageChanged: (idx) {},
      );
    } else {
      eventsContent = Container(
        child: Center(child: Text("No events created"),)
      );
    }

    return Container(
      child: eventsContent
    );
  }
}