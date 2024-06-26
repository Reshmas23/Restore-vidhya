import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/widgets/appbar_color/appbar_clr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/teacher_model/attentence/attendance_model.dart';
import 'teacher_subject_list_view.dart';

class AttendenceBookScreen extends StatelessWidget {
 final String schoolId;
 final String classID;
 final String batchId;
 final String month;
  const AttendenceBookScreen(
      {required this.schoolId,
      required this.batchId,
      required this.classID,
      required this.month,
      super.key});

  @override
  Widget build(BuildContext context) {
    int columnCount = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    log(classID);
    return Scaffold(
      appBar: AppBar(
        title:  Text('Attendance Book'.tr),
       // backgroundColor: adminePrimayColor,
       flexibleSpace: const AppBarColorWidget(),
       foregroundColor: cWhite,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(schoolId)
            .collection(batchId)
            .doc(batchId)
            .collection("classes")
            .doc(classID)
            .collection("Attendence").doc(month).collection(month).orderBy('docid', descending: true)
          
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AnimationLimiter(
              child: GridView.count(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.all(w / 60),
                crossAxisCount: columnCount,
                children: List.generate(
                  snapshot.data!.docs.length,
                  (int index) {
                    // ignore: unused_local_variable
                    final data = GetAttendenceModel.fromJson(
                        snapshot.data!.docs[index].data());

                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 200),
                      columnCount: columnCount,
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(()=>AttendenceSubjectListScreen(
                                month: month,
                                  batchId: batchId,
                                  schoolId: schoolId,
                                  classID: classID,
                                  date: snapshot.data!.docs[index]['docid']));
                            },
                            child: Container(
                              height: h / 100,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  bottom: w / 10,
                                  left: w / 50,
                                  right: w / 50),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.withOpacity(0.1),
                                //  const Color.fromARGB(212, 67, 30, 203)
                                //     .withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.4),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        snapshot.data!.docs[index]['dDate'],
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['day'],
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      )),
    );
  }
}
