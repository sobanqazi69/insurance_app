import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../../../getInsurance/presentation/widgets/insurance_progress_indicator.dart';
import '../../../getInsurance/presentation/widgets/insurance_next_button.dart';
import '../widgets/claim_header.dart';
import '../widgets/claim_text_field.dart';
import 'claim_3_page.dart';

class Claim2Page extends StatefulWidget {
  const Claim2Page({super.key});

  @override
  State<Claim2Page> createState() => _Claim2PageState();
}

class _Claim2PageState extends State<Claim2Page> {
  final TextEditingController _incidentController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _incidentController.dispose();
    _addressController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building Claim2Page: $e');
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
      child: const InsuranceProgressIndicator(currentStep: 2),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIncidentField(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildAddressField(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildTimeField(context),
        ],
      ),
    );
  }

  Widget _buildIncidentField(BuildContext context) {
    return ClaimTextField(
      label: 'Incident',
      hintText: 'Detail of incident',
      controller: _incidentController,
      maxLines: 4,
    );
  }

  Widget _buildAddressField(BuildContext context) {
    return ClaimTextField(
      label: 'Address',
      hintText: 'full address',
      controller: _addressController,
    );
  }

  Widget _buildTimeField(BuildContext context) {
    return ClaimTextField(
      label: 'Time',
      hintText: 'Enter Time',
      controller: _timeController,
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
      if (_incidentController.text.isEmpty || 
          _addressController.text.isEmpty || 
          _timeController.text.isEmpty) {
        debugPrint('Please fill all required fields');
        return;
      }
      NavigationService.pushTo(context, const Claim3Page());
    } catch (e) {
      debugPrint('Error handling next button: $e');
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text(
          'Error loading claim form',
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
