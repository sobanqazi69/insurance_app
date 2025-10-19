import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../widgets/insurance_app_bar.dart';
import '../widgets/insurance_progress_indicator.dart';
import '../widgets/insurance_next_button.dart';
import '../widgets/insurance_instruction_text.dart';
import 'getInsurance_2_page.dart';

class GetInsurance1Page extends StatefulWidget {
  const GetInsurance1Page({super.key});

  @override
  State<GetInsurance1Page> createState() => _GetInsurance1PageState();
}

class _GetInsurance1PageState extends State<GetInsurance1Page> {
  double _sumInsuredValue = 500.0;
  final TextEditingController _minPremiumController = TextEditingController();
  final TextEditingController _maxPremiumController = TextEditingController();
  String _selectedTenor = '2 Year';

  static const List<String> _tenureOptions = [
    '1 Year',
    '2 Year',
    '3 Year',
    '4 Year',
    '5 Year',
  ];

  @override
  void initState() {
    super.initState();
    _initializeCalculator();
  }

  @override
  void dispose() {
    _minPremiumController.dispose();
    _maxPremiumController.dispose();
    super.dispose();
  }

  void _initializeCalculator() {
    try {
      _minPremiumController.text = '100';
      _maxPremiumController.text = '1000';
    } catch (e) {
      debugPrint('Error initializing calculator: $e');
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
      debugPrint('Error building GetInsurance1Page: $e');
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
            const InsuranceProgressIndicator(currentStep: 1),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            _buildInsuranceCalculator(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            _buildTotalAmountSection(context),
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




  Widget _buildInsuranceCalculator(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalculatorTitle(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildSumInsuredSection(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          _buildPremiumRangeSection(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          _buildTenorSection(context),
        ],
      ),
    );
  }

  Widget _buildCalculatorTitle(BuildContext context) {
    return Text(
      'Insurance Calculator',
      style: GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.height * 0.02,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildSumInsuredSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sum Insured',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            ),
            Text(
              'Total: PKR ${_sumInsuredValue.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.border,
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withOpacity(0.1),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            trackHeight: 4,
          ),
          child: Slider(
            value: _sumInsuredValue,
            min: 100,
            max: 1000,
            divisions: 18,
            onChanged: (double value) {
              setState(() {
                _sumInsuredValue = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumRangeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Premium Range',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.016,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildPremiumInputField(
                context,
                _minPremiumController,
                true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Text(
                '-',
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: _buildPremiumInputField(
                context,
                _maxPremiumController,
                false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPremiumInputField(
    BuildContext context,
    TextEditingController controller,
    bool isFirst,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.055,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: controller,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
              decoration: InputDecoration(
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.012,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Text(
              'PKR',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTenorSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tenor',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.016,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        Wrap(
          spacing: MediaQuery.of(context).size.width * 0.02,
          runSpacing: MediaQuery.of(context).size.height * 0.01,
          children: _tenureOptions
              .map((tenure) => _buildTenorButton(context, tenure))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTenorButton(BuildContext context, String tenor) {
    final isSelected = _selectedTenor == tenor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTenor = tenor;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.height * 0.008,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gradientStart : AppColors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.0,
          ),
        ),
        child: Text(
          tenor,
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.014,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildTotalAmountSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Total Amount',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.016,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text(
          'PKR ${_calculateTotalAmount().toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.024,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }


  double _calculateTotalAmount() {
    try {
      final baseAmount = _sumInsuredValue * 100; // PKR amount
      return baseAmount;
    } catch (e) {
      debugPrint('Error calculating total amount: $e');
      return 50000.0;
    }
  }

  void _handleNextButton(BuildContext context) {
    try {
      debugPrint('Next button tapped - navigating to step 2');
      NavigationService.pushTo(context, const GetInsurance2Page());
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
          'Error loading insurance calculator',
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
