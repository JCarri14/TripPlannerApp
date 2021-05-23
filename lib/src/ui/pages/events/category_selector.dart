import "package:flutter/material.dart";
import 'package:provider/provider.dart';

//MODELS
import "../../../business_logic/models.dart";

//PROVIDERS
import "../../../business_logic/providers.dart";


class EventCategorySelector extends StatefulWidget {
  
  EventCategorySelector({Key key}): super(key: key);

  @override
  _EventCategorySelectorState createState() => _EventCategorySelectorState();
}

class _EventCategorySelectorState extends State<EventCategorySelector> {
  
  EventProvider eventProvider;
  List<DropdownMenuItem> menuCategories = [];
  bool categoriesInit = false;

  handleCategoryChange(value) {
    eventProvider.setCurrentCategory(value);
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(context);

    if (!categoriesInit) {
      categoriesInit = true;
      categories.forEach((key, value) {
        menuCategories.add(DropdownMenuItem(
          value: value,
          child: Text(value)
        ));
      });
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).primaryColor
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          iconSize: 36,
          iconDisabledColor: Theme.of(context).primaryColorDark,
          iconEnabledColor: Theme.of(context).primaryColor,
          menuMaxHeight: 300,
          dropdownColor: Colors.white,
          isExpanded: true,
          hint: Text('Categories'), 
          value: eventProvider.currentCategory,
          onChanged: handleCategoryChange,
          items: menuCategories
        )
      ),            
    );
  }
}