import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../../../getInsurance/presentation/widgets/insurance_progress_indicator.dart';
import '../../../getInsurance/presentation/widgets/insurance_next_button.dart';
import '../widgets/claim_header.dart';
import '../widgets/claim_text_field.dart';
import 'claim_4_page.dart';

class Claim3Page extends StatefulWidget {
  const Claim3Page({super.key});

  @override
  State<Claim3Page> createState() => _Claim3PageState();
}

class _Claim3PageState extends State<Claim3Page> {
  final TextEditingController _briefController = TextEditingController();

  @override
  void dispose() {
    _briefController.dispose();
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
      debugPrint('Error building Claim3Page: $e');
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
      child: const InsuranceProgressIndicator(currentStep: 3),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBriefField(context),
        ],
      ),
    );
  }

  Widget _buildBriefField(BuildContext context) {
    return ClaimTextField(
      label: 'Full Brief',
      hintText: 'Brief description',
      controller: _briefController,
      maxLines: 4,
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
      if (_briefController.text.isEmpty) {
        debugPrint('Please fill the brief description');
        return;
      }
      NavigationService.pushTo(context, const Claim4Page());
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
