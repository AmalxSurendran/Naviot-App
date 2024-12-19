import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naviot/utilities/pallete.dart';

class ReusableDropdown<T> extends StatelessWidget {
  final List<T> items;
  final Rx<T?> selectedItem;
  final String hintText;
  final String? Function(T?)? validator;
  final void Function(T?) onChanged;

  const ReusableDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.hintText,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          decoration: BoxDecoration(
            color: Pallete.textformfieldbgc,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 8),
            child: DropdownButtonFormField2<T>(
              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              hint: Text(
                hintText,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Pallete.textfieldtext,
                      ),
                ),
              ),
              items: items
                  .map((item) => DropdownMenuItem<T>(
                        value: item,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Pallete.textfieldtext,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              value: selectedItem.value,
              validator: validator,
              onChanged: (value) {
                onChanged(value);
              },
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Pallete.textfieldtext,
                  size: 24,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Pallete.backgroundColor,
                ),
                width: Get.width * 0.6,
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              buttonStyleData: const ButtonStyleData(
                height: 50,
                width: double.infinity,
              ),
            ),
          ),
        );
      },
    );
  }
}
