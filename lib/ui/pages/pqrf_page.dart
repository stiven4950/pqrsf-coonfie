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
    final size = MediaQuery.of(context).size;
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);
    final menuSection = Provider.of<MenuSection>(context);

    const List<Widget> childrenButtonSection = [
      ButtonSectionWidget(
        title: "Usuario identificado",
        order: 1,
      ),
      ButtonSectionWidget(
        title: "Usuario anónimo",
        order: 2,
      ),
      ButtonSectionWidget(
        title: "Consulta",
        order: 3,
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderWidget(),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width < 700 ? 25 : 100.0,
                  vertical: size.width < 700 ? 18 : 50.0),
              child: Column(
                children: [
                  size.width < 700
                      ? Column(
                          children: childrenButtonSection,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: childrenButtonSection,
                        ),

                  // -------------------------------------------------------------
                  Visibility(
                    child: const UserIdentifiedSection(),
                    visible: menuSection.menu == 1,
                  ),
                  Visibility(
                    child: const AnonimUser(),
                    visible: menuSection.menu == 2,
                  ),
                  Visibility(
                    child: const Consult(),
                    visible: menuSection.menu == 3,
                  ),
                  // -------------------------------------------------------------
                  Visibility(
                    visible: !(menuSection.menu == 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: size.width < 700
                          ? [
                              CircularButton(
                                tooltip: 'Adjuntar archivos',
                                icon: Icons.cloud_upload_rounded,
                                onPressed: () => _selectDocumentsUpload(),
                              ),
                              CircularButton(
                                tooltip: 'Enviar formulario',
                                icon: Icons.send,
                                onPressed: () {
                                  pqrsfProvider.validateForm();
                                  _display(context);
                                },
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
                                onPressed: () {
                                  pqrsfProvider.validateForm();
                                  _display(context);
                                  pqrsfProvider.sendData();
                                },
                              ),
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

Future _display(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: 'Proceso realizado con éxito!',
        description: "",
        buttonText: "Agregar",
        color: const Color(0xFF4054B2),
        icon: Icons.check_circle,
        widget: const PositiveResult(),
        action: () {},
      ),
    );

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
