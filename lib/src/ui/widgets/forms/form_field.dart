import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "../../../utils/form_validators.dart";

class CustomFormField extends StatefulWidget {
  final String title;
  final String hintText;
  final String initialValue;
  final IconData prefixIcon;
  final TextInputType inputType;
  final bool numericType;
  final bool obscureText;
  final Function(String) validator;
  final Function onChanged;
  final Function onTapHandler;

  CustomFormField({
    this.title = "Input", 
    this.hintText = "Enter value", 
    this.initialValue = "",
    this.prefixIcon,
    this.inputType = TextInputType.name,
    this.numericType = false,
    this.obscureText = false,
    this.validator = baseValidator,
    this.onChanged,
    this.onTapHandler
  });

  @override
  CustomFormFieldState createState() => CustomFormFieldState();
}

class CustomFormFieldState extends State<CustomFormField> {

  final TextEditingController inputController = TextEditingController();

  void _handleInputCallback() {
    widget.onChanged(inputController.text);
  }

  @override
  void initState() {
    super.initState();
    inputController.addListener(_handleInputCallback);
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return widget.onTapHandler != null ? 
    InkWell(
      onTap: widget.onTapHandler,
      child: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                widget.title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                ),),
            ),
            SizedBox(height: 8,),
            Container(
              height: 45,
              child: TextFormField(
                controller: inputController..text = widget.initialValue,
                validator: (value) { return widget.validator(value);},
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon): null,
                  border: OutlineInputBorder(),
                  ),
                keyboardType: widget.inputType,
                onTap: widget.onTapHandler,
              ),
            )
          ],
        ),
      ),
    ):
    Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                widget.title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                ),),
            ),
            SizedBox(height: 8,),
            Container(
              height: 45,
              child: TextFormField(
                controller: inputController..text,
                validator: (value) { return widget.validator(value);},
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon): null,
                  suffixIcon: inputController.text.isEmpty ? 
                    Container(width: 0)
                    : IconButton(
                      icon: Icon(Icons.close, color: Colors.blue,),
                      onPressed: () => inputController.clear(),
                    ),
                  border: OutlineInputBorder(),
                  ),
                keyboardType: widget.inputType,
                inputFormatters: widget.numericType ?[FilteringTextInputFormatter.digitsOnly]:[],
              ),
            )
          ],
        ),
      );
  }
}