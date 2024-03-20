import 'package:flutter/material.dart';

class AppBarColorWidget extends StatelessWidget {
  const AppBarColorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      //   Color.fromARGB(255, 6, 152, 225),
                      //  Color.fromARGB(255, 15, 73, 208),
                         Color.fromARGB(255, 6, 152, 225),
                         Color.fromARGB(255, 15, 73, 208),
                    ],
                    end: Alignment.topLeft,
                    begin: Alignment.bottomRight,
                  ),
                 // color: cgraident.withOpacity(0.5),
                 
                ),
          );
  }
}