import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

import 'package:pqrf_coonfie/models/models.dart';
import 'package:pqrf_coonfie/providers/providers.dart';
import 'package:pqrf_coonfie/ui/decorations/input_decorations.dart';
import 'package:pqrf_coonfie/ui/widgets/widgets.dart';

class UserIdentifiedSection extends StatelessWidget {
  const UserIdentifiedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);
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
            LabeledWidget(
              'N° de documento',
              hintText: 'Digite su número de documento',
              initialValue: pqrsfProvider.documentNumber,
              onChanged: (value) => pqrsfProvider.documentNumber = value,
              validator: (value) {
                String pattern = r'^(\d{4,10})$';
                RegExp regExp = RegExp(pattern);

                if (value!.isEmpty) {
                  return "N° de documento es requerido";
                }
                return regExp.hasMatch(value)
                    ? null
                    : 'Formato de documento inválido';
              },
            ),
            LabeledWidget(
              'Nombre y apellidos o razón social',
              hintText: 'Digite su nombre',
              initialValue: pqrsfProvider.fullName,
              onChanged: (value) => pqrsfProvider.fullName = value,
              validator: (value) {
                String pattern = r'^([a-zA-ZÀ-ÿ\u00f1\u00d1\s]{5,50})$';
                RegExp regExp = RegExp(pattern);

                if (value!.isEmpty) {
                  return "Nombre o razón social es requerido";
                }

                return regExp.hasMatch(value)
                    ? null
                    : 'Formato de nombre inválido';
              },
            ),
            LabeledWidget(
              'Celular',
              hintText: 'Digite su celular',
              initialValue: pqrsfProvider.phone,
              onChanged: (value) => pqrsfProvider.phone = value,
              validator: (value) {
                String pattern = r'^([3]\d{9})$';
                RegExp regExp = RegExp(pattern);

                if (value!.isEmpty) {
                  return "Celular es requerido";
                }

                return regExp.hasMatch(value)
                    ? null
                    : 'Formato de celular inválido';
              },
            ),
            LabeledWidget(
              'Correo',
              key: const ValueKey('Correo'),
              hintText: 'Digite su E-mail',
              initialValue: pqrsfProvider.email,
              onChanged: (value) => pqrsfProvider.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                if (value!.isEmpty) {
                  return "Email es requerido";
                }

                return regExp.hasMatch(value)
                    ? null
                    : 'Formato de Email inválido';
              },
            ),
          ],
        ),
      ),
      SizedBox(
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
            LabeledWidget(
              'Dirección de residencia',
              hintText: 'Digite su dirección',
              initialValue: pqrsfProvider.address,
              onChanged: (value) => pqrsfProvider.address = value,
              validator: (value) {
                return pqrsfProvider.medium == 'F' && value!.isEmpty
                    ? "Ingresa una dirección, el medio de respuesta es físico"
                    : null;
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text("Ciudad o municipio de residencia",
                        style: TextStyle(fontSize: 13.0)),
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3.0),
                SearchField<City>(
                  searchStyle: const TextStyle(fontSize: 13.0),
                  suggestions: pqrsfProvider.cityItems
                      .map((e) => SearchFieldListItem<City>(e.name, item: e))
                      .toList(),
                  suggestionState: Suggestion.hidden,
                  hasOverlay: true,
                  searchInputDecoration: InputDecorations.authDecoration(
                    hintText: 'Seleccione...',
                  ),
                  maxSuggestionsInViewPort: 5,
                  itemHeight: 40,
                  onSuggestionTap: (x) {
                    pqrsfProvider.city = x.item!.cod;
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Ciudad es requerido";
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
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
                return value!.isNotEmpty ? null : "Tipo petición es requerido";
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
                return value!.isNotEmpty ? null : "Asunto requerido";
              },
            ),
          ],
        ),
      ),
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
            LabeledSelect(
              data: 'Medio de respuesta',
              hintText: 'Seleccione...',
              dropdownItems: pqrsfProvider.mediumItems,
              selected: pqrsfProvider.medium,
              onChanged: (value) {
                pqrsfProvider.medium = value!;
                FocusScope.of(context).requestFocus(FocusNode());
              },
              validator: (value) {
                return value!.isNotEmpty ? null : "Ciudad es requerido";
              },
            ),
            LabeledWidget(
              'Descripción',
              hintText: 'Describa su solicitud',
              initialValue: pqrsfProvider.description,
              onChanged: (value) => pqrsfProvider.description = value,
              validator: (value) {
                return value!.length > 1 && value.length < 1000
                    ? null
                    : 'Descripción es requerido';
              },
              maxLines: 8,
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
