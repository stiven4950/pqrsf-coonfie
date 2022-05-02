import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authDecoration({
    required String hintText,
  }) =>
      InputDecoration(
        errorStyle: const TextStyle(fontSize: 9.0),
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.indigo, width: 1.0),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.fromLTRB(15, 13, 10, 13),
        isDense: true,
      );
}
