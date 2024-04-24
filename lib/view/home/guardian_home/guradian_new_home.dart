// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides, non_constant_identifier_names
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/all_class_test_monthly_show/all_class_list_monthly_show.dart';
import 'package:dujo_kerala_application/view/home/all_class_test_show/all_class_list_show.dart';
import 'package:dujo_kerala_application/view/home/bus_route_page/all_bus_list.dart';
import 'package:dujo_kerala_application/view/home/events/event_list.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/users_exam_list_view/user_exam_acc.dart';
import 'package:dujo_kerala_application/view/home/parent_home/leave_application/apply_leave_application.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_profile_edit/parent_edit_profile.dart';
import 'package:dujo_kerala_application/view/home/parent_home/school_parent_pages/carousel_slider.dart';
import 'package:dujo_kerala_application/view/home/student_home/subjects/subject_display.dart';
import 'package:dujo_kerala_application/view/home/student_home/time_table/ss.dart';
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/Attentence/take_attentence/attendence_book_status_month.dart';

class GuardianHomeScreen extends StatefulWidget {   
   final String studentName;

  const GuardianHomeScreen({super.key, required this.studentName});

  @override
  
  State<GuardianHomeScreen> createState() => _GuardianHomeScreenState();
}

class _GuardianHomeScreenState extends State<GuardianHomeScreen> {
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
        .collection('GuardianCollection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'deviceToken': deviceToken}, SetOptions(merge: true))
        .then((value) => log('Device Token Saved To FIREBASE'))
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
              'role': 'Guardian'
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
              'role': 'Guardian'
            }));

    //AAAAd0ScEck:APA91bELuwPRaLXrNxKTwj-z6EK-mCSPOon5WuZZAwkdklLhWvbi_NxXGtwHICE92vUzGJyE9xdOMU_-4ZPbWy8s2MuS_s-4nfcN_rZ1uBTOCMCcJ5aNS7rQHeUTXgYux54-n4eoYclp  apikey
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();

    //   sendPushMessage( deviceToken, 'Hello Everyone', 'DUJO APP');
  }

  Widget build(BuildContext context) {

 final screenNavigationOfParent = [
      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!), //Attendence...0

      LeaveApplicationScreen(
          studentName:widget.studentName,
          guardianName: UserCredentialsController.guardianModel!.guardianName!,
          classID: UserCredentialsController.classId!,
          schoolId: UserCredentialsController.schoolId!,
          studentID: UserCredentialsController.guardianModel!.studentID!,
          batchId: UserCredentialsController.batchId!), //Leave Letter////...1
      ///student name error


      const ParentChatScreen(),/////......2

      const SS(), // Time Table...........3

      SchoolLevelMeetingPage(), //Meetings................4

      const UserExmNotifications(), // Exams...........5

      UsersSelectExamLevelScreen(
          classId: UserCredentialsController.classId!,
          studentID: UserCredentialsController
              .guardianModel!.studentID!), ////// exam result............6

      const ViewHomeWorks(), // Home Works...............7

      NoticePage(), //Notice.........8

      const EventList(), //Events.................9

      // ProgressReportListViewScreen(
      //     schoolId: UserCredentialsController.schoolId!,
      //     classID: UserCredentialsController.classId!,
      //     studentId: UserCredentialsController.parentModel?.studentID ?? "",
      //     batchId: UserCredentialsController.batchId!), //Progress Report

      const StudentSubjectHome(), //Subjects...............10

      TeacherSubjectWiseList(navValue: 'guardian'), //Teachers.................11

      BusRouteListPage(),//////////......................12
      /////// all bus
     // const FeesPage(),////////////////////...........13
      AllClassTestPage(
        pageNameFrom: "guardian",
      ), //class test page////////////////////////////14
      AllClassTestMonthlyPage(
        pageNameFrom: "guardian",
      ),//////////////15
    ];


   // String studentName = '';
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(height: 1100,width: double.infinity,
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
                                  .guardianModel!.studentID!);
                            },
                            child: SizedBox(
                              width: screenSize.width / 2,
                              child: GoogleMonstserratWidgets(
                                overflow: TextOverflow.ellipsis,
                                text: UserCredentialsController
                                    .guardianModel!.guardianName!,
                                fontsize: 23,
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
                                          .guardianModel?.studentID ??
                                      '')
                                  .get(),
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  return GoogleMonstserratWidgets(
                                    text:
                                        'Student : ${snap.data?.data()?['studentName']}',
                                    fontsize: 14.5,
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
                                    fontsize: 13,
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
                              'email : ${UserCredentialsController.guardianModel?.guardianEmail ?? ""}',
                          fontsize: 12,
                          fontWeight: FontWeight.w500,
                          color: cblack.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
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
                                  .guardianModel!.profileImageURL ??
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
                        backgroundImage: AssetImage('assets/images/students.png'),
                      ),
                    ),
                  ],
                ),
                  
                   ],
                 ),
                 /////////////////////////////////////
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
                           // icon: Icons.note_sharp,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 10, bottom: 10),
                        child: ContainerWidget(
                          image: 'assets/flaticons/exam (1).png',
                            //icon: Icons.class_,
                            text: 'Class Test',
                            onTap: () {
                                Get.to(screenNavigationOfParent[14]);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10,left: 20),
                        child: ContainerWidget(
                          image: 'assets/flaticons/test.png',
                            //icon: Icons.view_list,
                            text: 'Monthly Class Test',
                            onTap: () {
                                Get.to(screenNavigationOfParent[14]);
                            }),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 10),
                      //   child: ContainerWidget(
                      //     image: '',
                      //       //icon: Icons.attach_money_rounded,
                      //       text: 'Fees & Bills',
                      //       onTap: () {}),
                      // ),
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
          ),
        ),
      ),
    );
  }
}

Widget MenuItem(int id, String image, String title, bool selected, onTap) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(image))),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ))
          ],
        ),
      ),
    ),
  );
}
