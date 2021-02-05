import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner_app/pages/search/flight_arguments.dart';
import '../widgets/input_form_item.dart';
import './location_search.dart';
import 'search/airport_search.dart';

import '../providers/trip_provider.dart';
import 'package:moneytextformfield/moneytextformfield.dart';

class TripFormScreen extends StatefulWidget {
  static const routeName = '/new-trip';
  TripFormScreen({Key key}) : super(key: key);

  @override
  _TripFormScreenState createState() => _TripFormScreenState();
}

class _TripFormScreenState extends State<TripFormScreen> {
  TextEditingController mycontroller = TextEditingController();
  
  DateTime dstDate = DateTime.now();
  DateTime retDate = DateTime.now();
  TripManager tripData;
  final _formKey = GlobalKey<FormState>();

  _selectDate(BuildContext context, bool isDst) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: isDst ? dstDate:retDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked != null) {
      setState(() {
        if (isDst) {
          dstDate = picked;
          tripData.saveDestinationDay(dstDate);
        } else {
          retDate = picked;
          tripData.saveReturnDay(retDate);
        }   
      });
    }
  }

  bool _validateForm() {
    if (_formKey.currentState.validate()) {
      return true;
    }
    return false;
  }

  void showAlert() {

  }

  @override
  Widget build(BuildContext context) {

    tripData = Provider.of<TripManager>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('New Trip'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: InputFormItem(refTitle: 'From', inputText: tripData.originCity.toString(), hintText: 'Enter origin...', onTapHandler: () {
                            Navigator.of(context).pushNamed(LocationSearch.routeName, arguments: true);
                          })
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: InputFormItem(refTitle: 'To', inputText: tripData.destinationCity.toString(), hintText: 'Enter destination...', onTapHandler: () {
                            Navigator.of(context).pushNamed(LocationSearch.routeName, arguments: false);
                          }),
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
                                  Text(dstDate.toString().split(" ")[0]),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () {
                                       _selectDate(context, true);
                                    }, // Refer step 3
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
                                  Text(retDate.toString().split(" ")[0]),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () {
                                      _selectDate(context, false);
                                    }, // Refer step 3
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
                                    )
                                  )
                                )
                              ),
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
                        onPressed: () {
                          if (_validateForm()) {
                            tripData.saveBudget(int.parse(mycontroller.text.replaceAll(".", "")));  
                            //_formKey.currentState.save();
                            Navigator.of(context).pushNamed(
                              AirportSearch.routeName, 
                              arguments: FlightArguments(
                              isNewTrip: true,
                              isOrigin: true,
                            ));
                          } else {
                            //_show();
                          }
                        },
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
