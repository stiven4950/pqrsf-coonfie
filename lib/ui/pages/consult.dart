import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pqrf_coonfie/ui/widgets/widgets.dart';
import 'package:pqrf_coonfie/providers/providers.dart';

class Consult extends StatelessWidget {
  const Consult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);
    final size = MediaQuery.of(context).size;

    final List<Widget> children = [
      SizedBox(
        width: ResponsiveWidget.widthInScreen(
          context,
          size.width * .9,
          size.width * .3,
          size.width * (1 / 4),
          size.width * (1 / 4),
        ),
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
              selected: pqrsfProvider.documentType,
              onChanged: (value) {
                pqrsfProvider.documentType = value!;
                FocusScope.of(context).requestFocus(FocusNode());
              },
              validator: (value) {
                return value!.isNotEmpty
                    ? null
                    : "Tipo de documento es requerido";
              },
            ),
            LabeledWidget(
              'N° de documento',
              hintText: 'Digite su número de documento',
              initialValue: pqrsfProvider.documentNumber,
              onChanged: (value) => pqrsfProvider.documentNumber = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return "N° de documento es requerido";
                }
                RegExp regExp = RegExp(pqrsfProvider.regExpDocumentType);
                return regExp.hasMatch(value)
                    ? null
                    : 'Formato de documento inválido';
              },
            ),
            LabeledWidget(
              'N° de radicado',
              hintText: 'Digite el número de radicado',
              initialValue: pqrsfProvider.filingNumber,
              onChanged: (value) => pqrsfProvider.filingNumber = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Número de radicado es requerido";
                }
                String pattern = r'^([a-zA-Z]{3}-\d{6}-[a-zA-Z0-9]{6})$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value)
                    ? null
                    : 'Formato de número inválido. Digita los guiones';
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
        width: ResponsiveWidget.widthInScreen(
          context,
          size.width * .9,
          size.width * .3,
          size.width * (1 / 4),
          size.width * (1 / 4),
        ),
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
            LabeledWidgetReadonly(
              "Número de radicado",
              pqrsfProvider.filingNumberAnswer,
            ),
            LabeledWidgetReadonly(
              "Nombre del usuario",
              pqrsfProvider.fullnameAnswer,
            ),
            LabeledWidgetReadonly(
              "Número de documento",
              pqrsfProvider.documentNumberAnswer,
            ),
            LabeledWidgetReadonly(
              "Tipo de solicitud",
              pqrsfProvider.typeRequestAnswer,
            ),
          ],
        ),
      ),
      SizedBox(
        width: ResponsiveWidget.widthInScreen(
          context,
          size.width * .9,
          size.width * .3,
          size.width * (1 / 4),
          size.width * (1 / 4),
        ),
        child: Column(
          children: [
            Visibility(
              child: const SizedBox(
                height: 90,
              ),
              visible: !(size.width < 700),
            ),
            LabeledWidgetReadonly(
              "Fecha de radicación",
              pqrsfProvider.filingDateAnswer,
            ),
            LabeledWidgetReadonly(
              "Estado de trámite",
              pqrsfProvider.proccessStateAnswer,
            ),
            LabeledWidgetReadonly(
              "Fecha de respuesta",
              pqrsfProvider.dateAnswer,
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
