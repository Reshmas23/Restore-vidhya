
// import 'package:dujo_kerala_application/view/home/parent_home/school_parent_pages/carousel_slider.dart';
// import 'package:dujo_kerala_application/view/home/parent_home/school_parent_pages/container_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ParentProfileHomePage extends StatelessWidget {
//   const ParentProfileHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 220,
//                   decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.bottomLeft,
//                           end: Alignment.topRight,
//                           colors: [
//                             Color.fromARGB(255, 130, 192, 243),
//                             Color.fromARGB(153, 241, 240, 240),
//                             Color.fromARGB(255, 149, 226, 236),
//                             Color.fromARGB(99, 214, 212, 212),
//                             Color.fromARGB(255, 139, 233, 223)
//                           ]),

//                       // color: Color.fromARGB(192, 208, 191, 234),
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(45),
//                           bottomRight: Radius.circular(45))),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.only(left: screenSize.width / 30, top: 20),
//                   child: Text(
//                     "Welcome...",
//                     style: GoogleFonts.abel(
//                         fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.only(left: screenSize.width / 30, top: 50),
//                   child: Text(
//                     "Mr & Mrs...",
//                     style: GoogleFonts.robotoSlab(
//                         fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.only(left: screenSize.width / 1.4, top: 30),
//                   child: const CircleAvatar(
//                     maxRadius: 40,
//                     backgroundImage: AssetImage('assets/images/IOT.jpg'),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.only(left: screenSize.width / 1.3, top: 130),
//                   child: Text(
//                     "NAME:",
//                     style: GoogleFonts.robotoSlab(
//                         fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.only(left: screenSize.width / 1.3, top: 150),
//                   child: Text(
//                     "STD 8A",
//                     style: GoogleFonts.anekMalayalam(fontSize: 11),
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(left: 40, top: 110),
//                 //   child: Container(
//                 //     height: 120,
//                 //     width: 150,
//                 //     decoration: const BoxDecoration(
//                 //         image: DecorationImage(
//                 //             image: AssetImage('assets/images/company.jpg'))),
//                 //   ),
//                 // ),
//                 Padding(
//                   padding:
//                       EdgeInsets.only(left: screenSize.width / 7, top: 180),
//                   child: const CircleAvatar(
//                     maxRadius: 40,
//                     backgroundImage: AssetImage('assets/images/company.jpg'),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.only(left: screenSize.width / 2.5, top: 180),
//                   child: const CircleAvatar(
//                     maxRadius: 40,
//                     backgroundImage: AssetImage('assets/images/AI.jpg'),
//                   ),
//                 ),
//               ],
//             ),
//             const CarouselSliderWidget(),
//             Container(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     // crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, top: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.waving_hand,
//                               text: ' Attendance',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.home_work,
//                               text: 'Homework',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, top: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.assignment_rounded,
//                               text: 'Time Table',
//                               onTap: () {}),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.person_2,
//                               text: 'Teachers',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.attach_money_rounded,
//                               text: 'Fees & Bills',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.note_sharp,
//                               text: 'Leave Letters',
//                               onTap: () {}),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.list_alt,
//                               text: 'Exams',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.add_chart,
//                               text: 'Exam Results',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.notification_add,
//                               text: 'Notices',
//                               onTap: () {}),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.event, text: 'Events', onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.meeting_room,
//                               text: 'Meetings',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.bus_alert,
//                               text: 'Bus Route',
//                               onTap: () {}),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.class_,
//                               text: 'Class Test',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.view_list,
//                               text: 'Monthly Class Test',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.library_books,
//                               text: 'Library',
//                               onTap: () {}),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.food_bank,
//                               text: 'Canteen',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.chat_rounded,
//                               text: 'Chats',
//                               onTap: () {}),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 10, right: 10, bottom: 10),
//                           child: ContainerWidget(
//                               icon: Icons.import_contacts,
//                               text: 'Subjects',
//                               onTap: () {}),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
