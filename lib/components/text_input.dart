import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String labelText;
  final String prefixText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function onSubmitted;
  final Function onChanged;
  final TextInputAction textInputAction;

  const TextInput({
    Key key,
    this.labelText,
    this.prefixText,
    this.onSubmitted(String s),
    this.onChanged(String s),
    this.focusNode,
    this.controller,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          prefixText: prefixText,
          alignLabelWithHint: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        style: TextStyle(
          color: Colors.amber,
        ),
        onChanged: onChanged,
        textInputAction: textInputAction,
        focusNode: focusNode,
        controller: controller,
        keyboardType: TextInputType.number,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
