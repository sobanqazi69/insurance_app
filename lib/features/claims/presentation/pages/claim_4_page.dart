import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../../../getInsurance/presentation/widgets/insurance_progress_indicator.dart';
import '../../../getInsurance/presentation/widgets/insurance_next_button.dart';
import '../widgets/claim_header.dart';
import '../widgets/claim_dashed_input_field.dart';
import 'claim_5_page.dart';

class Claim4Page extends StatefulWidget {
  const Claim4Page({super.key});

  @override
  State<Claim4Page> createState() => _Claim4PageState();
}

class _Claim4PageState extends State<Claim4Page> {
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building Claim4Page: $e');
      return _buildErrorWidget(context);
    }
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildProgressIndicator(context),
            _buildForm(context),
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return const ClaimHeader();
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
      child: const InsuranceProgressIndicator(currentStep: 4),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUploadField(context),
        ],
      ),
    );
  }

  Widget _buildUploadField(BuildContext context) {
    return ClaimDashedInputField(
      label: 'Upload',
      hintText: 'photos, FIR/DDR, bills, etc. per product',
      onTap: () {
        debugPrint('Upload field tapped');
        // TODO: Implement file upload functionality
      },
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: InsuranceNextButton(
        text: 'Next',
        onPressed: () => _handleNextButton(context),
      ),
    );
  }

  void _handleNextButton(BuildContext context) {
    try {
      debugPrint('Proceeding to bank details step');
      NavigationService.pushTo(context, const Claim5Page());
    } catch (e) {
      debugPrint('Error handling next button: $e');
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text(
          'Error loading upload form',
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
