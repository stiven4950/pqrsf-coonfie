import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pqrf_coonfie/ui/widgets/widgets.dart';
import 'package:pqrf_coonfie/providers/providers.dart';

class Consult extends StatelessWidget {
  const Consult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);
    final menuSection = Provider.of<MenuSection>(context);
    final size = MediaQuery.of(context).size;

    final List<Widget> children = [
      SizedBox(
        width: ResponsiveWidget.widthInScreen(
          context,
          size.width * .9,
          size.width * .25,
          size.width * (1 / 4),
          size.width * (1 / 4),
        ),
        child: Column(
          children: [
            const Text(
              "Para realizar la consulta es importante que tenga disponible el número de radicación que se informó al momento de realizar su solicitud.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Por favor indique el número de radicado.",
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
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
            CustomButton(
              text: "Consultar",
              icon: Icons.manage_search_rounded,
              onPressed: () async {
                pqrsfProvider.validateForm();
                pqrsfProvider.thereIsAnswer = true;
                await pqrsfProvider.consult();
              },
            ),
          ],
        ),
      ),
      Visibility(
        visible: pqrsfProvider.thereIsAnswer,
        child: FadeInUp(
          child: SizedBox(
            width: ResponsiveWidget.widthInScreen(
              context,
              size.width * .9,
              size.width * .25,
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
                    BounceInLeft(
                      child: Image.asset(
                        "assets/data/images/result.jpg",
                        height: 80.0,
                      ),
                    ),
                    FadeIn(
                      child: const Text(
                        "Respuesta",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
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
        ),
      ),
      Visibility(
        visible: pqrsfProvider.thereIsAnswer,
        child: FadeInUp(
          child: SizedBox(
            width: ResponsiveWidget.widthInScreen(
              context,
              size.width * .9,
              size.width * .25,
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
                CustomButton(
                  text: "Imprimir",
                  icon: Icons.print_rounded,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    ];
    return SectionsPQRSF(
      children: children,
    );
  }
}
