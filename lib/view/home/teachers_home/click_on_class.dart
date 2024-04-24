import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/home/bus_route_page/all_bus_list.dart';
import 'package:dujo_kerala_application/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:dujo_kerala_application/view/pages/Notice/Tabs/school_level_tab.dart';
import 'package:dujo_kerala_application/view/widgets/appbar_color/appbar_clr.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/view/widgets/teachericonwidget/imagecontainer.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/utils.dart';
import '../../colors/colors.dart';
import '../../constant/responsive.dart';
import '../../pages/Attentence/select_period.dart';
import '../../pages/Attentence/take_attentence/attendence_book_status_month.dart';
import '../../pages/Homework/homework.dart';
import '../../pages/Subject/teacher_display_subjects.dart';
import '../../pages/chat/teacher_section/teacher_chat-screen.dart';
import '../../pages/exam_results/select_exam.dart';
import '../../pages/live_classes/teacher_live_section/create_room.dart';
import '../../pages/recorded_class/recorded_class_page.dart';
import '../events/Tabs/school_level_tab.dart';
import '../exam_Notification/users_exam_list_view/user_exam_acc.dart';
import '../student_home/time_table/ss.dart';
import 'class_test/class_test_page.dart';
import 'monthly_class_test/class_test_monthly_page.dart';

class ClickOnClasss extends StatelessWidget {
  final String classID;
  final String className;
  const ClickOnClasss(
      {required this.classID, required this.className, super.key});

