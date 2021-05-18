import "package:flutter/material.dart";
import '../../../../config/routes/routes.dart';
import "../../../widgets/forms/form_field.dart";
import "../../../../utils/form_validators.dart";

class LoginForm extends StatefulWidget {
  final Function submitCallback;

  LoginForm({this.submitCallback});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomFormField(
              title: "Username", 
              hintText: "Enter name",
              prefixIcon: Icons.person,
              validator: baseValidator,),
          SizedBox(height: 8),
          CustomFormField(
            title: "Password", 
            hintText: "Enter password",
            prefixIcon: Icons.lock,
            obscureText: true,
            validator: baseValidator,
          ),
          SizedBox(height: 16),
          MaterialButton(
            minWidth: double.infinity,
            height: 50,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () {
							if (_formKey.currentState.validate()) {
								widget.submitCallback(context, _formKey.currentState);
							}
						}, 
            child: Text("Login")
          ),
          SizedBox(height: 8),
          MaterialButton(
            minWidth: double.infinity,
            height: 50,
            color: Theme.of(context).primaryColorDark,
            textColor: Colors.white,
            onPressed: () {Navigator.pushNamed(context, registerRoute);}, 
            child: Text("Register")
          ),   
        ],
      ),
    );
  }
}