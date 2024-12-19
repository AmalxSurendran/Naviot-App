// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppuserController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Add FocusNodes
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var hasPassError = false.obs;

  // Function to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Validation functions
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  // // Handle login and form validation
  // void validateAndLogin() {
  //   if (loginFormKey.currentState!.validate()) {
  //     // Proceed with login logic
  //     try {
  //       Get.toNamed(PageRouteName.HomeScreen); // Navigate to HomeScreen
  //       Get.snackbar(
  //         'Success',
  //         'Login successful!',
  //         icon: const Icon(Icons.check_circle, color: Colors.green),
  //         backgroundColor: Colors.black.withOpacity(0.05),
  //         colorText: Pallete.textcolor,
  //         snackPosition: SnackPosition.TOP,
  //         margin: const EdgeInsets.all(10),
  //         borderRadius: 10,
  //       );
  //     } catch (e) {
  //       log('Navigation failed: $e');
  //     }
  //   } else {
  //     // Show error message if form validation fails
  //     Get.snackbar(
  //       'Error',
  //       'Please correct the errors in the form.',
  //       icon: const Icon(Icons.close, color: Pallete.warningred),
  //       backgroundColor: Colors.black.withOpacity(0.05),
  //       colorText: Pallete.textcolor,
  //       snackPosition: SnackPosition.TOP,
  //       margin: const EdgeInsets.all(10),
  //       borderRadius: 10,
  //     );
  //   }
  // }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
