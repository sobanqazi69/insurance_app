import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../../../claims/presentation/pages/claim_1_page.dart';

class PolicyDetailPage extends StatefulWidget {
  const PolicyDetailPage({super.key});

  @override
  State<PolicyDetailPage> createState() => _PolicyDetailPageState();
}

class _PolicyDetailPageState extends State<PolicyDetailPage> {
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building PolicyDetailPage: $e');
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
      'Policy detail',
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
      child: _buildPolicyDetailCard(context),
    );
  }

  Widget _buildPolicyDetailCard(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section - Insurer details
          _buildTopSection(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          // Bottom section - All actions in one row
          _buildActionsRow(context),
        ],
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Row(
      children: [
        // Left side - Insurer details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Insurer Detail Name
              Text(
                'Insurer Detail Name',
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              // Health
              Text(
                'Health',
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.016,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        // Right side - Status and plan
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Expired status tag
            _buildExpiredStatusTag(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // 5 year Plan
            Text(
              '5 year Plan',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.014,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpiredStatusTag(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03,
        vertical: MediaQuery.of(context).size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFCDD2), // Light red
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        'Expired',
        style: GoogleFonts.poppins(
          fontSize: MediaQuery.of(context).size.height * 0.012,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFD32F2F), // Dark red
        ),
      ),
    );
  }

  Widget _buildActionsRow(BuildContext context) {
    return Row(
      children: [
        // Download Receipt - smaller flex
        Expanded(
          flex: 2,
          child: _buildDownloadSection(context),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.015),
        // Start Claim button
        Expanded(
          flex: 2,
          child: _buildActionButton(
            context,
            'Start Claim',
            AppColors.cyan,
            AppColors.white,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.015),
        // Renew button
        Expanded(
          flex: 2,
          child: _buildActionButton(
            context,
            'Renew',
            const Color(0xFFD78E0F), // Orange color from user
            AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadSection(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleDownloadReceipt(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.01,
        ),
       
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/download_icon.svg',
             
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.008),
            Flexible(
              child: Text(
                'Download\nReceipt',
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.012,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDownloadReceipt(BuildContext context) {
    try {
      debugPrint('Download Receipt tapped');
      // Handle download receipt functionality
    } catch (e) {
      debugPrint('Error handling download receipt: $e');
    }
  }


  Widget _buildActionButton(
    BuildContext context,
    String text,
    Color backgroundColor,
    Color textColor,
  ) {
    return GestureDetector(
      onTap: () => _handleActionButton(context, text),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.045,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.014,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  void _handleActionButton(BuildContext context, String action) {
    try {
      debugPrint('$action button tapped');
      if (action == 'Start Claim') {
        NavigationService.pushTo(context, const Claim1Page());
      } else if (action == 'Renew') {
        // Handle renew functionality
        debugPrint('Renew functionality');
      }
    } catch (e) {
      debugPrint('Error handling $action: $e');
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
          'Policy detail',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Error loading policy detail',
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
