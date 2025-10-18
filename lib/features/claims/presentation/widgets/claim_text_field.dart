import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class ClaimTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final bool isRequired;

  const ClaimTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isRequired ? '$label *' : label,
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.016,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          TextField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.016,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              filled: false,
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w400,
                color: AppColors.textTertiary,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border, width: 1.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border, width: 1.0),
              ),
            ),
          ),
        ],
      );
    } catch (e) {
      debugPrint('Error building ClaimTextField: $e');
      return const SizedBox.shrink();
    }
  }
}
