import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class InsuranceInputField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController controller;
  final String placeholder;
  final bool hasHelpIcon;
  final bool isPreFilled;
  final TextInputType? keyboardType;

  const InsuranceInputField({
    super.key,
    required this.label,
    required this.isRequired,
    required this.controller,
    required this.placeholder,
    this.hasHelpIcon = false,
    this.isPreFilled = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
            if (isRequired) ...[
              Text(
                ' *',
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.016,
                  fontWeight: FontWeight.w500,
                  color: AppColors.error,
                ),
              ),
            ],
            if (hasHelpIcon) ...[
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Container(
                width: MediaQuery.of(context).size.width * 0.05,
                height: MediaQuery.of(context).size.width * 0.05,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '?',
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height * 0.012,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          height: MediaQuery.of(context).size.height * 0.055,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.primary, width: 1.0),
          ),
          child: TextField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            controller: controller,
            keyboardType: keyboardType ?? _getKeyboardType(label),
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.016,
              fontWeight: FontWeight.w500,
              color: isPreFilled ? AppColors.primary : AppColors.textSecondary,
            ),
            decoration: InputDecoration(
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
                vertical: MediaQuery.of(context).size.height * 0.012,
              ),
              hintText: placeholder,
              hintStyle: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w400,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextInputType _getKeyboardType(String label) {
    switch (label.toLowerCase()) {
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
      case 'cnic':
        return TextInputType.phone;
      case 'address':
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }
}
