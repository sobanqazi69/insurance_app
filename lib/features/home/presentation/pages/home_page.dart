import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../../core/widgets/insurance_card.dart';
import '../../../../shared/models/insurance_model.dart';
import '../../../list/presentation/pages/list_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1; // Start with Home selected

  final List<Widget> _pages = [
    const ListPage(),
    const HomeContent(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _currentIndex == 1 ? CustomAppBar(
        userName: 'Pavan',
        onDrawerTap: () {
          // Handle drawer tap
          Scaffold.of(context).openDrawer();
        },
      ) : null,
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

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
      return Container(
        color: Colors.white,
        
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomSearchBar(
                onSearchTap: () {
                  // Handle search icon tap
                  debugPrint('Search icon tapped');
                },
                onFilterTap: () {
                  // Handle filter icon tap
                  debugPrint('Filter icon tapped');
                },
                onTap: () {
                  // Handle search bar tap
                  debugPrint('Search bar tapped');
                },
              ),
            ),
            const SizedBox(height: 20),
            // Insurance Cards Section
            _buildInsuranceSection(),
            const SizedBox(height: 20),
            // Support Section
            _buildSupportSection(),
            // Content
            
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building HomeContent: $e');
      return Container(
        color: Colors.white,
        child: const Center(
          child: Text('Error loading content'),
        ),
      );
    }
  }

  Widget _buildInsuranceSection() {
    try {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
        
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
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

  Widget _buildSupportSection() {
    try {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'For more contact us',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    //ad cdoubl etxt
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '24/7',
                            style: GoogleFonts.poppins(
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text: ' Support',
                              style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('Contact Us button tapped');
                        // Handle contact us action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF2CB69),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Contact Us',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/icons/hand.png',
              ),
              // Hand icon
             
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building support section: $e');
      return const SizedBox.shrink();
    }
  }
}
