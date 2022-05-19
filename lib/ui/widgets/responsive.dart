import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;
  final Widget? extraSmallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
    this.extraSmallScreen,
  }) : super(key: key);

  static bool isExtraSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 992;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 992 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static double widthInScreen(
      context, double xs, double s, double m, double l) {
    return isExtraSmallScreen(context)
        ? xs
        : isSmallScreen(context)
            ? s
            : isMediumScreen(context)
                ? m
                : l;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < 768
            ? extraSmallScreen!
            : (constraints.maxWidth >= 768 && constraints.maxWidth < 992)
                ? smallScreen!
                : (constraints.maxWidth >= 992 && constraints.maxWidth < 1200)
                    ? mediumScreen!
                    : largeScreen;
      },
    );
  }
}
