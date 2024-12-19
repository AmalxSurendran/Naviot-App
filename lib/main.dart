import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naviot/controller/app_user_controller.dart';
import 'package:naviot/utilities/pallete.dart';
import 'package:naviot/utilities/route.dart';
import 'package:naviot/view/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Pallete.backgroundColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      getPages: getPagesroutes,
      initialBinding: BindingsBuilder(
        () {
          Get.lazyPut(() => AppuserController());
        },
      ),
    );
  }
}
