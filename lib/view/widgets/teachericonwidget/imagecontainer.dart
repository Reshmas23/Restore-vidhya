import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
 
  final String image;
 // final void Function()? onTap;

  const ImageContainer({
    
    required this.image,
    //required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        //onTap: onTap,
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
                  child: Image.asset(height: 50,
                    image,
                    fit: BoxFit.contain,
                    scale: 2,
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
