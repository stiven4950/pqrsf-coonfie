import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pqrf_coonfie/providers/menu_section.dart';
import 'package:pqrf_coonfie/ui/widgets/responsive.dart';

class ButtonSectionWidget extends StatelessWidget {
  final String title;
  final int order;

  const ButtonSectionWidget({
    Key? key,
    required this.title,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final menuSection = Provider.of<MenuSection>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => menuSection.menu = order,
        child: FittedBox(
          child: Text(
            title,
            style: TextStyle(
              fontSize: ResponsiveWidget.widthInScreen(context, 15, 16, 17, 17),
            ),
          ),
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith(
            (states) => const BorderSide(color: Color(0xFF596FD7), width: 1.0),
          ),
          minimumSize: MaterialStateProperty.resolveWith(
            (states) => Size(
                ResponsiveWidget.widthInScreen(context, size.width,
                    size.width * .25, size.width * .25, size.width * 0.25),
                36),
          ),
          shape: MaterialStateProperty.resolveWith(
            (states) => const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(36.0),
              ),
            ),
          ),
          padding: MaterialStateProperty.resolveWith(
            (states) =>
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          ),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return const Color(0xFF596FD7);
            }

            if (menuSection.menu == order) {
              return const Color(0xFF596FD7);
            }

            return const Color(0xFFFFFFFF);
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return const Color(0xFFFFFFFF);
            }
            if (menuSection.menu == order) {
              return const Color(0xFFFFFFFF);
            }
            return const Color(0xFF596FD7);
          }),
        ),
      ),
    );
  }
}
