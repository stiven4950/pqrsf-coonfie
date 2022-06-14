import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CustomButtonIconLef extends StatefulWidget {
  final Function onPressed;
  final String text;
  final IconData icon;

  const CustomButtonIconLef({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  State<CustomButtonIconLef> createState() => _CustomButtonIconLefState();
}

class _CustomButtonIconLefState extends State<CustomButtonIconLef> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: FadeIn(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          decoration: BoxDecoration(
            color: isHover ? Colors.white : const Color(0xFF596FD7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            onPressed: () => widget.onPressed(),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: !isHover ? Colors.white : const Color(0xFF596FD7),
                  size: 15,
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 15,
                    color: !isHover ? Colors.white : const Color(0xFF596FD7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              elevation: MaterialStateProperty.all(0.0),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
