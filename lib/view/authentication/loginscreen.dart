import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naviot/controller/app_user_controller.dart';
import 'package:naviot/utilities/custom_dropdown.dart';
import 'package:naviot/utilities/custom_field.dart';
import 'package:naviot/utilities/pallete.dart';
import 'package:naviot/utilities/route.dart';
import '../../utilities/custom_button.dart';

final List<String> countries = ['India', 'United Kingdom', 'UAE', 'America'];
final List<String> languages = ['English', 'Arabic', 'Hindi'];

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final Rx<String?> selectedCountries = Rx<String?>(null);
    final Rx<String?> selectedLanguage = Rx<String?>(null);
    final AppuserController controller = Get.put(AppuserController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderImage(),
              _buildForm(
                  context, controller, selectedCountries, selectedLanguage),
            ],
          ),
        ),
      ),
    );
  }

  // Header Image
  Widget _buildHeaderImage() {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        'asset/signin/login.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  // Form Body
  Widget _buildForm(
    BuildContext context,
    AppuserController controller,
    Rx<String?> selectedCountries,
    Rx<String?> selectedLanguage,
  ) {
    return Padding(
      padding: const EdgeInsets.all(21.0),
      child: Column(
        spacing: 10,
        children: [
          const SizedBox(height: 10),
          _buildTitle(context, "Where’s your Ride?"),
          const SizedBox(height: 10),
          _buildCustomField(
              controller.usernameController, 'User name', context),
          _buildPasswordField(controller, context),
          _buildDropdownField(
              selectedCountries, countries, 'Select your country', context),
          _buildDropdownField(selectedLanguage, languages, 'Language', context),
          const SizedBox(height: 5),
          _buildTermsAndConditions(context),
          const SizedBox(height: 5),
          _buildLoginButton(context),
          _buildFooterText(context),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  // Title
  Widget _buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  // Custom Field (for username)
  Widget _buildCustomField(
      TextEditingController controller, String hintText, BuildContext context) {
    return SizedBox(
      height: 57,
      width: 319,
      child: Customfield(
        hintText: hintText,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  // Password Field with visibility toggle
  Widget _buildPasswordField(
      AppuserController controller, BuildContext context) {
    return SizedBox(
      height: 57,
      width: 319,
      child: Obx(
        () => TextFormField(
          keyboardType: TextInputType.text,
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible.value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Pallete.textfieldtext,
              ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Pallete.textformfieldbgc,
            hintText: 'Password',
            hintStyle: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Pallete.textfieldtext,
                  ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: InputBorder.none,
            suffixIcon: InkWell(
              onTap: controller.togglePasswordVisibility,
              child: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Pallete.textfieldtext,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dropdown Field
  Widget _buildDropdownField(Rx<String?> selectedItem, List<String> items,
      String hintText, BuildContext context) {
    return SizedBox(
      height: 57,
      width: 319,
      child: ReusableDropdown<String>(
        items: items,
        selectedItem: selectedItem,
        hintText: hintText,
        onChanged: (value) {
          selectedItem.value = value;
        },
      ),
    );
  }

  // Terms and Conditions Text
  Widget _buildTermsAndConditions(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Text(
        'By clicking on Login, you are agreeing to our term and conditions',
        style: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Pallete.textcolor,
              ),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Login Button
  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 319,
      child: CustomButton(
        text: 'Login',
        onPressed: () {
          Get.offNamed(PageRouteName.HomeScreen);
        },
      ),
    );
  }

  // Footer Text
  Widget _buildFooterText(BuildContext context) {
    return Text(
      'Powered by Way Track',
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Pallete.textcolor,
            ),
      ),
    );
  }
}
