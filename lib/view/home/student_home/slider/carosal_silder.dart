// ignore_for_file: must_be_immutable

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/student_home/graph_std/attendance_std_g.dart';
import 'package:dujo_kerala_application/view/home/student_home/graph_std/exm_std.dart';
import 'package:dujo_kerala_application/view/home/student_home/graph_std/homework_std_g.dart';
import 'package:dujo_kerala_application/view/home/student_home/graph_std/project_assignmnt_chart.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Center(
        child: CarouselSlider(
          items: [
            CaroselmageWidget(
              sliderWidget: graphList[0],
              slidertext: 'Homework',
            ),
            CaroselmageWidget(
              sliderWidget: graphList[1],
              slidertext: 'Exam Result',
            ),
            CaroselmageWidget(
              sliderWidget: graphList[2],
              slidertext: 'Attendance',
            ),
            CaroselmageWidget(
              sliderWidget: graphList[3],
              slidertext: 'Assignment & Project',
            ),
          ],
          options: CarouselOptions(
            height: 320.h,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),      ),
    );
  }
}

class CaroselmageWidget extends StatelessWidget {
  Widget sliderWidget;
  String slidertext;
  CaroselmageWidget({
    required this.sliderWidget,
    required this.slidertext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: sliderWidget,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: GooglePoppinsWidgets(
            text: slidertext,
            fontsize: 19.sp,
            color: cblack,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}

final List<Widget> graphList = [
  const HomeWorkGraph(),
  const ExamResultGraph(),
  const AttendanceGraph(),
  const StdProjectAndAssignmnetGraph()
];
