import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../widgets/insurance_section_widget.dart';
import '../widgets/support_section_widget.dart';
import '../widgets/claims_policies_section_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      
      return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.025),
                child: CustomSearchBar(
                  onSearchTap: () {
                    debugPrint('Search icon tapped');
                  },
                  onFilterTap: () {
                    debugPrint('Filter icon tapped');
                  },
                  onTap: () {
                    debugPrint('Search bar tapped');
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              // Insurance Cards Section
              const InsuranceSectionWidget(),
              SizedBox(height: screenHeight * 0.025),
              // Support Section
              const SupportSectionWidget(),
              SizedBox(height: screenHeight * 0.025),
              // My Claims and My Policies Section
              const ClaimsPoliciesSectionWidget(),
              SizedBox(height: screenHeight * 0.025), // Bottom padding for scrolling
            ],
          ),
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
}