  @override
  Widget build(BuildContext context) {
    final noDataNavigation = [
      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: classID), //Attendance Book

      const UserExmNotifications(), //Exam

      const SS(), //Time Table

      Scaffold(
        appBar: AppBar(
          flexibleSpace: const AppBarColorWidget(),
          foregroundColor: cWhite,
          //backgroundColor: adminePrimayColor,
          title: Text("Notices".tr),
        ),
        body: SchoolLevelNoticePage(),
      ),

      // Notice
      TeacherSubjectHome(),

      Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: Text("Events".tr),
        ),
        body: const SchoolLevelPage(),
      ),
      // Events
      SchoolLevelMeetingPage(), // Meetings

      ClassTestPage(),

      ClassMonthlyTestPage(),
    ];
    final hasDataNavigation = [
      SelectPeriodWiseScreen(
          batchId: UserCredentialsController.batchId!,
          classID: classID,
          schoolId: UserCredentialsController.schoolId!), //Take Attendance

      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: classID), //Attendance Book

      const TeacherChatScreen(), // Chats
      CreateRoomScreen(), //Live Class

      const UserExmNotifications(), //Exam

      SelectExamLevelScreen(classId: classID), //exam result upload

      const SS(), //TimeTable

      HomeWorkUpload(
        batchId: UserCredentialsController.batchId!,
        classId: UserCredentialsController.classId!,
        schoolID: UserCredentialsController.schoolId!,
        teacherID: UserCredentialsController.teacherModel!.docid!,
      ), //////////Home Work, //Home Works

      Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("Notices"),
        ),
        body: SchoolLevelNoticePage(),
      ),
      // Notice

      Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("Events"),
        ),
        body: const SchoolLevelPage(),
      ),
      // Events
      // ViewExamsForProgressreport(
      //     batchId: UserCredentialsController.batchId!,
      //     classID: classID,
      //     schooilID:
      //         UserCredentialsController.schoolId!), //Progress Report view
      TeacherSubjectHome(), // Subjects
      SchoolLevelMeetingPage(),
      // Meetings
      RecordedClassMainPage(), // recorded class

      BusRouteListPage(),
      ClassTestPage(),
      ClassMonthlyTestPage(), //class test monthly
    ];
    int columnCount = 3;
    double w = ResponsiveApp.mq.size.width;
   // double h = ResponsiveApp.mq.size.height;
    log('Teacher class iddddddd$classID');
    return Scaffold(
      appBar: AppBar(
        title: Text(className),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("SchoolListCollection")
                  .doc(UserCredentialsController.schoolId!)
                  .collection(UserCredentialsController.batchId!)
                  .doc(UserCredentialsController.batchId!)
                  .collection("classes")
                  .doc(classID)
                  .collection("teachers")
                  .doc(UserCredentialsController.teacherModel!.docid)
                  .collection("teacherSubject")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 200.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'You have no access in this class'.tr,
                                style: GoogleFonts.montserrat(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: AnimationLimiter(
                            child: GridView.count(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              padding: EdgeInsets.all(w / 20),
                              crossAxisCount: columnCount,
                              children: List.generate(
                                _acc_text.length,
                                (int index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 300),
                                    columnCount: columnCount,
                                    child: ScaleAnimation(
                                      duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return noDataNavigation[
                                                    index];
                                              },
                                            ));
                                        
                                            // Get.to(() =>
                                            //     noDataNavigation[index]);
                                          },
                                          child: SizedBox(
                                            width: 105.w, //110
                                            height: 100.h,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 80.h,
                                                  width: 80.w,
                                                  decoration: BoxDecoration(
                                                      shape:
                                                          BoxShape.circle,
                                                      border: Border.all(
                                                          color: adminePrimayColor
                                                              .withOpacity(
                                                                  0.5))),
                                                  child: Center(
                                                    child: Image.asset(
                                                      _acc_images[index],
                                                      height: 40,
                                                      width: 40,
                                                      fit: BoxFit.contain,
                                                      scale: 2,
                                                    ),
                                                  ),
                                                ),
                                                GooglePoppinsWidgets(
                                                  text: _acc_text[index],
                                                  fontsize: 10,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                )
                                              ],
                                            ),
                                          ),
                                          // child: Column(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment
                                          //           .spaceEvenly,
                                          //   children: [
                                          //     _acc_images[index] ,
                                          //     Center(
                                          //       child: Text(
                                          //         textAlign:
                                          //             TextAlign.center,
                                          //         _acc_text[index],
                                          //         style: GoogleFonts
                                          //             .montserrat(
                                          //                 color: Colors
                                          //                     .black
                                          //                     .withOpacity(
                                          //                         0.5),
                                          //                 fontSize: 11.5,
                                          //                 fontWeight:
                                          //                     FontWeight
                                          //                         .w600),
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return AnimationLimiter(
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.all(w / 60),
                        crossAxisCount: columnCount,
                        children: List.generate(
                          hasDataText.length,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 300),
                              columnCount: columnCount,
                              child: ScaleAnimation(
                                duration: const Duration(milliseconds: 900),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 2.0,bottom: 13,right: 5,left: 5),
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: cWhite),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => hasDataNavigation[index]);
                                        },
                                        child: Column(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceEvenly,
                                          children: [
                                            hasDataImages[index],
                                            // Container(
                                            //   height: 75,
                                            //   width: double.infinity,
                                            //   decoration: BoxDecoration(
                                            //     image: DecorationImage(
                                            //       image: AssetImage(
                                            //           hasDataImages[index]),
                                            //     ),
                                            //   ),
                                            // ),
                                            Center(
                                              child: Text(
                                                translateString(
                                                    hasDataText[index]),
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
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
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}

List<String> _acc_text = [
  'Attendance Book'.tr,
  'Exams'.tr,
  'Time Table'.tr,
  'Notices'.tr,
  'Subjects'.tr,
  'Events'.tr,
  'Meetings'.tr,
  'Class Test'.tr,
  'Monthly Class Test'.tr,
];
List<String> _acc_images = [
  "assets/flaticons/book.png",
  "assets/flaticons/icons8-grades-100.png",
  "assets/flaticons/worksheet.png",
  "assets/flaticons/icons8-notice-100.png",
  "assets/flaticons/icons8-books-48.png",
  "assets/flaticons/calendar.png",
  "assets/flaticons/meeting.png",
  "assets/flaticons/exam.png",
  "assets/flaticons/test.png"
  // const ImageContainer(image: "assets/flaticons/book.png"),
  //  const ImageContainer(image: "assets/flaticons/icons8-grades-100.png"),
  //  const ImageContainer(image: "assets/flaticons/worksheet.png"),
  //  const ImageContainer(image: "assets/flaticons/icons8-notice-100.png"),
  //  const ImageContainer(image: "assets/flaticons/icons8-books-48.png"),
  //  const ImageContainer(image: "assets/flaticons/calendar.png"),
  //  const ImageContainer(image: "assets/flaticons/meeting.png"),
  //  const ImageContainer(image: "assets/flaticons/exam.png"),
  //   const ImageContainer(image: "assets/flaticons/test.png"),
  // 'assets/images/classroom.png',
  // 'assets/images/exam.png',
  // 'assets/images/library.png',
  // 'assets/images/notices.png',
  // 'assets/images/subjects.png',
  // 'assets/images/activity.png',
  // 'assets/images/meetings.png',
  // 'assets/images/exmresult1.png',
  // 'assets/images/test.png',
];
List<Widget> hasDataImages = [
  const ImageContainer(image: "assets/flaticons/roll-call.png"),
  const ImageContainer(image: "assets/flaticons/book.png"),
  const ImageContainer(image: "assets/flaticons/icons8-chat-100.png"),
  const ImageContainer(image: "assets/flaticons/icons8-teacher-100.png"),
  const ImageContainer(image: "assets/flaticons/icons8-grades-100.png"),
  const ImageContainer(image: "assets/flaticons/exam (1).png"),
  const ImageContainer(image: "assets/flaticons/worksheet.png"),
  const ImageContainer(image: "assets/flaticons/icons8-homework-67.png"),
  const ImageContainer(image: "assets/flaticons/icons8-notice-100.png"),
  const ImageContainer(image: "assets/flaticons/calendar.png"),
  const ImageContainer(image: "assets/flaticons/school-material.png"),
  const ImageContainer(image: "assets/flaticons/meeting.png"),
  const ImageContainer(image: "assets/flaticons/recording.png"),
  const ImageContainer(image: "assets/flaticons/route (1).png"),
  const ImageContainer(image: "assets/flaticons/exam.png"),
  const ImageContainer(image: "assets/flaticons/test.png"),
  // 'assets/images/classroom.png',
  // 'assets/images/classroom.png',
  // 'assets/images/chat.png',
  // 'assets/images/virtual-class.png',
  // 'assets/images/exam.png',
  // 'assets/images/exmresult1.png',
  // 'assets/images/library.png',
  // 'assets/images/homework.png',
  // 'assets/images/notices.png',
  // 'assets/images/activity.png',
  // 'assets/images/subjects.png',
  // 'assets/images/meetings.png',
  // 'assets/images/recorded_classes.png',
  // 'assets/images/bus.png',
  // 'assets/images/exmresult1.png',
  // 'assets/images/test.png'
];
List<String> hasDataText = [
  'Take Attendance'.tr,
  'Attendance Book'.tr,
  'Chats'.tr,
  'Live Class'.tr,
  'Exams'.tr,
  'Exam Results'.tr,
  'Time Table'.tr,
  'HomeWorks'.tr,
  'Notices'.tr,
  'Events'.tr,
  'Study Materials'.tr,
  'Meetings'.tr,
  'Recorded Classes'.tr,
  'Bus Route'.tr,
  'Class Test'.tr,
  'Monthly Class Test'.tr,
];

class TeacherContainerWidget extends StatelessWidget {
  const TeacherContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
