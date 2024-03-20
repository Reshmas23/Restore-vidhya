import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';

import 'package:flutter/material.dart';

class WidgetContainerOnHome extends StatelessWidget {
  String title;
  String body;
  String imagePath;
  WidgetContainerOnHome({
    required this.body,
    required this.imagePath,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.blue,
      height: 400,
      width:  300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GooglePoppinsWidgets(
            text: title,
            fontsize: 18,
            fontWeight: FontWeight.bold,
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              // color: Colors.red,
              color:  Colors.lightBlueAccent[900],
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.blue),
             boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 2, 107, 193),
                  offset: Offset(
                    1.0,
                    0.01,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5.0, 5.0),
                  blurRadius: 1.0,
                  spreadRadius: 0.01,
                ), //BoxShadow
              ],
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                height: 180,
                width: 180,
              ),
            ),
          ),
          SizedBox(
            // color: Colors.amber,
            height: 100,
            width: 400,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: GooglePoppinsWidgets(
                  text: body,
                  fontsize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
