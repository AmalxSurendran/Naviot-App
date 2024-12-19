import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:naviot/utilities/pallete.dart';
import 'package:naviot/utilities/route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offNamed(PageRouteName.Login);
    });

    return Scaffold(
      backgroundColor: Pallete.splashbgcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'asset/splash/sample.json',
              height: 250,
            ),
          ],
        ),
      ),
    );
  }
}
