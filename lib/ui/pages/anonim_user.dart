import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/providers/pqrf_provider.dart';
import 'package:pqrf_coonfie/ui/widgets/labeled_widget.dart';
import 'package:pqrf_coonfie/ui/widgets/sections_widget.dart';
import 'package:provider/provider.dart';

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
              onChanged: (value) => pqrsfProvider.fullName,
              validator: (value) {
                String pattern = r'[a-zA-Z\s]{5,50}';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Formato de nombre inválido';
              },
            ),
            LabeledSelect(
                data: 'Tipo de petición',
                hintText: 'Seleccione...',
                dropdownItems: pqrsfProvider.requestItems,
                selected: '',
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
            LabeledSelect(
                data: 'Asunto',
                hintText: 'Seleccione...',
                dropdownItems: pqrsfProvider.matterItems,
                selected: '',
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
          ],
        ),
      ),
      SizedBox(
        width: size.width < 700 ? size.width * .9 : size.width * (1 / 4),
        child: Column(
          children: [
            LabeledWidget(
              'Descripción',
              hintText: 'Describa su solicitud',
              onChanged: (value) => pqrsfProvider.address,
              validator: (value) {
                return value!.length > 1 && value.length < 300
                    ? null
                    : 'Formato de descripción inválido';
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