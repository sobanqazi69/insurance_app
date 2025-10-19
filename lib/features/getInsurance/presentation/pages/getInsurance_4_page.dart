import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../widgets/insurance_app_bar.dart';
import '../widgets/insurance_progress_indicator.dart';
import '../widgets/insurance_dashed_input_field.dart';
import '../widgets/insurance_next_button.dart';
import '../widgets/insurance_instruction_text.dart';
import 'getInsurance_5_page.dart';

class GetInsurance4Page extends StatefulWidget {
  const GetInsurance4Page({super.key});

  @override
  State<GetInsurance4Page> createState() => _GetInsurance4PageState();
}

class _GetInsurance4PageState extends State<GetInsurance4Page> {
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
      debugPrint('Error building GetInsurance4Page: $e');
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
            const InsuranceProgressIndicator(currentStep: 4),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            _buildDocumentUploadForm(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            InsuranceNextButton(
              text: 'Next',
              onPressed: () => _handleNextButton(context),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentUploadForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsuranceDashedInputField(
            label: 'CNIC',
            placeholder: 'Upload cnic front and back Picture',
            onTap: () => _handleCnicUpload(context),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceDashedInputField(
            label: 'Selfie',
            placeholder: 'Take a Selfi (Liveness)',
            onTap: () => _handleSelfieCapture(context),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceDashedInputField(
            label: 'Ownership',
            placeholder: 'Upload Ownership/invoice etc.',
            onTap: () => _handleOwnershipUpload(context),
          ),
        ],
      ),
    );
  }

  void _handleCnicUpload(BuildContext context) {
    try {
      debugPrint('CNIC upload tapped');
      // TODO: Implement CNIC upload functionality
    } catch (e) {
      debugPrint('Error handling CNIC upload: $e');
    }
  }

  void _handleSelfieCapture(BuildContext context) {
    try {
      debugPrint('Selfie capture tapped');
      // TODO: Implement selfie capture functionality
    } catch (e) {
      debugPrint('Error handling selfie capture: $e');
    }
  }

  void _handleOwnershipUpload(BuildContext context) {
    try {
      debugPrint('Ownership upload tapped');
      // TODO: Implement ownership upload functionality
    } catch (e) {
      debugPrint('Error handling ownership upload: $e');
    }
  }

  void _handleNextButton(BuildContext context) {
    try {
      debugPrint('Next button tapped - navigating to step 5');
      NavigationService.pushTo(context, const GetInsurance5Page());
    } catch (e) {
      debugPrint('Error handling next button: $e');
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
          'Error loading form',
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
