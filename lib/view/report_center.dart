import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naviot/utilities/app_utilities.dart';
import 'package:naviot/utilities/custom_button.dart';
import 'package:naviot/utilities/custom_dropdown.dart';
import 'package:naviot/utilities/pallete.dart';
import 'package:naviot/view/core_tracking.dart';

class ReportCenter extends StatelessWidget {
  const ReportCenter({super.key});

  get selectedCountries => null;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppUtilities.buildAppBar(context, 'Report Center'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titles(context, 'Select Group/ Vehicle'),
                  _buildDropdown(context, 'Select'),
                  _titles(context, 'Type of report'),
                  _buildDropdown(context, 'Select'),
                  Row(
                    spacing: 16,
                    children: [
                      Flexible(
                        child: Column(
                          spacing: 15,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titles(context, 'Start Time'),
                            _buildTimePicker(context, 'Select'),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          spacing: 15,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titles(context, 'End Time'),
                            _buildTimePicker(context, 'Select'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'Generate',
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _titles(BuildContext context, String titles) {
    return Text(
      titles,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  // Dropdown widget
  Widget _buildDropdown(BuildContext context, String title) {
    final Rx<String?> selectedAssets = Rx<String?>(null);
    return SizedBox(
      height: Get.height * 0.06,
      child: ReusableDropdown<String>(
        items: Assets,
        selectedItem: selectedAssets,
        hintText: title,
        onChanged: (value) {
          selectedAssets.value = value;
        },
      ),
    );
  }

//timepicker
  Widget _buildTimePicker(BuildContext context, String title) {
    final Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

    return SizedBox(
      height: Get.height * 0.06,
      child: Obx(() {
        return TextFormField(
          decoration: InputDecoration(
            hintText: selectedTime.value != null
                ? selectedTime.value!.format(context)
                : title,
            hintStyle: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Pallete.textfieldtext,
                  ),
            ),
            filled: true,
            fillColor: Pallete.textformfieldbgc,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon: const Icon(Icons.timer),
          ),
          readOnly: true,
          onTap: () async {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    dialogBackgroundColor: Pallete.backgroundColor,
                  ),
                  child: child ?? const SizedBox(),
                );
              },
            );
            if (pickedTime != null) {
              selectedTime.value = pickedTime;
            }
          },
        );
      }),
    );
  }
}
