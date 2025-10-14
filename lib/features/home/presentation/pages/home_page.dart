import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../widgets/insurance_section_widget.dart';
import '../widgets/support_section_widget.dart';
import '../widgets/claims_policies_section_widget.dart';
import '../widgets/filter_bar_widget.dart';
import '../widgets/vertical_insurance_cards_widget.dart';
import '../widgets/sort_popup_widget.dart';
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

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool _isSearching = false;
  bool _showSortPopup = false;
  String _selectedSort = 'newest';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _isSearching = value.isNotEmpty;
    });
  }

  void _toggleSortPopup() {
    setState(() {
      _showSortPopup = !_showSortPopup;
    });
  }

  void _onSortSelected(String sortType) {
    setState(() {
      _selectedSort = sortType;
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      
      return GestureDetector(
        onTap: () {
          // Unfocus TextField when tapping outside
          FocusScope.of(context).unfocus();
          // Close popup when tapping outside
          if (_showSortPopup) {
            setState(() {
              _showSortPopup = false;
            });
          }
        },
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Search Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.025),
                    child: CustomSearchBar(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      isFilterActive: _showSortPopup,
                      onSearchTap: () {
                        debugPrint('Search icon tapped');
                      },
                      onFilterTap: _toggleSortPopup,
                      onTap: () {
                        debugPrint('Search bar tapped');
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  
                  // Content based on search state
                  Expanded(
                    child: _isSearching ? _buildSearchResults() : _buildNormalContent(),
                  ),
                ],
              ),
            ),
            // Sort Popup
            if (_showSortPopup)
              Positioned(
                top: screenHeight * 0.1,
                right: screenHeight * 0.025,
                child: SortPopupWidget(
                  onClose: () {
                    setState(() {
                      _showSortPopup = false;
                    });
                  },
                  selectedSort: _selectedSort,
                  onSortSelected: _onSortSelected,
                ),
              ),
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

  Widget _buildNormalContent() {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return SingleChildScrollView(
      child: Column(
        children: [
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
    );
  }

  Widget _buildSearchResults() {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      children: [
        // Filter Bar
        const FilterBarWidget(),
        SizedBox(height: screenHeight * 0.02),
        // Vertical Insurance Cards
        const Expanded(
          child: VerticalInsuranceCardsWidget(),
        ),
      ],
    );
  }
}
