import 'package:flutter/material.dart';

class InputFormItem extends StatelessWidget {
  
  final String refTitle;
  final String hintText;
  final Function onTapHandler;

  InputFormItem({this.refTitle, this.hintText, this.onTapHandler});

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
                onTap: this.onTapHandler,
                maxLines: 1,
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