import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:moneytextformfield/moneytextformfield.dart';

class TripFormScreen extends StatefulWidget {
  static const routeName = '/new-trip';
  TripFormScreen({Key key}) : super(key: key);

  @override
  _TripFormScreenState createState() => _TripFormScreenState();
}

class _TripFormScreenState extends State<TripFormScreen> {
  TextEditingController mycontroller = TextEditingController();

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Trip'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Form(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 4, bottom: 16),
                          child: Text('Where do you want to travel?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            onTap: ,
                            decoration: InputDecoration(
                                icon: Icon(Icons.home),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                labelText: 'From',
                                hintText: 'Enter a city...'),
                            onFieldSubmitted: (_) {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.airplanemode_active),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                labelText: 'To',
                                hintText: 'Enter a city...'),
                            onFieldSubmitted: (_) {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text('When do you plan to travel?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 4, bottom: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Text(selectedDate.toString()),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () =>
                                        _selectDate(context), // Refer step 3
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 4, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "To",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Text(selectedDate.toString()),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () =>
                                        _selectDate(context), // Refer step 3
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text('How much would you like to spend?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                            width: double.infinity,
                            child: MoneyTextFormField(
                                settings: MoneyTextFormFieldSettings(
                                    moneyFormatSettings: MoneyFormatSettings(
                                        currencySymbol: "€",
                                        thousandSeparator: '.',
                                        decimalSeparator: ',',
                                        displayFormat:
                                            MoneyDisplayFormat.symbolOnRight,
                                        amount: 0,
                                        fractionDigits: 0),
                                    controller: mycontroller,
                                    appearanceSettings: AppearanceSettings(
                                      labelText: 'Euro Format',
                                    )))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FlatButton(
                        child: Text('Cancel',
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FlatButton(
                        child: Text('Continue'),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {},
                      ),
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
