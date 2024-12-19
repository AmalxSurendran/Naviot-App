import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naviot/utilities/app_utilities.dart';
import 'package:naviot/utilities/custom_dropdown.dart';
import 'package:naviot/utilities/pallete.dart';
import 'package:naviot/view/core_tracking.dart';

class MessageCenter extends StatelessWidget {
  const MessageCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtilities.buildAppBar(context, 'Message Center'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAlertDropdown(context),
                    _buildAllDropdown(context),
                  ],
                ),
                Text(
                  'Messages Read Status: 0/77',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                FadeInUp(child: _buildMessagecard(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Alert Dropdown widget
  Widget _buildAlertDropdown(BuildContext context) {
    final Rx<String?> selectedAssets = Rx<String?>(null);
    return SizedBox(
      height: Get.height * 0.05,
      width: Get.width * 0.65,
      child: ReusableDropdown<String>(
        items: Assets,
        selectedItem: selectedAssets,
        hintText: 'Alert',
        onChanged: (value) {
          selectedAssets.value = value;
        },
      ),
    );
  }

//All Dropdown widget
  Widget _buildAllDropdown(BuildContext context) {
    final Rx<String?> selectedAssets = Rx<String?>(null);
    return SizedBox(
      height: Get.height * 0.05,
      width: Get.width * 0.21,
      child: ReusableDropdown<String>(
        items: Assets,
        selectedItem: selectedAssets,
        hintText: 'All',
        onChanged: (value) {
          selectedAssets.value = value;
        },
      ),
    );
  }

  Widget _buildMessagecard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Pallete.homecards),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Badge(
              isLabelVisible: true,
              offset: Offset(8, 8),
              child: Icon(
                Icons.message_outlined,
                color: Colors.blue,
              ),
            ),
          ),
          _buildAssetInfo(context),
          _buildButtons(context, 'View Location', 'Show Details'),
        ],
      ),
    );
  }

  Widget _buildAssetInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        _buildQuestionAnswer(
          context,
          'Asset',
          'Urbania KL-07 DD 4141',
          const Icon(
            Icons.local_shipping_sharp,
            color: Pallete.textcolor,
          ),
        ),
        _buildQuestionAnswer(
          context,
          'Type',
          'Trip Stoped (0)',
          const Icon(
            Icons.campaign_outlined,
            color: Pallete.warningred,
          ),
        ),
        _buildQuestionAnswer(
          context,
          'Time',
          '11:07 | 03.12.2024',
          const Icon(
            Icons.timer_outlined,
            color: Pallete.textcolor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionAnswer(
      BuildContext context, String labeltext, String text, Icon Icon) {
    return Row(
      children: [
        //icon section
        Expanded(flex: 1, child: Icon),
        // Question section
        Expanded(
          flex: 2,
          child: Text(
            labeltext,
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),

        // Answer section
        Expanded(
          flex: 3,
          child: Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  Row _buildButtons(BuildContext context, String Title1, String Title2) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Pallete.textcolor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                Title1,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Pallete.backgroundColor,
                      ),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Pallete.textcolor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                Title2,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Pallete.backgroundColor,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
