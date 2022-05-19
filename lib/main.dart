import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/ui/decorations/theme_light.dart';
import 'package:provider/provider.dart';

import 'package:pqrf_coonfie/ui/pages/pqrf_page.dart';
import 'package:pqrf_coonfie/providers/providers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PQRSFProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => MenuSection(), lazy: false),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PQRSF | Coonfie',
        home: const PqrfPage(),
        theme: lightThemeData,
      ),
    );
  }
}
