import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pqrf_coonfie/providers/pqrf_provider.dart';
import 'package:pqrf_coonfie/ui/widgets/sections_widget.dart';
import 'package:pqrf_coonfie/ui/widgets/widgets.dart';

class Consult extends StatelessWidget {
  const Consult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);
    final size = MediaQuery.of(context).size;

    final List<Widget> children = [
      SizedBox(
        width: size.width < 700 ? size.width * .9 : size.width * (1 / 4),
        child: Column(
          children: [
            const Text(
              "Para realizar la consulta es importante que tenga disponible el número de radicación que se informó al momento de realizar su solicitud.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Por favor seleccione el tipo de documento, registre el número de documento y el número de radicación.",
            ),
            const SizedBox(height: 10),
            LabeledSelect(
              data: "Tipo de documento",
              hintText: 'Seleccione...',
              dropdownItems: pqrsfProvider.documentTypeItems,
              selected: '',
              onChanged: (value) {
                pqrsfProvider.documentType = value!;
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
            LabeledWidget(
              'N° de documento',
              hintText: 'Digite su número de documento',
              onChanged: (value) => pqrsfProvider.documentNumber,
              validator: (value) {
                String pattern = pqrsfProvider.regExpDocumentType;
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Formato de documento inválido';
              },
            ),
            LabeledWidget(
              'N° de radicado',
              hintText: 'Digite el número de radicado',
              onChanged: (value) => pqrsfProvider.fullName,
              validator: (value) {
                String pattern = r'\b[a-zA-Z]{3}-\d{6}-[a-zA-Z0-9]{6}\b';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Formato de número inválido';
              },
            ),
            const SizedBox(height: 20),
            GradientButtonExtended(
              text: "Consultar",
              icon: Icons.manage_search_rounded,
              onPressed: () {
                pqrsfProvider.validateForm();
              },
            ),
          ],
        ),
      ),
      SizedBox(
        width: size.width < 700 ? size.width * .9 : size.width * (1 / 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(
              child: const SizedBox(
                height: 50,
                child: Divider(
                  color: Colors.indigo,
                ),
              ),
              visible: size.width < 700,
            ),
            Row(
              mainAxisAlignment: size.width < 700
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/data/images/result.jpg",
                  height: 80.0,
                ),
                const Text(
                  "Respuesta",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const LabeledWidgetReadonly(
              "Número de radicado",
              "CGK-754875-1AY589",
            ),
            const LabeledWidgetReadonly(
              "Nombre del usuario",
              "Omar Stiven Rivera Rocha",
            ),
            const LabeledWidgetReadonly(
              "Número de documento",
              "1083931052",
            ),
            const LabeledWidgetReadonly(
              "Tipo de solicitud",
              "Queja",
            ),
          ],
        ),
      ),
      SizedBox(
        width: size.width < 700 ? size.width * .9 : size.width * (1 / 4),
        child: Column(
          children: [
            Visibility(
              child: const SizedBox(
                height: 90,
              ),
              visible: !(size.width < 700),
            ),
            const LabeledWidgetReadonly(
              "Fecha de radicación",
              "12/03/2022",
            ),
            const LabeledWidgetReadonly(
              "Estado de trámite",
              "Resuelto",
            ),
            const LabeledWidgetReadonly(
              "Fecha de respuesta",
              "04/05/2022",
            ),
            Visibility(
              child: const SizedBox(
                height: 30,
              ),
              visible: !(size.width < 700),
            ),
            GradientButtonExtended(
              text: "Imprimir",
              icon: Icons.print_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ),
    ];
    return SectionsPQRSF(
      children: children,
    );
  }
}
