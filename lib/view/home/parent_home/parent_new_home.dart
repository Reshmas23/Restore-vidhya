import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/local_database/parent_login_database.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/home/all_class_test_monthly_show/all_class_list_monthly_show.dart';
import 'package:dujo_kerala_application/view/home/all_class_test_show/all_class_list_show.dart';
import 'package:dujo_kerala_application/view/home/bus_route_page/all_bus_list.dart';
import 'package:dujo_kerala_application/view/home/events/event_list.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/users_exam_list_view/user_exam_acc.dart';
import 'package:dujo_kerala_application/view/home/fees%20and%20bills/fees_page.dart';
import 'package:dujo_kerala_application/view/home/parent_home/leave_application/apply_leave_application.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_profile_edit/parent_edit_profile.dart';
import 'package:dujo_kerala_application/view/home/parent_home/school_parent_pages/carousel_slider.dart';
import 'package:dujo_kerala_application/view/home/student_home/subjects/subject_display.dart';
import 'package:dujo_kerala_application/view/home/student_home/time_table/ss.dart';
import 'package:dujo_kerala_application/view/pages/Attentence/take_attentence/attendence_book_status_month.dart';
import 'package:dujo_kerala_application/view/pages/Homework/view_home_work.dart';
import 'package:dujo_kerala_application/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:dujo_kerala_application/view/pages/Notice/notice_list.dart';
import 'package:dujo_kerala_application/view/pages/chat/parent_section/parent_chat_screeen.dart';
import 'package:dujo_kerala_application/view/pages/exam_results/for_users/select_examlevel_uses.dart';
import 'package:dujo_kerala_application/view/pages/teacher_list/teacher_list.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/view/widgets/icon/icon_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../controllers/multipile_students/multipile_students_controller.dart';

class ParentProfileHomePage extends StatefulWidget {
  final String studentName;
  const ParentProfileHomePage({super.key,
  required this.studentName,
  });

  @override
  State<ParentProfileHomePage> createState() => _ParentProfileHomePageState();
}

class _ParentProfileHomePageState extends State<ParentProfileHomePage> {
  MultipileStudentsController multipileStudentsController =
      Get.put(MultipileStudentsController());

  String deviceToken = '';

  void getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        deviceToken = token ?? 'Not get the token ';
        log("User Device Token :: $token");
      });
      saveDeviceTokenToFireBase(deviceToken);
    });
  }

  void saveDeviceTokenToFireBase(String deviceToken) async {
    await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ParentCollection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'deviceToken': deviceToken}, SetOptions(merge: true))
        .then((value) => log('Device Token Saved To FIREBASE'))
        .then((value) => FirebaseFirestore.instance
                .collection('PushNotificationToAll')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set({
              'deviceToken': deviceToken,
              'schoolID': UserCredentialsController.schoolId,
              'batchID': UserCredentialsController.batchId,
              'classID': UserCredentialsController.classId,
              'personID': FirebaseAuth.instance.currentUser!.uid,
              'role': 'Parent'
            }))
        .then((value) => FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('PushNotificationList')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set({
              'deviceToken': deviceToken,
              'batchID': UserCredentialsController.batchId,
              'classID': UserCredentialsController.classId,
              'personID': FirebaseAuth.instance.currentUser!.uid,
              'role': 'Parent'
            }));
  }

