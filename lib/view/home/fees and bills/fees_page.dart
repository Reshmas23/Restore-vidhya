import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/widgets/appbar_color/appbar_clr.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:get/get_utils/get_utils.dart';

import 'fees_class_level.dart';
import 'fees_school_level.dart';

class FeesPage extends StatelessWidget {
  const FeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
        flexibleSpace: const AppBarColorWidget(),
          title: GoogleMonstserratWidgets(
              text: 'Fees List'.tr,
              color: cWhite,
              fontsize: 18.w,
              fontWeight: FontWeight.w700),
          bottom: TabBar(
             indicatorSize: TabBarIndicatorSize.tab,
             indicatorColor: Colors.red,
            labelColor: cWhite,
            tabs: [
              
              Tab(
                
                child: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: GoogleMonstserratWidgets(
                    text: 'School Level'.tr,
                     
                    fontsize: 15.w,
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: GoogleMonstserratWidgets(
                    text: 'Class Level'.tr,
                    
                    fontsize: 15.w,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            
            children: [
              SchoolLevelFees(),
              ClassLevelFees(),
            ],
          ),
        ),
      ),
    );
  }
}
