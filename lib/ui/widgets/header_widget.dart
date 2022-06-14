import 'package:flutter/material.dart';

import 'package:pqrf_coonfie/ui/widgets/custom_button_icon_left.dart';
import 'package:pqrf_coonfie/ui/widgets/responsive.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width < 700 ? 10 : 40.0),
      width: double.infinity,
      height: 70,
      decoration: const BoxDecoration(color: Color(0xFF4054B2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/data/images/logo.png",
            height: ResponsiveWidget.isExtraSmallScreen(context) ? 30 : 40,
          ),
          FittedBox(
            child: Text(
              "Recepción de PQRSF",
              style: TextStyle(
                color: Colors.white,
                fontSize:
                    ResponsiveWidget.widthInScreen(context, 14, 14, 16, 16),
              ),
            ),
          ),
          ResponsiveWidget.isExtraSmallScreen(context)
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                )
              : CustomButtonIconLef(
                  text: 'Regresar',
                  icon: Icons.arrow_back_ios,
                  onPressed: () {},
                ),
        ],
      ),
    );
  }
}
