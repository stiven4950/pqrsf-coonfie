import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/providers/pqrf_provider.dart';
import 'package:pqrf_coonfie/ui/widgets/asociated.dart';

import 'package:pqrf_coonfie/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SectionIdentifiedUser extends StatefulWidget {
  const SectionIdentifiedUser({Key? key}) : super(key: key);

  @override
  State<SectionIdentifiedUser> createState() => _SectionIdentifiedUserState();
}

class _SectionIdentifiedUserState extends State<SectionIdentifiedUser> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);

    final List<Widget> children = [
      SizedBox(
        width: size.width < 700 ? size.width * .9 : size.width * (1 / 4),
        child: Column(
          children: [
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
            LabeledWidget(
              'Teléfono',
              hintText: 'Digite su teléfono',
              onChanged: (value) => pqrsfProvider.fullName,
              validator: (value) {
                String pattern = r'\d{10}';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Formato de nombre inválido';
              },
            ),
            LabeledWidget(
              'Celular',
              hintText: 'Digite su celular',
              onChanged: (value) => pqrsfProvider.fullName,
              validator: (value) {
                String pattern = r'[3]\d{9}';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Formato de nombre inválido';
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
            LabeledWidget(
              'Correo',
              hintText: 'Digite su E-mail',
              onChanged: (value) => pqrsfProvider.email,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Formato de correo inválido';
              },
            ),
            LabeledSelect(
                data: 'Ciudad o municipio',
                hintText: 'Seleccione...',
                dropdownItems: pqrsfProvider.cityItems,
                selected: '',
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
            LabeledWidget(
              'Dirección de residencia',
              hintText: 'Digite su teléfono',
              onChanged: (value) => pqrsfProvider.address,
              validator: (value) {
                return value!.length > 1 && value.length < 25
                    ? null
                    : 'Formato de dirección inválido';
              },
            ),
            LabeledSelect(
                data: 'Agencia',
                hintText: 'Seleccione...',
                dropdownItems: pqrsfProvider.agencyItems,
                selected: '',
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
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
        width: size.width < 700 ? size.width * .9 : size.width * (1 / 4),
        child: Column(
          children: [
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
            LabeledSelect(
                data: 'Medio',
                hintText: 'Seleccione...',
                dropdownItems: pqrsfProvider.mediumItems,
                selected: '',
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
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

    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      padding: const EdgeInsets.all(30.0),
      width: size.width < 700 ? size.width : size.width * .9,
      constraints: const BoxConstraints(minHeight: 400.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.0),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4.0)],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Form(
        key: pqrsfProvider.formKey,
        child: size.width < 700
            ? Column(children: children)
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
      ),
    );
  }
}
