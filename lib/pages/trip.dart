import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TripFormPage extends StatefulWidget {
  static const routeName = '/new-trip';
  TripFormPage({Key key}) : super(key: key);

  @override
  _TripFormPageState createState() => _TripFormPageState();
}

class _TripFormPageState extends State<TripFormPage> {
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
    return  Scaffold(
          appBar: AppBar(
        title: const Text('New Trip'),
      ),
          body: Column(
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
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text('Start the journey!',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.start,
                                  ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  margin: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    onTap: () => {},
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.location_city),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4)),
                                        hintText: 'Enter a city...'),
                                    //onFieldSubmitted: (_) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  child: Expanded(
                        child: RaisedButton(
                          child: Text('Continue'),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {},
                        ),
                    ),
                ),
              ),
            ],
        
      ),
    );
  }
}