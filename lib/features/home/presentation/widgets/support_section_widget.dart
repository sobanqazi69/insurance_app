import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class SupportSectionWidget extends StatelessWidget {
  const SupportSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.025),
        child: Container(
          padding: EdgeInsets.all(screenHeight * 0.025),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'For more contact us',
                      style: GoogleFonts.poppins(
                        fontSize: screenHeight * 0.022,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Double text
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '24/7',
                            style: GoogleFonts.poppins(
                              fontSize: screenHeight * 0.045,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text: ' Support',
                            style: GoogleFonts.poppins(
                              fontSize: screenHeight * 0.025,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('Contact Us button tapped');
                        // Handle contact us action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF2CB69),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.015,
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Contact Us',
                        style: GoogleFonts.inter(
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.05),
              // Hand icon
              Image.asset(
                'assets/icons/hand.png',
                width: screenWidth * 0.2,
                height: screenHeight * 0.12,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading hand icon: $error');
                  return Icon(
                    Icons.waving_hand,
                    size: screenWidth * 0.15,
                    color: AppColors.warning,
                  );
                },
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building support section: $e');
      return const SizedBox.shrink();
    }
  }
}
