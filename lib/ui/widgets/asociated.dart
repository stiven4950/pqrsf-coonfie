import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/providers/pqrf_provider.dart';
import 'package:provider/provider.dart';

class Asociated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);

    return Row(
      children: [
        ...pqrsfProvider.asociatedValues.map(
          (c) {
            return SizedBox(
              width: 96,
              child: RadioListTile<String>(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  c.key,
                  style: TextStyle(fontSize: size.width < 700 ? 9 : 12),
                ),
                groupValue: pqrsfProvider.asociated,
                value: c.value,
                onChanged: (value) => pqrsfProvider.asociated = value!,
              ),
            );
          },
        ).toList(),
      ],
    );
  }
}
