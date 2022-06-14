import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CustomButton extends StatefulWidget {
  final Function onPressed;
  final String text;
  final IconData icon;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: FadeIn(
        child: Container(
          width: 165,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: isHover
                ? const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 5.0)
                  ]
                : null,
            border: Border.all(
              color: const Color(0xFF596FD7),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(20),
            gradient: !isHover
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.6, 1.0],
                    colors: [
                      Color(0xFF596FD7),
                      Color(0xFF1488CC),
                    ],
                  )
                : null,
          ),
          child: ElevatedButton(
            onPressed: () => widget.onPressed(),
            child: Row(children: [
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 15,
                  color: !isHover ? Colors.white : const Color(0xFF596FD7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: isHover ? 30 : 20,
              ),
              Icon(
                widget.icon,
                color: !isHover ? Colors.white : const Color(0xFF596FD7),
              ),
            ]),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              elevation: MaterialStateProperty.all(0.0),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              minimumSize: MaterialStateProperty.all(const Size(165, 47)),
            ),
          ),
        ),
      ),
    );
  }
}
