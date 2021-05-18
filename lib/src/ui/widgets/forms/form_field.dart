import "package:flutter/material.dart";
import "../../../utils/form_validators.dart";

class CustomFormField extends StatefulWidget {
  final String title;
  final String hintText;
  final IconData prefixIcon;
  final String inputValue;
  final TextInputType inputType;
  final bool obscureText;
  final Function(String) validator;
  final Function onChanged;
  final Function onTapHandler;

  CustomFormField({
    this.title = "Input", 
    this.hintText = "Enter value", 
    this.prefixIcon,
    this.inputValue = "",
    this.inputType = TextInputType.name,
    this.obscureText = false,
    this.validator = baseValidator,
    this.onChanged,
    this.onTapHandler
  });

  @override
  CustomFormFieldState createState() => CustomFormFieldState();
}

class CustomFormFieldState extends State<CustomFormField> {

  final inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputController.addListener(() => setState(() {}));
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
                controller: inputController..text = widget.inputValue,
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
                onChanged: (value) {
                  widget.onChanged(value);
                  setState(() {
                    print(value);
                    inputController..text = value;
                  });
                },
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
              ),
            )
          ],
        ),
      );
  }
}