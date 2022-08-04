import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pqrf_coonfie/providers/providers.dart';
import 'package:provider/provider.dart';

class PositiveResult extends StatelessWidget {
  const PositiveResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String filingNumberAnswer =
        Provider.of<PQRSFProvider>(context).filingNumberAnswer;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                filingNumberAnswer,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: filingNumberAnswer));
                },
                icon: const Icon(Icons.copy_rounded),
                tooltip: 'Aquí puedes copiar el número de radicado',
              ),
            ],
          )
        ],
      ),
    );
  }
}
