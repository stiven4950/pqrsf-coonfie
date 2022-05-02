import 'package:flutter/material.dart';

class Asociated extends StatefulWidget {
  const Asociated({Key? key}) : super(key: key);

  @override
  State<Asociated> createState() => _AsociatedState();
}

class _AsociatedState extends State<Asociated> {
  List<String> values = ['Sí', 'No'];
  String asociated = 'No';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        ...values.map(
          (c) {
            return SizedBox(
              width: 96,
              child: RadioListTile<String>(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  c,
                  style: TextStyle(fontSize: size.width < 700 ? 9 : 12),
                ),
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
