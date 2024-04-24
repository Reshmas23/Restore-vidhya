import 'package:flutter/material.dart';
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:get/get.dart';

import '../../../../../controllers/student_controller/profile_edit_controllers/parent_profile_edit_controller.dart';
import '../../../../widgets/fonts/google_poppins.dart';

// ignore: must_be_immutable
class ParentEditListileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final IconData? editicon;
  final VoidCallback voidCallback;
  String newEmail = "";
 final ParentProfileEditController parentProfileEditController =
      Get.put(ParentProfileEditController());

  ParentEditListileWidget({
    super.key,
    required this.voidCallback,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.editicon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: GooglePoppinsWidgets(
        text: title.tr,
        fontsize: 12.h,
      ),
      subtitle: GooglePoppinsWidgets(text: subtitle, fontsize: 19.h),
      trailing: InkWell(
        onTap: voidCallback,
        child: Icon(editicon),
      ),
    );
  }
}
