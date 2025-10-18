import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../widgets/insurance_app_bar.dart';
import '../widgets/insurance_progress_indicator.dart';
import '../widgets/insurance_instruction_text.dart';
import 'getInsurance_7_page.dart';

class GetInsurance6Page extends StatefulWidget {
  const GetInsurance6Page({super.key});

  @override
  State<GetInsurance6Page> createState() => _GetInsurance6PageState();
}

class _GetInsurance6PageState extends State<GetInsurance6Page> {
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building GetInsurance6Page: $e');
      return _buildErrorWidget(context);
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return const InsuranceAppBar(title: 'Askari Health Insurance');
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const InsuranceInstructionText(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const InsuranceProgressIndicator(currentStep: 6),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            _buildSuccessIcon(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            _buildTransactionDetails(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            _buildActionButtons(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer circle with dots
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: AppColors.cyan.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                // Dots around the circle
                ...List.generate(8, (index) {
                  final angle = (index * 45) * (3.14159 / 180);
                  final radius = MediaQuery.of(context).size.width * 0.12;
                  final x = radius * math.cos(angle);
                  final y = radius * math.sin(angle);
                  
                  return Positioned(
                    left: MediaQuery.of(context).size.width * 0.15 + x - 3,
                    top: MediaQuery.of(context).size.width * 0.15 + y - 3,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.cyan,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          // Inner circle with checkmark
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              color: AppColors.cyan,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: AppColors.white,
              size: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.border, width: 1.0),
      ),
      child: Column(
        children: [
          _buildTransactionRow(context, 'Trading Code', '1522835677'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildTransactionRow(context, 'Trading Code', '1522835677'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildTransactionRow(context, 'Trading Code', '1522835677'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildTransactionRow(context, 'Transaction time', 'July 30, 2021 - 11:17'),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.016,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.016,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Download Receipt Button
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.06,
          child: OutlinedButton(
            onPressed: () => _handleDownloadReceipt(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary, width: 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              'Download\nReceipt',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.018,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        // Done Button
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.05,
          child: ElevatedButton(
            onPressed: () => _handleDone(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              'Done',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.018,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        // Inspection Button
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.05,
          child: ElevatedButton(
            onPressed: () => _handleInspection(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cyan,
              foregroundColor: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              'Inspection',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.018,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleDownloadReceipt(BuildContext context) {
    try {
      debugPrint('Download Receipt tapped');
      // TODO: Implement download receipt functionality
    } catch (e) {
      debugPrint('Error handling download receipt: $e');
    }
  }

  void _handleDone(BuildContext context) {
    try {
      debugPrint('Done tapped');
      // TODO: Navigate back to home or close the flow
      NavigationService.pop(context);
    } catch (e) {
      debugPrint('Error handling done: $e');
    }
  }

  void _handleInspection(BuildContext context) {
    try {
      debugPrint('Inspection tapped');
      NavigationService.pushTo(context, const GetInsurance7Page());
    } catch (e) {
      debugPrint('Error handling inspection: $e');
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => NavigationService.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
        ),
        title: Text(
          'Askari Health Insurance',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Error loading page',
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

