// ignore_for_file: constant_identifier_names

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:naviot/view/authentication/loginscreen.dart';
import 'package:naviot/view/core_tracking.dart';
import 'package:naviot/view/homescreen.dart';
import 'package:naviot/view/message_screen.dart';
import 'package:naviot/view/report_center.dart';

List<GetPage<dynamic>>? getPagesroutes = [
  GetPage(
    name: PageRouteName.Login,
    page: () => const Login(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: PageRouteName.HomeScreen,
    page: () => const HomeScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: PageRouteName.CoreTracking,
    page: () => const CoreTracking(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: PageRouteName.MessageCenter,
    page: () => const MessageCenter(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: PageRouteName.ReportCenter,
    page: () => const ReportCenter(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
];

class PageRouteName {
  static const Login = '/Login';
  static const HomeScreen = '/Home';
  static const CoreTracking = '/tracking';
  static const MessageCenter = '/message';
  static const ReportCenter = '/report';
}
