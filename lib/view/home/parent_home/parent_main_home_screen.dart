import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_new_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../../controllers/userCredentials/user_credentials.dart';
import '../../../main.dart';
import '../../pages/recorded_videos/select_subjects.dart';
import '../../pages/splash_screen/splash_screen.dart';
import '../drawer/parent_drawer.dart';
import '../student_home/Student Edit Profile/parent_edit_profile.dart';

class ParentMainHomeScreen extends StatefulWidget {
  const ParentMainHomeScreen({Key? key}) : super(key: key);

  @override
  State<ParentMainHomeScreen> createState() => _ParentMainHomeScreenState();
}

class _ParentMainHomeScreenState extends State<ParentMainHomeScreen> {
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
    log("Stundent IDD :::: ${UserCredentialsController.parentModel!.studentID}");
    checkingSchoolActivate(context);
    List<Widget> pages = [
   ParentProfileHomePage( studentName: UserCredentialsController.parentModel!.studentID!,),
      RecSelectSubjectScreen(
        batchId: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        schoolId: UserCredentialsController.schoolId!,
      ),
      const ParentEditProfileScreen()
    ];
    return WillPopScope(
      onWillPop: () => onbackbuttonpressed(context),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          flexibleSpace: const ParentAppBarColor(),
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
          backgroundColor: adminePrimayColor,
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
                      colors: [
                        Color.fromARGB(255, 139, 195, 248),
                        Color.fromARGB(255, 6, 152, 225),
                        Color.fromARGB(255, 15, 73, 208),
                         Color.fromARGB(255, 130, 192, 243),
                      Color.fromARGB(255, 39, 48, 211),
                     Color.fromARGB(255, 6, 152, 225),
                    Color.fromARGB(255, 139, 233, 223)
                      ],
                      end: Alignment.topLeft,
                      begin: Alignment.bottomRight,
                    ),
                    color: adminePrimayColor
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
                icon: Icons.assignment_ind_outlined,
                textSize: 20,
                text: 'Profile'.tr,
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
                ParentHeaderDrawer(),
                MyDrawerList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ParentAppBarColor extends StatelessWidget {
  const ParentAppBarColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 139, 195, 248),
                        Color.fromARGB(255, 6, 152, 225),
                        Color.fromARGB(255, 15, 73, 208),
                         Color.fromARGB(255, 130, 192, 243),
                      Color.fromARGB(255, 39, 48, 211),
                     Color.fromARGB(255, 6, 152, 225),
                    Color.fromARGB(255, 139, 233, 223)
            ]),
      ),
    );
  }
}