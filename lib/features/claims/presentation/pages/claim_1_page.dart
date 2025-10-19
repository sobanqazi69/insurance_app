import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../../../getInsurance/presentation/widgets/insurance_progress_indicator.dart';
import '../../../getInsurance/presentation/widgets/insurance_next_button.dart';
import '../widgets/claim_header.dart';
import '../widgets/claim_dropdown_field.dart';
import 'claim_2_page.dart';

class Claim1Page extends StatefulWidget {
  const Claim1Page({super.key});

  @override
  State<Claim1Page> createState() => _Claim1PageState();
}

class _Claim1PageState extends State<Claim1Page> {
  String? _selectedPolicy;

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building Claim1Page: $e');
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
      child: const InsuranceProgressIndicator(currentStep: 1),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyDropdown(context),
        ],
      ),
    );
  }

  Widget _buildPolicyDropdown(BuildContext context) {
    return ClaimDropdownField(
      label: 'Select Policy',
      hintText: 'Policy name',
      value: _selectedPolicy,
      items: const [
        'MotorSecure Basic - ABC Insurance',
        'HealthGuard Premium - XYZ Insurance',
        'LifeShield Plus - DEF Insurance',
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedPolicy = newValue;
        });
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
      if (_selectedPolicy == null) {
        debugPrint('Please select a policy');
        return;
      }
      NavigationService.pushTo(context, const Claim2Page());
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
