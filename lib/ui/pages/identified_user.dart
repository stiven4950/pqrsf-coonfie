import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/models/models.dart';
import 'package:pqrf_coonfie/ui/decorations/input_decorations.dart';
import 'package:provider/provider.dart';

import 'package:pqrf_coonfie/ui/widgets/widgets.dart';
import 'package:pqrf_coonfie/providers/providers.dart';
import 'package:searchfield/searchfield.dart';

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
                String pattern = pqrsfProvider.regExpDocumentType;
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
              'Teléfono',
              hintText: 'Digite su teléfono',
              initialValue: pqrsfProvider.telephone,
              onChanged: (value) => pqrsfProvider.telephone = value,
              validator: (value) {
                String pattern = r'^(\d{10})$';
                RegExp regExp = RegExp(pattern);

                if (value!.isEmpty) {
                  return null;
                }

                return regExp.hasMatch(value)
                    ? null
                    : 'Formato de teléfono inválido';
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
            /* LabeledSelect(
              data: 'Ciudad o municipio',
              hintText: 'Seleccione...',
              dropdownItems: pqrsfProvider.cityItems,
              selected: pqrsfProvider.city,
              onChanged: (value) {
                pqrsfProvider.city = value!;
                FocusScope.of(context).requestFocus(FocusNode());
              },
              validator: (value) {
                return value!.isNotEmpty ? null : "Ciudad es requerido";
              },
            ), */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ciudad o municipio',
                    style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 5.0),
                SearchField<Municipios>(
                  suggestions: pqrsfProvider.cityItems
                      .map((e) => SearchFieldListItem<Municipios>(
                          e.municipioDepartamento,
                          item: e))
                      .toList(),
                  suggestionState: Suggestion.hidden,
                  hasOverlay: true,
                  searchInputDecoration: InputDecorations.authDecoration(
                    hintText: 'Seleccione...',
                  ),
                  maxSuggestionsInViewPort: 5,
                  itemHeight: 40,
                  onSuggestionTap: (x) {
                    pqrsfProvider.city = x.item!.municipioId;
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Ciudad es requerido";
                  },
                ),
              ],
            ),
            const SizedBox(height: 15.0),
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
            LabeledSelect(
              data: 'Agencia',
              hintText: 'Seleccione...',
              dropdownItems: pqrsfProvider.agencyItems,
              selected: pqrsfProvider.agency,
              onChanged: (value) {
                pqrsfProvider.agency = value!;
                FocusScope.of(context).requestFocus(FocusNode());
              },
              validator: (value) {
                return value!.isEmpty && pqrsfProvider.asociated == "1"
                    ? "Si eres asociado selecciona una agencia"
                    : null;
              },
            ),
            SizedBox(
              width: 300.0,
              child: Row(
                children: const [
                  Text('Asociado', style: TextStyle(fontSize: 16.0)),
                  Asociated(),
                ],
              ),
            )
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
