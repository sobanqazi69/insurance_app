import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class ClaimHeader extends StatelessWidget {
  const ClaimHeader({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      return Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
        child: Column(
          children: [
            Text(
              'Claim Now',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.028,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              'To claim your Insurance',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building ClaimHeader: $e');
      return const SizedBox.shrink();
    }
  }
}
