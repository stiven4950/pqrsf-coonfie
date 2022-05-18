import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pqrf_coonfie/ui/widgets/widgets.dart';
import 'package:pqrf_coonfie/providers/providers.dart';

class AnonimUser extends StatelessWidget {
  const AnonimUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);

    final List<Widget> children = [
      SizedBox(
        width: size.width < 700 ? size.width * .9 : size.width * (1 / 4),
        child: Column(
          children: [
            LabeledWidget(
              'Nombre y apellidos o razón social',
              hintText: 'Digite su nombre',
              initialValue: pqrsfProvider.fullName,
              onChanged: (value) => pqrsfProvider.fullName = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return null;
                }
                String pattern = r'^([a-zA-ZÀ-ÿ\u00f1\u00d1\s]{5,50})$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value)
                    ? null
                    : 'Formato de nombre inválido';
              },
            ),
            LabeledSelect(
              data: 'Tipo de petición',
              hintText: 'Seleccione...',
              dropdownItems: pqrsfProvider.requestItems,
              selected: pqrsfProvider.typeRequest,
              onChanged: (value) {
                pqrsfProvider.typeRequest = value!;
                pqrsfProvider.bringMatter();
                FocusScope.of(context).requestFocus(FocusNode());
              },
              validator: (value) {
                return value!.isEmpty ? "Tipo de petición es requerido" : null;
              },
            ),
            LabeledSelect(
              data: 'Asunto',
              hintText: 'Seleccione...',
              dropdownItems: pqrsfProvider.matterItems,
              selected: pqrsfProvider.matter,
              onChanged: (value) {
                pqrsfProvider.matter = value!;
                FocusScope.of(context).requestFocus(FocusNode());
              },
              validator: (value) {
                return value!.isEmpty ? "Asunto es requerido" : null;
              },
            ),
          ],
        ),
      ),
      SizedBox(
        width: size.width < 700 ? size.width * .9 : size.width * (1 / 4),
        child: Column(
          children: [
            LabeledWidget(
              'Descripción',
              key: const ValueKey('Descripcion'),
              hintText: 'Describa su solicitud',
              initialValue: pqrsfProvider.description,
              onChanged: (value) => pqrsfProvider.description = value,
              validator: (value) {
                return value!.length > 1 && value.length < 300
                    ? null
                    : 'Descripción es requerido';
              },
              maxLines: 6,
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
