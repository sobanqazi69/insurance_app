import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class InsuranceProgressIndicator extends StatelessWidget {
  final int currentStep;

  const InsuranceProgressIndicator({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final stepWidth = screenWidth / 6;
        final circleSize = MediaQuery.of(context).size.width * 0.08;
        final circleRadius = circleSize / 2;
        
        return Stack(
          children: [
            // Connecting lines between circles
            ...List.generate(5, (index) {
              final leftPosition = stepWidth * (index + 0.5) + circleRadius;
              final rightPosition = stepWidth * (index + 1.5) - circleRadius;
              final lineWidth = rightPosition - leftPosition;
              final isActiveLine = index < currentStep - 1; // Lines before current step are active
              
              return Positioned(
                top: circleRadius - 1,
                left: leftPosition,
                child: Container(
                  width: lineWidth,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: isActiveLine ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                ),
              );
            }),
            // Circles
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                final isActive = index == currentStep - 1; // Current step is active
                return SizedBox(
                  width: stepWidth,
                  child: _buildProgressStep(context, index + 1, isActive),
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgressStep(BuildContext context, int stepNumber, bool isActive) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.08,
      height: MediaQuery.of(context).size.width * 0.08,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.border,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          stepNumber.toString(),
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.014,
            fontWeight: FontWeight.w600,
            color: isActive ? AppColors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
