import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/ui/widgets/responsive.dart';
import 'package:provider/provider.dart';

import 'package:pqrf_coonfie/providers/providers.dart';

class SectionsPQRSF extends StatelessWidget {
  final List<Widget> children;
  const SectionsPQRSF({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pqrsfProvider = Provider.of<PQRSFProvider>(context);
    final menuSection = Provider.of<MenuSection>(context);

    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      padding: const EdgeInsets.all(30.0),
      width: ResponsiveWidget.widthInScreen(
        context,
        size.width,
        size.width,
        size.width * .95,
        size.width * .9,
      ),
      constraints: const BoxConstraints(minHeight: 300.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.0),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4.0)],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Form(
        key: pqrsfProvider.formKey,
        child: Wrap(
          alignment: !pqrsfProvider.thereIsAnswer && menuSection.menu == 3
              ? WrapAlignment.center
              : WrapAlignment.spaceAround,
          children: children,
        ),
      ),
    );
  }
}
