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
        width: ResponsiveWidget.widthInScreen(
          context,
          size.width * .9,
          size.width * .3,
          size.width * (1 / 4),
          size.width * (1 / 4),
        ),
        child: Column(
          children: const [
            SizedBox(
              child: Text("Aquí va la leyenda"),
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
        width: ResponsiveWidget.widthInScreen(
          context,
          size.width * .9,
          size.width * .3,
          size.width * (1 / 4),
          size.width * (1 / 4),
        ),
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
              maxLines: 10,
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
