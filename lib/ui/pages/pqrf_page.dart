import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/providers/pqrf_provider.dart';
import 'package:pqrf_coonfie/ui/pages/section_identified_user.dart';
import 'package:pqrf_coonfie/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PqrfPage extends StatelessWidget {
  const PqrfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pqrfProvider = Provider.of<PQRSFProvider>(context);

    const List<Widget> children = [
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
                          children: children,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: children,
                        ),

                  // -------------------------------------------------------------

                  const SectionIdentifiedUser(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: size.width < 700
                        ? [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 4),
                                      blurRadius: 5.0)
                                ],
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    Color(0xFF596FD7),
                                    Color(0xFF1488CC),
                                  ],
                                ),
                                color: Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.cloud_upload_rounded),
                                tooltip: 'Adjuntar archivos',
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 4),
                                      blurRadius: 5.0)
                                ],
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    Color(0xFF596FD7),
                                    Color(0xFF1488CC),
                                  ],
                                ),
                                color: Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  pqrfProvider.validateForm();
                                },
                                icon: const Icon(Icons.send),
                                tooltip: 'Enviar formulario',
                                color: Colors.white,
                              ),
                            ),
                          ]
                        : [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 4),
                                      blurRadius: 5.0)
                                ],
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    Color(0xFF596FD7),
                                    Color(0xFF1488CC),
                                  ],
                                ),
                                color: Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: SizedBox(
                                  width: 200.0,
                                  child: Row(
                                    children: const [
                                      Text(
                                        "Adjuntar archivos",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.cloud_upload_rounded),
                                    ],
                                  ),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(200, 50)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  // elevation: MaterialStateProperty.all(3),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 4),
                                      blurRadius: 5.0)
                                ],
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    Color(0xFF596FD7),
                                    Color(0xFF1488CC),
                                  ],
                                ),
                                color: Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  pqrfProvider.validateForm();
                                },
                                child: SizedBox(
                                  width: 200.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const [
                                      Text(
                                        "Enviar",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.send),
                                    ],
                                  ),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(200, 50)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  // elevation: MaterialStateProperty.all(3),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                              ),
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
