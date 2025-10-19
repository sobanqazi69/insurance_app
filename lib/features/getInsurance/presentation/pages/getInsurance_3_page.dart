import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../widgets/insurance_app_bar.dart';
import '../widgets/insurance_progress_indicator.dart';
import '../widgets/insurance_input_field.dart';
import '../widgets/insurance_next_button.dart';
import '../widgets/insurance_instruction_text.dart';
import 'getInsurance_4_page.dart';

class GetInsurance3Page extends StatefulWidget {
  const GetInsurance3Page({super.key});

  @override
  State<GetInsurance3Page> createState() => _GetInsurance3PageState();
}

class _GetInsurance3PageState extends State<GetInsurance3Page> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _preExistingController = TextEditingController();
  final TextEditingController _nomineeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _genderController.dispose();
    _preExistingController.dispose();
    _nomineeController.dispose();
    super.dispose();
  }

  void _initializeForm() {
    try {
      _ageController.text = '30';
      _genderController.text = 'Male';
    } catch (e) {
      debugPrint('Error initializing form: $e');
    }
  }

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
      debugPrint('Error building GetInsurance3Page: $e');
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
            const InsuranceProgressIndicator(currentStep: 3),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            _buildHealthInsuranceForm(context),
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

  Widget _buildHealthInsuranceForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            children: [
              Expanded(
                child: InsuranceInputField(
                  label: 'Age',
                  isRequired: true,
                  controller: _ageController,
                  placeholder: '30',
                  isPreFilled: true,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Expanded(
                child: InsuranceInputField(
                  label: 'Gender',
                  isRequired: true,
                  controller: _genderController,
                  placeholder: 'Male',
                  isPreFilled: true,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceInputField(
            label: 'Pre-existing disclosure',
            isRequired: true,
            controller: _preExistingController,
            placeholder: 'Disclosure',
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceInputField(
            label: 'Nominee',
            isRequired: true,
            controller: _nomineeController,
            placeholder: 'Nominee',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Text(
      'Health Insurance',
      style: GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.height * 0.02,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }

  void _handleNextButton(BuildContext context) {
    try {
      debugPrint('Next button tapped - navigating to step 4');
      NavigationService.pushTo(context, const GetInsurance4Page());
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
