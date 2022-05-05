import 'package:flutter/material.dart';

class PositiveResult extends StatelessWidget {
  final String generatedCode = "CAS-654875-1AY589";
  const PositiveResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Número de radicado",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17.0),
          ),
          const SizedBox(height: 10),
          Text(
            generatedCode,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
