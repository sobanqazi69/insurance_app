import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class ClaimDashedInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final VoidCallback? onTap;
  final bool isRequired;

  const ClaimDashedInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.onTap,
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
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: double.infinity,
              child: CustomPaint(
                painter: DashedBorderPainter(),
                child: Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                  child: Center(
                    child: Text(
                      hintText,
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.016,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } catch (e) {
      debugPrint('Error building ClaimDashedInputField: $e');
      return const SizedBox.shrink();
    }
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 12.0;
    const dashSpace = 8.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }

    startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(startX + dashWidth, size.height),
        paint,
      );
      startX += dashWidth + dashSpace;
    }

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }

    startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width, startY),
        Offset(size.width, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
