import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/providers/pqrf_provider.dart';
import 'package:pqrf_coonfie/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Asociated extends StatelessWidget {
  const Asociated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...pqrsfProvider.asociatedValues.map(
          (c) {
            return SizedBox(
              width: ResponsiveWidget.widthInScreen(context, 90, 90, 100, 110),
              child: RadioListTile<String>(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  c.key,
                  style: TextStyle(
                    fontSize:
                        ResponsiveWidget.widthInScreen(context, 10, 10, 11, 12),
                  ),
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
