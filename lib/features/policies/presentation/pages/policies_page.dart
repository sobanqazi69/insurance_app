import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import 'policy_detail_page.dart';

class PoliciesPage extends StatefulWidget {
  const PoliciesPage({super.key});

  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building PoliciesPage: $e');
      return _buildErrorWidget(context);
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: _buildBackButton(context),
      title: _buildTitle(),
      centerTitle: true,
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      onPressed: () => _handleBackNavigation(context),
      icon: const Icon(
        Icons.arrow_back_ios,
        color: AppColors.primary,
        size: 20.0,
      ),
    );
  }

  void _handleBackNavigation(BuildContext context) {
    try {
      NavigationService.pop(context);
    } catch (e) {
      debugPrint('Error handling back navigation: $e');
    }
  }

  Widget _buildTitle() {
    return Text(
      'Policies',
      style: GoogleFonts.poppins(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: Column(
        children: [
          _buildPolicyCard(
            context,
            'MotorSecure Basic - ABC Insurance',
            '8643543543',
            'Pending',
            '12 / 23 / 2025',
            PolicyStatus.pending,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildPolicyCard(
            context,
            'MotorSecure Basic - ABC Insurance',
            '8643543543',
            'Expired',
            '12 / 23 / 2025',
            PolicyStatus.expired,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildPolicyCard(
            context,
            'MotorSecure Basic - ABC Insurance',
            '8643543543',
            'Active',
            '12 / 23 / 2025',
            PolicyStatus.active,
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyCard(
    BuildContext context,
    String policyName,
    String claimId,
    String statusText,
    String expiryDate,
    PolicyStatus status,
  ) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Car icon and policy details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Car icon
                        Icon(
                          Icons.directions_car,
                          color: AppColors.cyan,
                          size: MediaQuery.of(context).size.height * 0.025,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        // Policy name
                        Expanded(
                          child: Text(
                            policyName,
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.height * 0.016,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    // Claim ID
                    Text(
                      'Claim ID : $claimId',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.014,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Right side - Status and expiry date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Status tag
                  _buildStatusTag(context, statusText, status),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  // Expiry date
                  Text(
                    expiryDate,
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height * 0.014,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          // View Details button
          _buildViewDetailsButton(context),
        ],
      ),
    );
  }

  Widget _buildStatusTag(BuildContext context, String statusText, PolicyStatus status) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case PolicyStatus.pending:
        backgroundColor = const Color(0xFFFFE0B2); // Light orange-yellow
        textColor = const Color(0xFFD2691E); // Dark orange-brown
        break;
      case PolicyStatus.expired:
        backgroundColor = const Color(0xFFFFCDD2); // Light pink-red
        textColor = const Color(0xFFD32F2F); // Dark red
        break;
      case PolicyStatus.active:
        backgroundColor = const Color(0xFFE0F2F1); // Light teal-cyan
        textColor = const Color(0xFF00695C); // Dark teal-cyan
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03,
        vertical: MediaQuery.of(context).size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: textColor.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: Text(
        statusText,
        style: GoogleFonts.poppins(
          fontSize: MediaQuery.of(context).size.height * 0.012,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildViewDetailsButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleViewDetails(context),
      child: Text(
        'View Details',
        style: GoogleFonts.poppins(
          fontSize: MediaQuery.of(context).size.height * 0.016,
          fontWeight: FontWeight.w600,
          color: AppColors.cyan,
        ),
      ),
    );
  }

  void _handleViewDetails(BuildContext context) {
    try {
      NavigationService.pushTo(context, const PolicyDetailPage());
    } catch (e) {
      debugPrint('Error navigating to policy detail: $e');
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.cyan,
        elevation: 0,
        leading: IconButton(
          onPressed: () => NavigationService.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
        ),
        title: Text(
          'Policies',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Error loading policies',
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

enum PolicyStatus {
  pending,
  expired,
  active,
}