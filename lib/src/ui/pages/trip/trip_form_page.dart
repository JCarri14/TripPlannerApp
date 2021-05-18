import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//MODELS
import "../../../ui/widgets/forms/form_field.dart";

//ROUTES
import "../../../config/routes/routes.dart";

//PROVIDERS
import "../../../business_logic/providers.dart";

//SERVICES
import "../../../network/services.dart";

//OTHER
import '../../utils/flight_arguments.dart';


class TripFormPage extends StatefulWidget {
  TripFormPage({Key key}) : super(key: key);

  @override
  _TripForPageState createState() => _TripForPageState();
}

class _TripForPageState extends State<TripFormPage> {
  TextEditingController mycontroller = TextEditingController();
  
  DateTime dstDate = DateTime.now();
  DateTime retDate = DateTime.now();
  TripCreationProvider tripData;
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

    tripData = Provider.of<TripCreationProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('New Trip'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
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
                            child: CustomFormField(
                              title: 'From', 
                              hintText: 'Enter origin...',
                              inputValue: tripData.originCity.toString(), 
                              onTapHandler: () {
                                Navigator.of(context).pushNamed(locationSearchRoute, arguments: true);
                              }
                            )
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: CustomFormField(
                              title: 'To', 
                              inputValue: tripData.destinationCity.toString(), 
                              hintText: 'Enter destination...', 
                              onTapHandler: () {
                                Navigator.of(context).pushNamed(locationSearchRoute, arguments: false);
                              }
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
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                )),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 4, bottom: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      label: Text("From"),
                                      icon: Icon(Icons.calendar_today),
                                      onPressed: () {
                                        _selectDate(context, true);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(100, 38),
                                        primary: Theme.of(context).primaryColorDark
                                      ),
                                    ),
                                    SizedBox(width: 16,),
                                    Text(
                                      dstDate.toString().split(" ")[0],
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColorDark
                                      )
                                    ),
                                 ],
                                ),
                            
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 4, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ConstrainedBox(
                                      constraints: new BoxConstraints(
                                        minWidth: 75.0,
                                      ),
                                      child: ElevatedButton.icon(
                                        label: Text("To"),
                                        icon: Icon(Icons.calendar_today),
                                        onPressed: () {
                                          _selectDate(context, false);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(100, 38),
                                          primary: Theme.of(context).primaryColorDark
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16,),
                                    Text(
                                      retDate.toString().split(" ")[0],
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColorDark
                                      )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          CustomFormField(
                            title: 'How much would you like to spend?',
                            //inputValue: tripData.budget.toString(),
                            onChanged: (value) => tripData.saveBudget(int.parse(value)),
                            inputType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: Text('Continue'),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor
                          ),
                          onPressed: () async {
                            if (_validateForm()) {
                              //tripData.saveBudget(int.parse(mycontroller.text.replaceAll(".", "")));  
                              String res = await new HotelService()
                                .getCityPositionId(context, 
                                  tripData.destinationCity.name, 
                                  tripData.destinationCity.country);

                              tripData.saveDestinationCityId(res);
                              //_formKey.currentState.save();
                              Navigator.of(context).pushNamed(
                                airportSearchRoute, 
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
      ),
    );
  }
}
