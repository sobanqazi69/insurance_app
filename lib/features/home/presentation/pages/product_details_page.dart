import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/models/insurance_model.dart';
import '../../../../shared/services/navigation_service.dart';
import '../../../getInsurance/presentation/pages/getInsurance_1_page.dart';
import '../../../getInsurance/presentation/utils/bottom_sheet_utils.dart';

class ProductDetailsPage extends StatefulWidget {
  final InsuranceModel insurance;
  const ProductDetailsPage({super.key, required this.insurance});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  RangeValues _sumInsuredRange = const RangeValues(200.0, 800.0);
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
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building ProductDetailsPage: $e');
      return _buildErrorWidget(context);
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: _buildBackButton(context),
      title: _buildTitle(),
      centerTitle: false,
      titleSpacing: 0,
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      onPressed: () => _handleBackNavigation(context),
      icon: const Icon(
        Icons.arrow_back_ios,
        color: AppColors.white,
        size: 20.0,
      ),
    );
  }

  void _handleBackNavigation(BuildContext context) {
    try {
      NavigationService.pop(context);
    } catch (e) {
      debugPrint('Error handling back navigation: $e');
    }
  }

  Widget _buildTitle() {
    return Text(
      'Product Details',
      style: GoogleFonts.poppins(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProductHeader(context),
          Transform.translate(
            offset: Offset(0, -MediaQuery.of(context).size.height * 0.04),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: _buildInsuranceCalculator(context),
            ),
          ),
           Transform.translate(
            offset: Offset(0, -MediaQuery.of(context).size.height * 0.04),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
               child:           _buildOverviewSection(context),

             ),
           ),
   Transform.translate(
            offset: Offset(0, -MediaQuery.of(context).size.height * 0.04),
            child: Container(
             
               child:                             _buildBenefitsSection(context),

             ),
           ),
 Transform.translate(
            offset: Offset(0, -MediaQuery.of(context).size.height * 0.04),
            child: Container(
             
               child:                             _buildActionButtonsSection(context),

             ),
           ),






        ],
      ),
    );
  }

 Widget _buildActionButtonsSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  'Docs Required',
                  AppColors.compareButton,
                  Colors.white,
                  true,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Expanded(
                child: _buildActionButton(
                  context,
                  'Reviews',
                  Colors.white,
                  AppColors.compareButton,
                  false,
                  icon: Icons.star,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              _buildAgentSection(context),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  'Compare',
                  Colors.white,
                  AppColors.compareButton,
                  false,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Expanded(
                flex: 2,
                child: _buildActionButton(
                  context,
                  'Apply Now',
                  AppColors.cyan,
                  Colors.white,
                  true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

Widget _buildActionButton(
    BuildContext context,
    String text,
    Color backgroundColor,
    Color textColor,
    bool isFilled, {
    IconData? icon,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: isFilled
            ? null
            : Border.all(color: AppColors.compareButton, width: 1.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () => _handleButtonTap(context, text),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: textColor,
                    size: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                ],
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height * 0.016,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgentSection(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.headset_mic,
          color: AppColors.primary,
          size: MediaQuery.of(context).size.height * 0.025,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Text(
          'Agent',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.016,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  void _handleButtonTap(BuildContext context, String buttonText) {
    try {
      switch (buttonText) {
        case 'Docs Required':
          _showDocsRequired(context);
          break;
        case 'Reviews':
          _showReviews(context);
          break;
        case 'Compare':
          _showCompare(context);
          break;
        case 'Apply Now':
          _showApplyNow(context);
          break;
        default:
          debugPrint('Button tapped: $buttonText');
      }
    } catch (e) {
      debugPrint('Error handling button tap: $e');
    }
  }

  void _showDocsRequired(BuildContext context) {
    try {
      debugPrint('Docs Required feature coming soon');
      // TODO: Navigate to docs required page
    } catch (e) {
      debugPrint('Error handling docs required: $e');
    }
  }

  void _showReviews(BuildContext context) {
    try {
      debugPrint('Reviews feature coming soon');
      // TODO: Navigate to reviews page
    } catch (e) {
      debugPrint('Error handling reviews: $e');
    }
  }

  void _showCompare(BuildContext context) {
    try {
      debugPrint('Compare feature tapped');
      BottomSheetUtils.showCompareBottomSheet(context);
    } catch (e) {
      debugPrint('Error handling compare: $e');
    }
  }

  void _showApplyNow(BuildContext context) {
    try {
      NavigationService.pushTo(context, const GetInsurance1Page());
    } catch (e) {
      debugPrint('Error navigating to GetInsurance1Page: $e');
    }
  }




  Widget _buildProductHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * 0.02,
        right: MediaQuery.of(context).size.height * 0.02,
        bottom: MediaQuery.of(context).size.height * 0.08,
      ),
      child: Row(
        children: [
          _buildCompanyLogo(context),
          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
          Expanded(child: _buildCompanyName(context)),
        ],
      ),
    );
  }

  Widget _buildCompanyLogo(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final logoSize = screenHeight * 0.08;

    return Container(
      width: logoSize,
      height: logoSize,
      decoration: _buildLogoDecoration(),
      child: _buildLogoContent(),
    );
  }

  BoxDecoration _buildLogoDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  Widget _buildLogoContent() {
    return Stack(
      children: [
        Positioned(
          left: 12.0,
          top: 8.0,
          bottom: 8.0,
          child: Container(
            width: 8.0,
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        Positioned(
          top: 8.0,
          left: 12.0,
          right: 12.0,
          child: Container(
            height: 8.0,
            decoration: BoxDecoration(
              color: AppColors.warning,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        Positioned(
          top: 16.0,
          right: 12.0,
          bottom: 8.0,
          child: Container(
            width: 8.0,
            decoration: BoxDecoration(
              color: AppColors.info,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyName(BuildContext context) {
    return Text(
      widget.insurance.companyName,
      style: GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.height * 0.022,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildInsuranceCalculator(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.08),
        //     blurRadius: 8,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalculatorTitle(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildSumInsuredSection(context),
          _buildPremiumRangeSection(context),
          _buildTenorSection(context),
          _buildMonthlyPremiumSection(context),
        ],
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
     
     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.02,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          _buildOverviewRow(context, 'Room & Board Limit', 'General Ward'),
          _buildDivider(context),
          _buildOverviewRow(context, 'Cashless Treatment at', '431 Hospitals'),
          _buildDivider(context),
          _buildOverviewRow(context, 'Discount Available at', '181 Labs'),
          _buildDivider(context),
          _buildOverviewRow(context, 'Room & Board Limit', 'General Ward'),
          _buildDivider(context),
          _buildOverviewRow(context, 'Cashless Treatment at', '431 Hospitals'),
          _buildDivider(context),
          _buildOverviewRow(context, 'Discount Available at', '181 Labs'),
                    _buildDivider(context),

        ],
      ),
    );
  }

  Widget _buildOverviewRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.005,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.014,
                fontWeight: FontWeight.w400,
                // fontStyle: FontStyle.italic,
                color: AppColors.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.black,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.005,
      ),
    );
  }

  Widget _buildBenefitsSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Benefits',
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.02,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildBenefitItem(
            context,
            'Credit Facility in 200+ Hospitals all across Pakistan',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          _buildBenefitItem(
            context,
            'No Medical Test Required',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          _buildBenefitItem(
            context,
            '14 days free look up period - option of cancelling if not satisfied',
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.height * 0.025,
          height: MediaQuery.of(context).size.height * 0.025,
         
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/check_tick.svg',
            
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.016,
              fontWeight: FontWeight.w400,
              color: AppColors.primary,
              height: 1.4,
            ),
          ),
        ),
      ],
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
                fontSize: MediaQuery.of(context).size.height * 0.018,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
                fontStyle: FontStyle.italic,
              ),
            ),
            Row(
              children: [
                Text(
                  'Total: ',
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'PKR ${_sumInsuredRange.end.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.border,
            thumbColor: AppColors.primary,
            overlayColor: Color(0x1A083146),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            trackHeight: 3,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 6,
            ),
            rangeTrackShape: const RectangularRangeSliderTrackShape(),
            rangeValueIndicatorShape:
                const PaddleRangeSliderValueIndicatorShape(),
          ),
          child: RangeSlider(
            values: _sumInsuredRange,
            min: 100,
            max: 1000,
            divisions: 18,
            onChanged: (RangeValues values) {
              setState(() {
                _sumInsuredRange = values;
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
            fontSize: MediaQuery.of(context).size.height * 0.018,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        Row(
          children: [
            Expanded(
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
          'Tenure',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.018,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        Wrap(
          spacing: MediaQuery.of(context).size.width * 0.02,
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
          horizontal: MediaQuery.of(context).size.width * 0.035,
          vertical: MediaQuery.of(context).size.height * 0.008,
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gradientStart : AppColors.white,
          borderRadius: BorderRadius.circular(16.0),
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

  Widget _buildMonthlyPremiumSection(BuildContext context) {
    return Row(
      children: [
        Text(
          'Monthly',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.018,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Text(
          'PKR ${_calculateMonthlyPremium().toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.022,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  double _calculateMonthlyPremium() {
    try {
      final basePremium = _sumInsuredRange.end * 0.1;
      final tenorMultiplier = _getTenorMultiplier(_selectedTenor);
      return basePremium * tenorMultiplier;
    } catch (e) {
      debugPrint('Error calculating monthly premium: $e');
      return 1200.0;
    }
  }

  double _getTenorMultiplier(String tenor) {
    switch (tenor) {
      case '1 Year':
        return 1.0;
      case '2 Year':
        return 0.9;
      case '3 Year':
        return 0.8;
      case '4 Year':
        return 0.7;
      case '5 Year':
        return 0.6;
      default:
        return 0.9;
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => NavigationService.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
        ),
        title: Text(
          'Product Details',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Error loading product details',
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
