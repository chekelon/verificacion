import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      required String helperText,
      required Color colorsborder,
      required double radius,
      IconData? suffixIcon}) {
    return InputDecoration(
      labelText: labelText,
      /*  helperText:
      "(El horometro debe ser mayor que el anterior.)", */
      helperMaxLines: 2,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Colors.red, width: 2.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: colorsborder, width: 2.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: colorsborder, width: 2.5),
      ),
      suffixIcon: suffixIcon != null
          ? Icon(
              suffixIcon,
              color: Colors.black,
            )
          : null,
      filled: false,
      fillColor: Colors.purple.shade100,
    );
  }
}
