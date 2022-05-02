import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(color: Color(0xFF4054B2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/data/images/logo.png"),
          const Text(
            "Sistema PQRSF Coonfie",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            ),
          ),
          size.width < 700
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ))
              : ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_back_ios),
                      Text(
                        "Regresar",
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      )
                    ],
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith(
                      (states) => const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => const Color(0xFF596FD7)),
                  ),
                ),
        ],
      ),
    );
  }
}
