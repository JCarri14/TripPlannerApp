import "package:flutter/material.dart";
import 'package:provider/provider.dart';

//PROVIDERS
import "../../../business_logic/providers.dart";

//MODELS
import "../../../business_logic/models.dart";

//ROUTES
import "../../../config/routes/routes.dart";

//WIDGETS
import "./category_selector.dart";
import "../../widgets/bottom_sheets/event_details_bottom_sheet.dart";
import "../../widgets/cards/event_card.dart";

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  // NETWORKING & STATE
  TripCreationProvider tripManager;
  EventProvider eventProvider;

  @override
  Widget build(BuildContext context) {
    tripManager = Provider.of<TripCreationProvider>(context);
    eventProvider = Provider.of<EventProvider>(context);

    List<Widget> listEvents = [];

    if (eventProvider.isLoaded && eventProvider.categoryEvents.length > 0) {
      listEvents = eventProvider.categoryEvents.map((e) {
        return EventCard(
          event: e,
          isSelected: tripManager.isEventSelected(e),
          onTapHandler: () {
            showEventDetailsBottomSheet(
              context,
              e
            );
          }, 
        );
      }).toList();
    }

    return (
      Container(
        height: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
            children: [
              EventCategorySelector(
                key: Key("EventCategorySelector")
              ), 
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: ListView(
                      children: listEvents,
                    ),
                ),
              ),
              SizedBox(height: 16,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  autofocus: false,
                  clipBehavior: Clip.none,
                  child: Text("Continue"),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      tripRoute);
                  },
                )
              ),                
            ],
        ),
      )
    );
  }
}