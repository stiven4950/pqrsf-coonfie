import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/providers/pqrf_provider.dart';
import 'package:pqrf_coonfie/ui/pages/section_identified_user.dart';
import 'package:pqrf_coonfie/ui/widgets/asociated.dart';
import 'package:pqrf_coonfie/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PqrfPage extends StatelessWidget {
  const PqrfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);

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

                  const SectionsPQRSF(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: size.width < 700
                        ? [
                            CircularButton(
                              tooltip: 'Adjuntar archivos',
                              icon: Icons.cloud_upload_rounded,
                              onPressed: () {},
                            ),
                            CircularButton(
                              tooltip: 'Enviar formulario',
                              icon: Icons.send,
                              onPressed: () {
                                pqrsfProvider.validateForm();
                              },
                            ),
                          ]
                        : [
                            GradientButtonExtended(
                              text: "Adjuntar archivos",
                              icon: Icons.cloud_upload_rounded,
                              onPressed: () {},
                            ),
                            GradientButtonExtended(
                              text: "Enviar",
                              icon: Icons.send,
                              onPressed: () {
                                pqrsfProvider.validateForm();
                              },
                            ),
                          ],
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
