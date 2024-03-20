import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final String text;
  //final IconData icon;
  final String image;
  final void Function()? onTap;

  const ContainerWidget({
    required this.text,
    //required this.icon,
    required this.image,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 105.w, //110
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: adminePrimayColor.withOpacity(0.5))),
                child: Center(
                  child: Image.asset(
                    image,height: 40,width: 40,
                    fit: BoxFit.contain,
                    scale: 2,
                  ),
                ),
              ),
              GooglePoppinsWidgets(text: text, fontsize: 10,fontWeight: FontWeight.bold,)
            ],
          ),
        ),
      ),
    );
  }
}
