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
        hintStyle: const TextStyle(fontSize: 13.0),
        contentPadding: const EdgeInsets.fromLTRB(11, 11, 11, 11),
        isDense: true,
      );
}
