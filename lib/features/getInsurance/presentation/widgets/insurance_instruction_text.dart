import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class InsuranceInstructionText extends StatelessWidget {
  const InsuranceInstructionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'To claim this Insurance Plan Complete These steps',
      style: GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.height * 0.016,
        fontWeight: FontWeight.w400,
        color: AppColors.primary,
      ),
      textAlign: TextAlign.center,
    );
  }
}
