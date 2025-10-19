import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../widgets/insurance_app_bar.dart';
import '../widgets/insurance_progress_indicator.dart';
import '../widgets/insurance_selectable_option.dart';
import '../widgets/insurance_next_button.dart';
import '../widgets/insurance_instruction_text.dart';
import 'getInsurance_6_page.dart';

class GetInsurance5Page extends StatefulWidget {
  const GetInsurance5Page({super.key});

  @override
  State<GetInsurance5Page> createState() => _GetInsurance5PageState();
}

class _GetInsurance5PageState extends State<GetInsurance5Page> {
  String? selectedPaymentMethod;

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
      debugPrint('Error building GetInsurance5Page: $e');
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
            const InsuranceProgressIndicator(currentStep: 5),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            _buildPaymentMethodSection(context),
            _buildSummarySection(context),
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

  Widget _buildPaymentMethodSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(context, 'Choose your payment method'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceSelectableOption(
            iconPath: 'assets/icons/bank.svg',
            label: 'Bank',
            isSelected: selectedPaymentMethod == 'bank',
            onTap: () => _selectPaymentMethod('bank'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          InsuranceSelectableOption(
            iconPath: 'assets/icons/card.svg',
            label: 'Credit or debit card',
            isSelected: selectedPaymentMethod == 'card',
            onTap: () => _selectPaymentMethod('card'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          InsuranceSelectableOption(
            iconPath: 'assets/icons/wallet.svg',
            label: 'Wallet',
            isSelected: selectedPaymentMethod == 'wallet',
            onTap: () => _selectPaymentMethod('wallet'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          InsuranceSelectableOption(
            iconPath: 'assets/icons/paypal.svg',
            label: 'Paypal',
            isSelected: selectedPaymentMethod == 'paypal',
            onTap: () => _selectPaymentMethod('paypal'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.025,
        left: MediaQuery.of(context).size.width * 0.025,
        right: MediaQuery.of(context).size.width * 0.025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(context, 'Summary of taxes'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.border, width: 1.0),
            ),
            child: Column(
              children: [
                _buildSummaryRow(context, 'Tax Code', '1522835677'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                _buildSummaryRow(
                  context,
                  'Transaction time',
                  'July 30,2021 - 11:17',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.height * 0.02,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
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

  void _selectPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  void _handleNextButton(BuildContext context) {
    try {
      debugPrint('Next button tapped - navigating to step 6');
      NavigationService.pushTo(context, const GetInsurance6Page());
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
