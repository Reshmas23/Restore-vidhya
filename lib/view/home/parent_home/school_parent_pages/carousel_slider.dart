// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dujo_kerala_application/view/home/parent_home/school_parent_pages/assignment_graph.dart';
import 'package:dujo_kerala_application/view/home/parent_home/school_parent_pages/attendence_graph.dart';
import 'package:dujo_kerala_application/view/home/parent_home/school_parent_pages/exam_graph.dart';
import 'package:dujo_kerala_application/view/home/parent_home/school_parent_pages/home_work.dart';
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
              slidertext: 'EXAM RESULT',
            ),
            CaroselmageWidget(
              sliderWidget: graphList[1],
              slidertext: 'ASSIGNMENTS & PROJECTS',
            ),
            CaroselmageWidget(
              sliderWidget: graphList[2],
              slidertext: 'ATTENDENCES',
            ),
            CaroselmageWidget(
              sliderWidget: graphList[3],
              slidertext: 'HOME WORK',
            ),
          ],
          options: CarouselOptions(
            height: 280,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),
      ),
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
            fontsize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}

final List<Widget> graphList = [
  ExamGraph(),
  const AssignmetsGraph(),
  const Attendences(),
  const HomeWorkGraph(),
];
