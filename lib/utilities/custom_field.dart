import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naviot/utilities/pallete.dart';

class Customfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? child;
  final bool showSuffixIcon;
  final Icon? prefixIcon;
  final RxBool? isPasswordVisible;
  final VoidCallback? onSuffixIconTap;

  const Customfield({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.showSuffixIcon = false,
    this.isPasswordVisible,
    this.onSuffixIconTap,
    this.validator,
    this.prefixIcon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Pallete.textfieldtext,
              ),
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
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
            prefixIcon: prefixIcon,
            suffixIcon: showSuffixIcon
                ? InkWell(
                    onTap: onSuffixIconTap,
                    child: Icon(
                      isPasswordVisible?.value == true
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Pallete.textfieldtext,
                    ),
                  )
                : null,
          ),
          validator: validator,
        ),
        if (child != null) ...[
          const SizedBox(height: 10),
          child!,
        ],
      ],
    );
  }
}
