import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pqrf_coonfie/ui/widgets/gradient_button_extended.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Color color;
  final IconData icon;
  final Widget widget;
  final Function action;

  CustomDialog({
    required this.title,
    required this.description,
    required this.buttonText,
    this.color = Colors.grey,
    required this.icon,
    required this.widget,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, icon, widget, action),
    );
  }

  dialogContent(BuildContext context, IconData icon, Widget widget, action) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: const EdgeInsets.only(top: Consts.avatarRadius),
            width: size.width < 700 ? size.width * .9 : size.width * .3,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16.0),
                widget,
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GradientButtonExtended(
                      text: "Aceptar",
                      icon: Icons.copy_rounded,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: Consts.padding,
            right: Consts.padding,
            child: CircleAvatar(
              backgroundColor: color,
              radius: Consts.avatarRadius,
              child: BounceInUp(child: Icon(icon, size: 110.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
