import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naviot/utilities/pallete.dart';

class AppUtilities {
  static AppBar buildAppBar(BuildContext context, String Title) {
    var orientation = MediaQuery.of(context).orientation;
    double iconSize = orientation == Orientation.portrait ? 20 : 30;
    double textSize = orientation == Orientation.portrait ? 16 : 20;
    double appBarHeight = orientation == Orientation.portrait ? 80 : 100.0;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Pallete.backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: GestureDetector(
          onTap: Get.back,
          child: Container(
            height: Get.height * 0.05,
            width: Get.height * 0.05,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Pallete.textformfieldbgc,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: iconSize,
            ),
          ),
        ),
      ),
      title: Text(
        Title,
        style: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: textSize,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      centerTitle: false,
      toolbarHeight: appBarHeight,
    );
  }
}
