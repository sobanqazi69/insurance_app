import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class InsuranceSelectableOption extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const InsuranceSelectableOption({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.width * 0.08,
              decoration: BoxDecoration(
                color: AppColors.border.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            // Label
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.016,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ),
            // Checkmark (if selected)
            if (isSelected)
              Container(
                width: MediaQuery.of(context).size.width * 0.06,
                height: MediaQuery.of(context).size.width * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.cyan,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: AppColors.white,
                  size: MediaQuery.of(context).size.height * 0.016,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