// }

  Future<void> sendPushMessage(String token, String body, String title) async {
    try {
      final reponse = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAd0ScEck:APA91bELuwPRaLXrNxKTwj-z6EK-mCSPOon5WuZZAwkdklLhWvbi_NxXGtwHICE92vUzGJyE9xdOMU_-4ZPbWy8s2MuS_s-4nfcN_rZ1uBTOCMCcJ5aNS7rQHeUTXgYux54-n4eoYclp'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              'title': title,
              'body': body,
              'android_channel_id': 'high_importance_channel'
            },
            'to': token,
          },
        ),
      );
      log(reponse.body.toString());
    } catch (e) {
      if (kDebugMode) {
        log("error push Notification");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();

    //   sendPushMessage( deviceToken, 'Hello Everyone', 'DUJO APP');
  }

  @override
  Widget build(BuildContext context) {
     final screenNavigationOfParent = [
      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!), //Attendence...0

      LeaveApplicationScreen(
          studentName:widget.studentName,
          guardianName: UserCredentialsController.parentModel!.parentName!,
          classID: UserCredentialsController.classId!,
          schoolId: UserCredentialsController.schoolId!,
          studentID: UserCredentialsController.parentModel!.studentID!,
          batchId: UserCredentialsController.batchId!), //Leave Letter////...1
      ///student name error


      const ParentChatScreen(),//Chats///......2

      const SS(), // Time Table...........3

      SchoolLevelMeetingPage(), //Meetings................4

      const UserExmNotifications(), // Exams...........5

      UsersSelectExamLevelScreen(
          classId: UserCredentialsController.classId!,
          studentID: UserCredentialsController
              .parentModel!.studentID!), ////// exam result............6

      const ViewHomeWorks(), // Home Works...............7

      NoticePage(), //Notice.........8

      const EventList(), //Events.................9

      // ProgressReportListViewScreen(
      //     schoolId: UserCredentialsController.schoolId!,
      //     classID: UserCredentialsController.classId!,
      //     studentId: UserCredentialsController.parentModel?.studentID ?? "",
      //     batchId: UserCredentialsController.batchId!), //Progress Report

      const StudentSubjectHome(), //Subjects...............10

      TeacherSubjectWiseList(navValue: 'parent'), //Teachers.................11

      BusRouteListPage(),//////Bus Route......................12
      /////// all bus
      const FeesPage(),///////////Fees...........13
      AllClassTestPage(
        pageNameFrom: "parent",
      ), //////////class test page...............14
      AllClassTestMonthlyPage(
        pageNameFrom: "parent",
      ),//////Monthly Class Test............15
    ];
    log("Parent DOCID :::::::::::::::::::  ${UserCredentialsController.parentModel?.docid}");
    log("Firebase Auth DOCID :::::::::::::::::::  ${FirebaseAuth.instance.currentUser?.uid}");
    final parentAuth = DBParentLogin(
        parentPassword: ParentPasswordSaver.parentPassword,
        parentEmail: ParentPasswordSaver.parentemailID,
        schoolID: UserCredentialsController.schoolId!,
        batchID: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        studentID: UserCredentialsController.parentModel!.studentID!,
        parentID: FirebaseAuth.instance.currentUser!.uid,
        emailID: FirebaseAuth.instance.currentUser!.email ?? "",
        parentDocID: FirebaseAuth.instance.currentUser!.uid);
    multipileStudentsController.checkalreadyexist(
        FirebaseAuth.instance.currentUser!.uid, parentAuth);

    String studentName = '';

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromARGB(255, 130, 192, 243),
                            Color.fromARGB(153, 241, 240, 240),
                            Color.fromARGB(255, 149, 226, 236),
                            Color.fromARGB(99, 214, 212, 212),
                            Color.fromARGB(255, 139, 233, 223)
                          ]),
                             color: adminePrimayColor,
                      // color: Color.fromARGB(192, 208, 191, 234),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(45))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Welcome...",
                          style: GoogleFonts.abel(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () {
                            log(UserCredentialsController
                                .parentModel!.studentID!);
                          },
                          child: SizedBox(
                            width: screenSize.width / 2,
                            child: GoogleMonstserratWidgets(
                              overflow: TextOverflow.ellipsis,
                              text: UserCredentialsController
                                  .parentModel!.parentName!,
                              fontsize: 23.sp,
                              fontWeight: FontWeight.bold,
                              color: cblack,
                            ),
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding:
                      //       EdgeInsets.only(left: screenSize.width / 1.4, top: 30),
                      //   child: const CircleAvatar(
                      //     maxRadius: 40,
                      //     backgroundImage: AssetImage('assets/images/IOT.jpg'),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection("SchoolListCollection")
                                .doc(UserCredentialsController.schoolId)
                                .collection("AllStudents")
                                .doc(UserCredentialsController
                                        .parentModel?.studentID ??
                                    '')
                                .get(),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                return GoogleMonstserratWidgets(
                                  text:
                                      'Student : ${snap.data?.data()?['studentName']}',
                                  fontsize: 14.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: cblack.withOpacity(0.8),
                                );
                              } else {
                                return const Text('');
                              }
                            }),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('SchoolListCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection(UserCredentialsController.batchId!)
                                .doc(UserCredentialsController.batchId)
                                .collection('classes')
                                .doc(UserCredentialsController.classId)
                                .get(),
                            builder: (context, snaps) {
                              if (snaps.hasData) {
                                return GoogleMonstserratWidgets(
                                  text:
                                      'Class : ${snaps.data?.data()?['className']}',
                                  fontsize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: cblack.withOpacity(0.8),
                                );
                              } else {
                                return const Text('');
                              }
                            }),
                      ),
                      GoogleMonstserratWidgets(
                        text:
                            'email : ${UserCredentialsController.parentModel?.parentEmail ?? ""}',
                        fontsize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: cblack.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 40, top: 110),
                //   child: Container(
                //     height: 120,
                //     width: 150,
                //     decoration: const BoxDecoration(
                //         image: DecorationImage(
                //             image: AssetImage('assets/images/company.jpg'))),
                //   ),
                // ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80, top: 180),
                      child: GestureDetector(
                        onTap: () {
                            Get.to(() => ParentEditProfileScreen());
                          },
                        child: CircleAvatar(
                          maxRadius: 40,
                          backgroundImage: NetworkImage(UserCredentialsController
                                  .parentModel!.profileImageURL ??
                              ''),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 55,left: 50),
                            child: CircleAvatar(
                              //  backgroundColor: cWhite,
                              radius: 12,
                              child: Center(child: Icon(Icons.info)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30, top: 180),
                      child: CircleAvatar(
                        maxRadius: 40,
                        backgroundImage: AssetImage('assets/images/AI.jpg'),
                      ),
                    ),
                  ],
                ),
              ],
            ),/////////////////////////////////////
            const Padding(
              padding: EdgeInsets.only(top: 12,left: 8,right: 8,bottom: 10),
              child: CarouselSliderWidget(),
            ),////////////////////////////////////
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/icons8-attendance-100.png',
                           // icon: Icons.waving_hand,
                            text: ' Attendance',
                            onTap: () {
                              Get.to(screenNavigationOfParent[0]
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/icons8-homework-67.png',
                         //   icon: Icons.home_work,
                            text: 'Homework',
                            onTap: () 
                            {
                               Get.to(screenNavigationOfParent[7]);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/study-time.png',
                           // icon: Icons.assignment_rounded,
                            text: 'Time Table',
                            onTap: () {
                               Get.to(screenNavigationOfParent[3]);
                            }
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/icons8-teacher-100.png',
                            //icon: Icons.person_2,
                            text: 'Teachers',
                            onTap: () {
                               Get.to(screenNavigationOfParent[11]);
                            }),
                      ),
                       Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: ContainerWidget(
                            image: 'assets/flaticons/icons8-books-48.png',
                              //icon: Icons.import_contacts,
                              text: 'Subjects',
                              onTap: () {
                                 Get.to(screenNavigationOfParent[10]);
                              }),
                        ),
                      
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/leave_letter.png',
                            //icon: Icons.note_sharp,
                            text: 'Leave Letters',
                            onTap: () {
                              Get.to(screenNavigationOfParent[1]);
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/exam.png',
                            //icon: Icons.list_alt,
                            text: 'Exams',
                            onTap: () {
                              Get.to(screenNavigationOfParent[5]);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/icons8-grades-100.png',
                            //icon: Icons.add_chart,
                            text: 'Exam Results',
                            onTap: () {
                              Get.to(screenNavigationOfParent[6]);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/icons8-notice-100.png',
                          //  icon: Icons.notification_add,
                            text: 'Notices',
                            onTap: () {
                              Get.to(screenNavigationOfParent[8]);
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/schedule.png',
                           // icon: Icons.event, 
                            text: 'Events', onTap: () {
                              Get.to(screenNavigationOfParent[9]);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/meeting.png',
                          //  icon: Icons.meeting_room,
                            text: 'Meetings',
                            onTap: () {
                              Get.to(screenNavigationOfParent[4]);
                            }),
                      ),
                       Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ContainerWidget(
                            image: 'assets/flaticons/icons8-chat-100.png',
                              //icon: Icons.chat_rounded,
                              text: 'Chats',
                              onTap: () {
                                Get.to(screenNavigationOfParent[2]);
                              }),
                        ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 10, right: 10, bottom: 10),
                      //   child: ContainerWidget(
                      //     image: '',
                      //       //icon: Icons.bus_alert,
                      //       text: 'Bus Route',
                      //       onTap: () {}),
                      // ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/exam (1).png',
                            //icon: Icons.class_,
                            text: 'Class Test',
                            onTap: () {
                              Get.to(screenNavigationOfParent[14]);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/test.png',
                            //icon: Icons.view_list,
                            text: 'Monthly Class Test',
                            onTap: () {
                              Get.to(screenNavigationOfParent[15]);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ContainerWidget(
                         image: 'assets/flaticons/bill.png',
                            //icon: Icons.attach_money_rounded,
                            text: 'Fees & Bills',
                            onTap: () {
                              Get.to(screenNavigationOfParent[13]);
                            }),
                      ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 10, right: 10, bottom: 10),
                      //     child: ContainerWidget(
                      //       image: '',
                      //         //icon: Icons.library_books,
                      //         text: 'Library',
                      //         onTap: () {}),
                      //   ),
                      // ),
                    ],
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}