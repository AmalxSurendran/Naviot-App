// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naviot/utilities/app_utilities.dart';
import 'package:naviot/utilities/custom_dropdown.dart';
import 'package:naviot/utilities/custom_field.dart';
import 'package:naviot/utilities/pallete.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final List<String> Assets = [
  'KL24C2102',
  'MH56F2102',
  'UAE123',
  'U145',
];
final List<ChartData> chartData = [
  ChartData(1924, 50, '50', Pallete.warningred),
  ChartData(1925, 35, '35', Pallete.green),
  ChartData(1926, 10, '10', Pallete.yellow),
];

class CoreTracking extends StatefulWidget {
  const CoreTracking({super.key});

  @override
  State<CoreTracking> createState() => _CoreTrackingState();
}

class _CoreTrackingState extends State<CoreTracking> {
  final coreFormKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  void _refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtilities.buildAppBar(context, 'Core Tracking'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: coreFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDropdown(context),
                      _buildRefreshButton(context),
                    ],
                  ),
                  const SizedBox(height: 25),
                  FadeInUp(child: _buildLayout(context)),
                  FadeInUp(child: _buildSearch(context)),
                  const SizedBox(height: 20),
                  FadeInUp(child: _buildAssetcard(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dropdown widget
  Widget _buildDropdown(BuildContext context) {
    final Rx<String?> selectedAssets = Rx<String?>(null);
    return SizedBox(
      height: Get.height * 0.05,
      width: Get.width * 0.7,
      child: ReusableDropdown<String>(
        items: Assets,
        selectedItem: selectedAssets,
        hintText: 'All Assets',
        onChanged: (value) {
          selectedAssets.value = value;
        },
      ),
    );
  }

  // Refresh button

  Widget _buildRefreshButton(BuildContext context) {
    return GestureDetector(
      onTap: _refreshPage,
      child: Container(
        height: Get.height * 0.05,
        width: Get.width * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Pallete.textformfieldbgc,
        ),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  // Layout for fleet info and chart
  Widget _buildLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildFleetInfo(context),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: _buildChart(chartData, context),
        ),
      ],
    );
  }

  // Search bar widget
  Widget _buildSearch(BuildContext context) {
    return Customfield(
      hintText: 'Search assets info',
      prefixIcon: Icon(Icons.search),
      controller: searchController,
      keyboardType: TextInputType.emailAddress,
    );
  }

//Asset Card
  Widget _buildAssetcard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Pallete.homecards),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEnginecard(context),
          _AssetImage(context),
          const Divider(
            color: Pallete.textformfieldbgc,
            thickness: 2,
          ),
          _buildAssetInfo(context),
          _buildButtons(context),
        ],
      ),
    );
  }

  // Fleet info section
  Widget _buildFleetInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total number of assets',
            style: _textStyle(context, 12, FontWeight.w500)),
        const SizedBox(height: 5),
        _buildStatusRow(context, Pallete.warningred, "Stopped"),
        _buildStatusRow(context, Pallete.green, "Moving"),
        _buildStatusRow(context, Pallete.yellow, "Idle"),
      ],
    );
  }

  // Chart display
  Widget _buildChart(List<ChartData> chartData, BuildContext context) {
    double chartHeight = MediaQuery.of(context).size.height * 0.2;
    double chartWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: chartHeight,
      width: chartWidth,
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
              height: Get.height * 0.04,
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
    );
  }

  // Status row with icon and text
  Widget _buildStatusRow(BuildContext context, Color color, String status) {
    return Row(
      children: [
        Icon(Icons.local_shipping_sharp, color: color),
        const SizedBox(width: 8),
        Text(status,
            style: _textStyle(
                context, 12, FontWeight.w500, Pallete.textfieldtext)),
      ],
    );
  }

  // Text style helper function
  TextStyle _textStyle(
      BuildContext context, double fontSize, FontWeight fontWeight,
      [Color? color]) {
    return GoogleFonts.poppins(
      textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? Pallete.textfieldtext,
          ),
    );
  }

  Row _buildEnginecard(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Timer Icon
        const Icon(
          Icons.timer_outlined,
        ),

        // Date & Time Column
        const Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('05:21 PM'),
              Text(
                '02.12.2024',
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Spacer(),

        // Container with Asset Text
        Flexible(
          flex: 2,
          child: _buildcontainerAsset(context),
        ),
        const SizedBox(width: 8),

        // Engine Button
        Flexible(
          flex: 2,
          child: _buildEnginebutton(context),
        ),
      ],
    );
  }

  Widget _buildcontainerAsset(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Pallete.textcolor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(
          '003654',
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

  Widget _buildEnginebutton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Pallete.textformfieldbgc,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Engine',
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(
            width: 30,
            child: Divider(
              thickness: 5,
              color: Pallete.green,
            ),
          )
        ],
      ),
    );
  }

  Widget _AssetImage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Image.asset(
            'asset/tracking/imagee.png',
            fit: BoxFit.contain,
          ),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Pallete.textformfieldbgc,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Image.asset(
              'asset/tracking/image2.png',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssetInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        _buildQuestionAnswer(
          context,
          'Asset Info',
          'Urbania KL-07 DD 4141',
          const Icon(
            Icons.local_shipping_sharp,
            color: Pallete.green,
          ),
        ),
        _buildQuestionAnswer(
          context,
          'Location',
          'Medicare Hospital, kodungalur, Thrissur, Kerala, മെഡികെയർ ഹോസ്പിറ്റൽ, കൊടുങ്ങല്ലൂർ, തൃശൂർ, കേരളം,',
          const Icon(
            Icons.location_on_outlined,
            color: Pallete.textcolor,
          ),
        ),
        _buildQuestionAnswer(
          context,
          'driver Info',
          'Joby',
          const Icon(
            Icons.directions_car_filled_outlined,
            color: Pallete.textcolor,
          ),
        ),
        const Row(
            spacing: 25,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                color: Pallete.green,
              ),
              Icon(
                Icons.message,
                color: Pallete.green,
              ),
            ])
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
                    fontWeight: FontWeight.w500,
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

  Row _buildButtons(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Pallete.textcolor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              'View',
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
        Container(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Pallete.textcolor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              'Route',
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
      ],
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
