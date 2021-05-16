import "package:flutter/material.dart";
import "../../../utils/form_validators.dart";

class CustomFormField extends StatefulWidget {
  final String title;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType inputType;
  final bool obscureText;
  final Function(String) validator;

  CustomFormField({
    this.title = "Input", 
    this.hintText = "Enter value", 
    this.prefixIcon = Icons.add,
    this.inputType = TextInputType.name,
    this.obscureText = false,
    this.validator = baseValidator});

  @override
  Custom_FormFieldState createState() => Custom_FormFieldState();
}

class Custom_FormFieldState extends State<CustomFormField> {

  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              widget.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5?.fontSize,
              ),),
          ),
          SizedBox(height: 8,),
          TextFormField(
            controller: inputController,
            validator: (value) { return widget.validator(value!);},
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: Icon(widget.prefixIcon),
              suffixIcon: inputController.text.isEmpty ? 
                Container(width: 0)
                : IconButton(
                  icon: Icon(Icons.close, color: Colors.blue,),
                  onPressed: () => inputController.clear(),
                ),
              border: OutlineInputBorder(),
              ),
              keyboardType: widget.inputType,
          )
        ],
      ),
    );
  }
}