import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../../../getInsurance/presentation/widgets/insurance_progress_indicator.dart';
import '../../../getInsurance/presentation/widgets/insurance_next_button.dart';
import '../widgets/claim_header.dart';
import '../widgets/claim_dropdown_field.dart';
import '../widgets/claim_text_field.dart';
import 'claim_tracking_page.dart';

class Claim5Page extends StatefulWidget {
  const Claim5Page({super.key});

  @override
  State<Claim5Page> createState() => _Claim5PageState();
}

class _Claim5PageState extends State<Claim5Page> {
  final TextEditingController _bankAccountController = TextEditingController();
  String? _selectedBranch;

  @override
  void dispose() {
    _bankAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building Claim5Page: $e');
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
            _buildSubmitButton(context),
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
      child: const InsuranceProgressIndicator(currentStep: 5),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBankDetailsField(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildBankAccountField(context),
        ],
      ),
    );
  }

  Widget _buildBankDetailsField(BuildContext context) {
    return ClaimDropdownField(
      label: 'Bank Details',
      hintText: 'select Branch',
      value: _selectedBranch,
      items: const [
        'Allied Bank Limited',
        'Askari Bank Limited',
        'Bank Al Habib Limited',
        'Bank Alfalah Limited',
        'Citibank N.A.',
        'Faysal Bank Limited',
        'Habib Bank Limited',
        'MCB Bank Limited',
        'National Bank of Pakistan',
        'Standard Chartered Bank',
        'United Bank Limited',
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedBranch = newValue;
        });
      },
    );
  }

  Widget _buildBankAccountField(BuildContext context) {
    return ClaimTextField(
      label: 'Bank Account',
      hintText: 'Bank Account',
      controller: _bankAccountController,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: InsuranceNextButton(
        text: 'Submit',
        onPressed: () => _handleSubmitButton(context),
      ),
    );
  }

  void _handleSubmitButton(BuildContext context) {
    try {
      if (_selectedBranch == null || _bankAccountController.text.isEmpty) {
        debugPrint('Please fill all required fields');
        return;
      }
      debugPrint('Claim submitted successfully');
      // Navigate to claim tracking page
      NavigationService.pushTo(context, const ClaimTrackingPage());
    } catch (e) {
      debugPrint('Error handling submit button: $e');
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text(
          'Error loading bank details form',
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
