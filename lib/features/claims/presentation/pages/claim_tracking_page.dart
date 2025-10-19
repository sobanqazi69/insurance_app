import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../../../policies/presentation/pages/policy_detail_page.dart';

class ClaimTrackingPage extends StatefulWidget {
  const ClaimTrackingPage({super.key});

  @override
  State<ClaimTrackingPage> createState() => _ClaimTrackingPageState();
}

class _ClaimTrackingPageState extends State<ClaimTrackingPage> {
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
                resizeToAvoidBottomInset: false,

        
        backgroundColor: AppColors.white,
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building ClaimTrackingPage: $e');
      return _buildErrorWidget(context);
    }
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildTimeline(context),
            _buildDoneButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.cyan.withOpacity(0.1),
            AppColors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Claim Tracking',
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.028,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            'Timeline of your claim',
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.016,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: Column(
        children: [
          _buildTimelineItem(
            context,
            'Submitted',
            'Successfully',
            true,
            isFirst: true,
          ),
          _buildTimelineItem(
            context,
            'Acknowledged',
            'Successfully',
            true,
          ),
          _buildTimelineItem(
            context,
            'Survey/Assessment',
            'Pending',
            false,
          ),
          _buildTimelineItem(
            context,
            'Documents Required',
            'Pending',
            false,
          ),
          _buildTimelineItem(
            context,
            'Approved/Rejected',
            'Pending',
            false,
          ),
          _buildTimelineItem(
            context,
            'Paid',
            'Pending',
            false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    String label,
    String status,
    bool isCompleted, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Column(
      children: [
        if (!isFirst)
          Container(
            height: 1.0,
            color: AppColors.border,
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.016,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.008,
              ),
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.cyan : const Color(0xFFFF9800),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                status,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.014,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.06,
        child: ElevatedButton(
          onPressed: () => _handleDoneButton(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 0,
          ),
          child: Text(
            'Done',
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.018,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _handleDoneButton(BuildContext context) {
    try {
      // Navigate back to policy detail page
      NavigationService.pushTo(context, const PolicyDetailPage());
    } catch (e) {
      debugPrint('Error handling done button: $e');
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text(
          'Error loading claim tracking',
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
