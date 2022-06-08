import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pqrf_coonfie/ui/pages/anonim_user.dart';
import 'package:pqrf_coonfie/ui/pages/consult.dart';
import 'package:pqrf_coonfie/ui/pages/identified_user.dart';
import 'package:pqrf_coonfie/ui/widgets/widgets.dart';
import 'package:pqrf_coonfie/providers/providers.dart';

class PqrfPage extends StatelessWidget {
  const PqrfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);
    final menuSection = Provider.of<MenuSection>(context);

    const List<Widget> childrenButtonSection = [
      ButtonSectionWidget(title: "Usuario Identificado", order: 1),
      ButtonSectionWidget(title: "Usuario anónimo", order: 2),
      ButtonSectionWidget(title: "Consulta", order: 3),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderWidget(),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal:
                    ResponsiveWidget.widthInScreen(context, 25, 25, 30, 100),
                vertical: ResponsiveWidget.widthInScreen(context, 8, 8, 10, 10),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      'Apreciado usuario, le damos la bienvenida a este espacio en el que podrá radicar peticiones, quejas, reclamos sugerencias y felicitaciones, consultar el estado de estas, así como la(s) respuesta(s) generada(s). Le invitamos a seleccionar a continuación el trámite que desea realizar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),

                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: childrenButtonSection,
                    spacing:
                        ResponsiveWidget.widthInScreen(context, 0, 5, 5, 40),
                  ),

                  // -------------------------------------------------------------
                  Visibility(
                    child: FadeInLeft(child: const UserIdentifiedSection()),
                    visible: menuSection.menu == 1,
                  ),
                  Visibility(
                    child: FadeInLeft(child: const AnonimUser()),
                    visible: menuSection.menu == 2,
                  ),
                  Visibility(
                    child: FadeInLeft(child: const Consult()),
                    visible: menuSection.menu == 3,
                  ),
                  // -------------------------------------------------------------
                  Visibility(
                    visible: !(menuSection.menu == 3),
                    child: Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          spacing: 100,
                          children: ResponsiveWidget.isExtraSmallScreen(
                                      context) ||
                                  ResponsiveWidget.isSmallScreen(context)
                              ? [
                                  CircularButton(
                                    tooltip: 'Adjuntar archivos',
                                    icon: Icons.cloud_upload_rounded,
                                    onPressed: () => _selectDocumentsUpload(),
                                  ),
                                  CircularButton(
                                    tooltip: 'Enviar formulario',
                                    icon: Icons.send,
                                    onPressed: () async => _proccessInfo(
                                      context,
                                      pqrsfProvider,
                                      menuSection,
                                    ),
                                  ),
                                ]
                              : [
                                  GradientButtonExtended(
                                    text: "Adjuntar",
                                    icon: Icons.cloud_upload_rounded,
                                    onPressed: () => _selectDocumentsUpload(),
                                  ),
                                  GradientButtonExtended(
                                    text: "Enviar",
                                    icon: Icons.send,
                                    onPressed: () async => _proccessInfo(
                                      context,
                                      pqrsfProvider,
                                      menuSection,
                                    ),
                                  ),
                                ],
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future _display(BuildContext context) {
  final menuSection = Provider.of<MenuSection>(context, listen: false);

  return showDialog(
    context: context,
    builder: (BuildContext context) => CustomDialog(
      title: 'Proceso realizado con éxito!',
      description: "",
      buttonText: "Agregar",
      color: const Color(0xFF4054B2),
      icon: Icons.check_circle,
      widget: menuSection.menu != 2
          ? const PositiveResult()
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: const Text(
                'Hemos recibido tu reporte, recuerda que en esta sección no se genera número de radicado.',
                textAlign: TextAlign.justify,
              ),
            ),
      action: () {},
    ),
  );
}

Future<void> _proccessInfo(
  BuildContext context,
  PQRSFProvider pqrsfProvider,
  MenuSection menuSection,
) async {
  pqrsfProvider.validateForm();

  if (pqrsfProvider.isValidForm()) {
    if (await pqrsfProvider.sendData(menuSection.menu)) {
      _display(context);
    } else {
      // Se intentaron enviar los datos pero hubo un error
    }
  } else {
    // Corregir los errores, completar el formulario
  }
}

void _selectDocumentsUpload() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: ['jpg', 'pdf', 'docx', 'png'],
  );

  if (result != null) {
  } else {
    // User canceled the picker
  }
}
