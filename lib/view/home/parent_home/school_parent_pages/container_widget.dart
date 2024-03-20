
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class ContainerWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  const ContainerWidget({
    required this.text,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          //  Get.to(() => screenNavigation[index]);
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    // spreadRadius: 2,
                    // offset: Offset(0, 2),
                    color: Color.fromARGB(43, 240, 93, 93),
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer)
              ],
              // color: Colors.lightBlue.withOpacity(1),
              borderRadius: BorderRadius.circular(10)),
          width: 90,
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GradientIcon(
                icon: icon,
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GooglePoppinsWidgets(
                  text: text,
                  fontsize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ));
  }
}
