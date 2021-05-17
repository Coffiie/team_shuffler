import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatelessWidget {
  dynamic Function(String) validator;
  TextEditingController controller;
  bool obscureText;
  String labelText;
  Widget suffixIcon;
  String errorText;
  FocusNode focusNode;
  String hintText;
  TextStyle hintStyle;
  TextInputType keyboardType;
  Function(String) onChanged;

  InputWidget(
      {this.keyboardType,
      this.focusNode,
      this.validator,
      this.controller,
      this.obscureText = false,
      this.labelText,
      this.hintText,
      this.hintStyle,
      this.onChanged,
      this.suffixIcon,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: focusNode,
          obscureText: obscureText,
          validator: validator,
          keyboardType: keyboardType,
          controller: controller,
          style: TextStyle(color: Theme.of(context).primaryColor),
          onChanged: onChanged ?? (val) {},
          decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
              hintStyle: hintStyle ?? TextStyle(color: Colors.grey[600]),
              suffixIcon: suffixIcon,
              border: const OutlineInputBorder(),
              labelText: labelText),
        ),
      ],
    );
  }
}
