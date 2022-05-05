import 'package:flutter/material.dart';

class GradientButtonExtended extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;

  const GradientButtonExtended(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
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
        onPressed: onPressed,
        child: SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              const SizedBox(width: 10),
              Icon(icon),
            ],
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(const Size(150, 50)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          // elevation: MaterialStateProperty.all(3),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}
