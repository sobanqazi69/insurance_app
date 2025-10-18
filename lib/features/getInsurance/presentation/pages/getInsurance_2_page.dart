import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../widgets/insurance_app_bar.dart';
import '../widgets/insurance_progress_indicator.dart';
import '../widgets/insurance_input_field.dart';
import '../widgets/insurance_checkbox.dart';
import '../widgets/insurance_next_button.dart';
import '../widgets/insurance_instruction_text.dart';
import 'getInsurance_3_page.dart';

class GetInsurance2Page extends StatefulWidget {
  const GetInsurance2Page({super.key});

  @override
  State<GetInsurance2Page> createState() => _GetInsurance2PageState();
}

class _GetInsurance2PageState extends State<GetInsurance2Page> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _fatherHusbandNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isProposer = false;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cnicController.dispose();
    _fatherHusbandNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _initializeForm() {
    try {
      _cityController.text = 'Rawalpindi';
      _emailController.text = 'mail@info.com';
    } catch (e) {
      debugPrint('Error initializing form: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building GetInsurance2Page: $e');
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
            const InsuranceProgressIndicator(currentStep: 2),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            _buildForm(context),
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


  Widget _buildForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsuranceInputField(
            label: 'Name',
            isRequired: true,
            controller: _nameController,
            placeholder: 'Full Name',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceInputField(
            label: 'CNIC',
            isRequired: true,
            controller: _cnicController,
            placeholder: '#####-#######-#',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceInputField(
            label: 'Father/Husband Name',
            isRequired: true,
            controller: _fatherHusbandNameController,
            placeholder: 'Father name',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceInputField(
            label: 'Address',
            isRequired: false,
            controller: _addressController,
            placeholder: 'Full Address here',
            hasHelpIcon: true,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceInputField(
            label: 'City',
            isRequired: false,
            controller: _cityController,
            placeholder: 'Rawalpindi',
            isPreFilled: true,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceInputField(
            label: 'Email',
            isRequired: false,
            controller: _emailController,
            placeholder: 'mail@info.com',
            isPreFilled: true,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceInputField(
            label: 'Phone',
            isRequired: false,
            controller: _phoneController,
            placeholder: '03-- ---- ---',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          InsuranceCheckbox(
            label: 'Proposer',
            value: _isProposer,
            onChanged: (value) {
              setState(() {
                _isProposer = value;
              });
            },
          ),
        ],
      ),
    );
  }


  void _handleNextButton(BuildContext context) {
    try {
      debugPrint('Next button tapped - navigating to step 3');
      NavigationService.pushTo(context, const GetInsurance3Page());
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
      body: const Center(
        child: Text(
          'Error loading form',
          style: TextStyle(color: AppColors.primary),
        ),
      ),
    );
  }
}
