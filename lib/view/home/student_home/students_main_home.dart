import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/drawer/student_drawer.dart';
import 'package:dujo_kerala_application/view/home/student_home/student_new_homepage.dart';
import 'package:dujo_kerala_application/view/pages/live_classes/students_room/list_room.dart';
import 'package:dujo_kerala_application/view/widgets/appbar_color/appbar_clr.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../../main.dart';
import '../../pages/chat_gpt/screens/chat_screen.dart';
import '../../pages/recorded_videos/select_subjects.dart';
import '../../pages/splash_screen/splash_screen.dart';

class StudentsMainHomeScreen extends StatefulWidget {
  // var schoolID;
  // var classID;
  // var studentEmailid;
  const StudentsMainHomeScreen(
      {
      //   required this.schoolID,
      // required this.classID,
      // required this.studentEmailid,
      Key? key})
      : super(key: key);

  @override
  State<StudentsMainHomeScreen> createState() => _StudentsMainHomeScreenState();
}

class _StudentsMainHomeScreenState extends State<StudentsMainHomeScreen> {
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkingSchoolActivate(context);
    List<Widget> pages = [
      const NewStdHomePage(), ///////////////////////////////////////////
      RecSelectSubjectScreen(
        batchId: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        schoolId: UserCredentialsController.schoolId!,
      ),
      const StudentsRoomListScreen(),
      const ChatScreen(),
    ];
    return WillPopScope(
      onWillPop: () => onbackbuttonpressed(context),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const AppBarColorWidget(),
          foregroundColor: cWhite,
          title: SizedBox(
            // color: cred,
            height: 80.h,
            width: 115.w,
            child: Center(
                child: Image.asset(
              'assets/images/vidyaveechi.png',
              color: Colors.white,
              fit: BoxFit.cover,
            )),
          ),
          //  backgroundColor: adminePrimayColor
        ),
        body: pages[_page],
        bottomNavigationBar: Container(
          height: 71,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border.all(color: Colors.white.withOpacity(0.13)),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                // Color.fromARGB(255, 222, 29, 151),
                // Color.fromARGB(255, 39, 48, 211)
                Color.fromARGB(255, 15, 73, 208),
                Color.fromARGB(255, 6, 152, 225),
                //  Color.fromARGB(255, 92, 168, 240),

                // Color.fromARGB(255, 6, 71, 157),
                // Color.fromARGB(255, 5, 85, 222)
              ],
            ),
          ),
          child: GNav(
            gap: 8,
            rippleColor: Colors.grey,
            activeColor: Colors.white,
            color: Colors.white,
            tabs: [
              GButton(
                  iconSize: 20,
                  icon: LineIcons.home,
                  text: 'Home'.tr,
                  style: GnavStyle.google),
              GButton(
                iconSize: 30,
                textSize: 20,
                icon: Icons.tv,
                text: 'Recorded\nClasses'.tr,
              ),
              GButton(
                iconSize: 30,
                // iconSize: 10,
                textSize: 20,
                icon: Icons.laptop,
                text: 'Live\nClasses'.tr,
              ),
              GButton(
                iconSize: 30,
                textSize: 20,
                icon: Icons.chat,
                text: 'Ask\nDoubt'.tr,
              )
            ],
            selectedIndex: _page,
            onTabChange: (value) {
              onPageChanged(value);
            },
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const StudentsHeaderDrawer(),
                MyDrawerList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
