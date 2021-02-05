import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/trip_provider.dart';

class InputFormItem extends StatelessWidget {
  
  final String refTitle;
  final String inputText;
  final String hintText;
  final Function onTapHandler;
  TripManager tripManager;

  InputFormItem({this.refTitle, this.inputText, this.hintText, this.onTapHandler});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTapHandler,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.refTitle,
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onTap: this.onTapHandler,
                maxLines: 1,
                onSaved: (newValue) {
                  
                },
                controller: TextEditingController()..text = this.inputText,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4)),
                    hintText: this.hintText),
                //onFieldSubmitted: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}