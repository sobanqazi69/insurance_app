import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/insurance_card.dart';
import '../../../../shared/models/insurance_model.dart';

class InsuranceSectionWidget extends StatelessWidget {
  const InsuranceSectionWidget({super.key});

  // Sample insurance data
  static const List<InsuranceModel> _sampleInsuranceData = [
    InsuranceModel(
      id: '1',
      companyName: 'Alfalah Car Insurance',
      premiumAmount: 'Rs. 5 Lac',
      monthlyAmount: 'Rs. 2500',
      workshopCount: '225',
    ),
    InsuranceModel(
      id: '2',
      companyName: 'Jubilee General Insurance',
      premiumAmount: 'Rs. 3 Lac',
      monthlyAmount: 'Rs. 1800',
      workshopCount: '180',
    ),
    InsuranceModel(
      id: '3',
      companyName: 'EFU General Insurance',
      premiumAmount: 'Rs. 4 Lac',
      monthlyAmount: 'Rs. 2200',
      workshopCount: '200',
    ),
    InsuranceModel(
      id: '4',
      companyName: 'Adamjee Insurance',
      premiumAmount: 'Rs. 6 Lac',
      monthlyAmount: 'Rs. 3000',
      workshopCount: '250',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final cardHeight = screenHeight * 0.3; // 35% of screen height
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Buy Insurance', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.textPrimary , fontStyle: FontStyle.italic),),
                Row(
                  children: [
                    Text('All Categories ', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.textPrimary , fontStyle: FontStyle.italic),),
                    Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.textPrimary,),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          // Horizontal ListView
          SizedBox(
            height: cardHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.025),
              itemCount: _sampleInsuranceData.length,
              itemBuilder: (context, index) {
                try {
                  final insurance = _sampleInsuranceData[index];
                  return InsuranceCard(
                    companyName: insurance.companyName,
                    premiumAmount: insurance.premiumAmount,
                    monthlyAmount: insurance.monthlyAmount,
                    workshopCount: insurance.workshopCount,
                    onCompare: () {
                      debugPrint('Compare tapped for ${insurance.companyName}');
                      // Handle compare action
                    },
                    onView: () {
                      debugPrint('View tapped for ${insurance.companyName}');
                      // Handle view action
                    },
                  );
                } catch (e) {
                  debugPrint('Error building insurance card at index $index: $e');
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      );
    } catch (e) {
      debugPrint('Error building insurance section: $e');
      return const SizedBox.shrink();
    }
  }
}
