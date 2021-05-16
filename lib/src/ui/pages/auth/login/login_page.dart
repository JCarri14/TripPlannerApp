import "package:flutter/material.dart";
import '../../../../config/routes/routes.dart';
import "../../../widgets/forms/form_field.dart";
import "../../../../utils/form_validators.dart";

class LoginPage extends StatelessWidget {

  void handleFormSubmit(context, data) {
    print(data);
    ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(    
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),      
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "TRIP PLANNER",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Theme.of(context).textTheme.headline4!.fontSize
                      )),
                  ),
                  SizedBox(height: 16),
                  
                  ]
              )
            )
          ),
        )
      ),
    );
  }
}