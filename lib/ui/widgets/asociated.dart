import 'package:flutter/material.dart';

class Asociated extends StatefulWidget {
  @override
  State<Asociated> createState() => _AsociatedState();
}

class _AsociatedState extends State<Asociated> {
  List<String> values = ['Sí', 'No'];
  String asociated = 'No';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...values.map(
          (c) {
            return SizedBox(
              width: 100,
              child: RadioListTile<String>(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(c),
                groupValue: asociated,
                value: c,
                onChanged: (value) {
                  asociated = value!;
                  setState(() {});
                },
              ),
            );
          },
        ).toList(),
      ],
    );
  }
}
