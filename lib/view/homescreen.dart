// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naviot/utilities/pallete.dart';
import 'package:naviot/utilities/route.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1924, 50, '50', Pallete.warningred),
      ChartData(1925, 35, '35', Pallete.green),
      ChartData(1926, 10, '10', Pallete.yellow),
    ];

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: _buildFleetCard(context, chartData),
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: _buildSectionTitle(context, 'Driver Activity'),
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  child: _buildDriverStats(context),
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: _buildSectionTitle(context, 'Violation Details'),
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 900),
                  child: _buildViolationDetails(context),
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 10),
                  child: _buildMenuSection(context),
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 20),
                  child: _buildRowWithGesture(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// AppBar Section
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Pallete.backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: SizedBox(
          height: 55,
          width: 71,
          child: Image.asset('asset/home/logo2.png', fit: BoxFit.contain),
        ),
      ),
      title: const SizedBox(),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: SizedBox(
            height: 26,
            width: 122,
            child: Image.asset('asset/home/Logo1.png'),
          ),
        ),
      ],
    );
  }

//1st container
  Widget _buildFleetCard(BuildContext context, List<ChartData> chartData) {
    return Container(
      height: Get.height * 0.3,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, top: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Pallete.homecards),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFleetInfo(context),
          _buildChart(chartData),
        ],
      ),
    );
  }

//contents in 1st container
  Column _buildFleetInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleContainer(context, 'Vehicles in Fleet'),
        const SizedBox(height: 15),
        Text('Real-Time Activity',
            style: _textStyle(context, 12, FontWeight.w500)),
        const SizedBox(height: 10),
        _buildStatusRow(context, Pallete.warningred, "Stopped"),
        const SizedBox(height: 5),
        _buildStatusRow(context, Pallete.green, "Moving"),
        const SizedBox(height: 5),
        _buildStatusRow(context, Pallete.yellow, "Idle"),
      ],
    );
  }

//vehicles in fleet container
  Widget _buildTitleContainer(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Pallete.textcolor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Pallete.backgroundColor,
                ),
          ),
        ),
      ),
    );
  }

  Row _buildStatusRow(BuildContext context, Color color, String status) {
    return Row(
      spacing: 8,
      children: [
        Icon(Icons.local_shipping_sharp, color: color),
        Text(status,
            style: _textStyle(
                context, 12, FontWeight.w500, Pallete.textfieldtext)),
      ],
    );
  }

  Widget _buildChart(List<ChartData> chartData) {
    return Expanded(
      child: SizedBox(
        child: SfCircularChart(
          series: <RadialBarSeries<ChartData, int>>[
            RadialBarSeries<ChartData, int>(
              useSeriesColor: true,
              trackOpacity: 0.3,
              radius: '90%',
              gap: '10%',
              cornerStyle: CornerStyle.bothCurve,
              dataSource: chartData,
              pointRadiusMapper: (ChartData data, _) => data.z,
              pointColorMapper: (ChartData data, _) => data.Color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
              widget: Container(
                width: Get.width * 0.2,
                height: Get.height * 0.055,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('asset/home/11.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      width: 123,
      height: 26,
      decoration: BoxDecoration(
        color: Pallete.textcolor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Pallete.backgroundColor,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildDriverStats(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDriverCard(context, '50', Pallete.warningred, 'UnAvailable'),
        _buildDriverCard(context, '35', Pallete.green, 'Active'),
        _buildDriverCard(context, '10', Pallete.yellow, 'Non-Active'),
      ],
    );
  }

//driver activity container
  Widget _buildDriverCard(
      BuildContext context, String count, Color color, String status) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.25;

    return Container(
      padding: const EdgeInsets.all(2),
      height: 75,
      width: cardWidth,
      decoration: BoxDecoration(
        border: Border.all(color: Pallete.homecards),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(count,
              style:
                  _textStyle(context, 24, FontWeight.w600, Pallete.textcolor)),
          Icon(Icons.local_shipping_sharp, color: color),
          Text(status,
              style: _textStyle(
                  context, 10, FontWeight.w500, Pallete.textfieldtext)),
        ],
      ),
    );
  }

// vehicle
  Widget _buildViolationDetails(BuildContext context) {
    return Container(
      height: Get.height * 0.23,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Pallete.textfieldtext.withOpacity(0.05),
        border: Border.all(color: Pallete.homecards),
        borderRadius: BorderRadius.circular(24),
      ),
      child: GridPaper(
        interval: 30.0,
        divisions: 1,
        subdivisions: 1,
        color: Pallete.textfieldtext.withOpacity(0.05),
        child: Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: _buildViolationColumn(
                context,
                Pallete.yellowgradient1,
                Pallete.yellowgradient2,
                'Pending',
                70,
              ),
            ),
            Flexible(
              flex: 3,
              child: _buildViolationColumn(
                context,
                Pallete.redgradient1,
                Pallete.redgradient2,
                'Total Violations',
                120,
              ),
            ),
            Flexible(
              flex: 2,
              child: _buildViolationColumn(
                context,
                Pallete.greengradient1,
                Pallete.greengradient2,
                'Completed',
                100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildViolationColumn(BuildContext context, Color gradientStart,
      Color gradientEnd, String text, double maxHeight) {
    // Generate a random 2-digit number
    final random = Random();
    final randomNumber =
        random.nextInt(90) + 10; // Generates a number between 10 and 99

    // Scale the height based on the random number (relative to maxHeight)
    final scaledHeight = (randomNumber / 100) * maxHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Black container with random number
        Container(
          height: 25,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              randomNumber.toString(),
              style: _textStyle(context, 14, FontWeight.bold, Colors.white),
            ),
          ),
        ),
        const SizedBox(
            height:
                8), // Add spacing between the black container and the gradient container
        Container(
          height: 31,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientStart, gradientEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              text,
              style:
                  _textStyle(context, 10, FontWeight.w500, Pallete.textcolor),
            ),
          ),
        ),
        Flexible(
          child: Container(
            width: 2,
            height: scaledHeight, // Dynamically adjust height based on number
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _textStyle(
      BuildContext context, double fontSize, FontWeight fontWeight,
      [Color? color]) {
    return GoogleFonts.poppins(
      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? Pallete.textfieldtext,
          ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      width: 90,
      height: 26,
      decoration: BoxDecoration(
        color: Pallete.textcolor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(
          'Menu',
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Pallete.backgroundColor,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowWithGesture(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildGestureCard(context, 'Core Tracking',
                'asset/home/Layer_1.svg', PageRouteName.CoreTracking),
            _buildGestureCard(context, 'Message Center',
                'asset/home/Layer_2.svg', PageRouteName.MessageCenter),
          ],
        ),
        _buildGestureCard(context, 'Report Center', 'asset/home/Layer_2.svg',
            PageRouteName.ReportCenter),
      ],
    );
  }

  GestureDetector _buildGestureCard(
      BuildContext context, String title, String assetPath, String routeName) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(routeName);
      },
      child: Container(
        height: 101,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          border: Border.all(color: Pallete.homecards),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 35,
                width: 35,
                child: SvgPicture.asset(
                  assetPath,
                  color: Pallete.textcolor,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.z, this.Color);
  final int x;
  final double y;
  final String z;
  final Color;
}
