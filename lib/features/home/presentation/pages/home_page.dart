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

/// Main home page widget that manages the bottom navigation and displays content.
/// 
/// This widget provides:
/// - Bottom navigation between List, Home, and Profile pages
/// - Custom app bar for the home page
/// - Proper state management for navigation
/// - Error handling and fallback UI
/// 
/// Features:
/// - Responsive design for all screen sizes
/// - Clean separation of concerns
/// - Proper widget lifecycle management
/// 
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => const HomePage()),
/// );
/// ```
class HomePage extends StatefulWidget {
  /// Creates a home page widget
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State class for the HomePage widget
/// 
/// Manages the bottom navigation state and handles page switching
/// with proper error handling and performance optimizations.
class _HomePageState extends State<HomePage> {
  /// Current selected tab index (0: List, 1: Home, 2: Profile)
  int _currentIndex = _HomePageConstants.defaultTabIndex;

  /// List of pages corresponding to bottom navigation tabs
  static const List<Widget> _pages = [
    ListPage(),
    HomeContent(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      );
    } catch (e) {
      debugPrint('Error building HomePage: $e');
      return _buildErrorWidget();
    }
  }

  /// Builds the app bar for the home page
  PreferredSizeWidget? _buildAppBar() {
    if (_currentIndex != _HomePageConstants.homeTabIndex) return null;
    
    return CustomAppBar(
      userName: _HomePageConstants.defaultUserName,
      onDrawerTap: _handleDrawerTap,
    );
  }

  /// Handles drawer tap with error handling
  void _handleDrawerTap() {
    try {
      Scaffold.of(context).openDrawer();
    } catch (e) {
      debugPrint('Error opening drawer: $e');
    }
  }

  /// Builds the main body content
  Widget _buildBody() {
    return Container(
      color: Colors.white,
      child: _pages[_currentIndex],
    );
  }

  /// Builds the bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return CustomBottomNavBar(
      currentIndex: _currentIndex,
      onTap: _handleTabChange,
    );
  }

  /// Handles tab change with error handling
  void _handleTabChange(int index) {
    try {
      if (index >= 0 && index < _pages.length) {
        setState(() {
          _currentIndex = index;
        });
      }
    } catch (e) {
      debugPrint('Error changing tab: $e');
    }
  }

  /// Builds error widget as fallback
  Widget _buildErrorWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: Text('Error loading page'),
      ),
    );
  }
}

/// Home content widget that manages search functionality and displays content.
/// 
/// This widget provides:
/// - Search bar with filter functionality
/// - Conditional content display based on search state
/// - Sort popup management
/// - Proper focus management and keyboard handling
/// 
/// Features:
/// - Responsive design for all screen sizes
/// - Clean state management
/// - Error handling with fallback UI
/// - Performance optimizations
/// 
/// Usage:
/// ```dart
/// const HomeContent()
/// ```
class HomeContent extends StatefulWidget {
  /// Creates a home content widget
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

/// State class for the HomeContent widget
/// 
/// Manages search state, sort popup visibility, and user interactions
/// with proper error handling and performance optimizations.
class _HomeContentState extends State<HomeContent> {
  // Search state management
  bool _isSearching = false;
  bool _showSortPopup = false;
  String _selectedSort = _HomeContentConstants.defaultSortOption;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Handles search text changes with error handling
  void _onSearchChanged(String value) {
    try {
      setState(() {
        _isSearching = value.isNotEmpty;
      });
    } catch (e) {
      debugPrint('Error handling search change: $e');
    }
  }

  /// Toggles sort popup visibility with error handling
  void _toggleSortPopup() {
    try {
      setState(() {
        _showSortPopup = !_showSortPopup;
      });
    } catch (e) {
      debugPrint('Error toggling sort popup: $e');
    }
  }

  /// Handles sort option selection with error handling
  void _onSortSelected(String sortType) {
    try {
      setState(() {
        _selectedSort = sortType;
      });
    } catch (e) {
      debugPrint('Error selecting sort option: $e');
    }
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

/// Constants for the HomePage widget
/// 
/// This class contains all the configuration constants used in the HomePage
/// to ensure consistency and maintainability.
class _HomePageConstants {
  // Tab indices
  static const int listTabIndex = 0;
  static const int homeTabIndex = 1;
  static const int profileTabIndex = 2;
  static const int defaultTabIndex = homeTabIndex;
  
  // User information
  static const String defaultUserName = 'Pavan';
}

/// Constants for the HomeContent widget
/// 
/// This class contains all the configuration constants used in the HomeContent
/// to ensure consistency and maintainability.
class _HomeContentConstants {
  // Search and sort options
  static const String defaultSortOption = 'newest';
  
  // UI Constants
  static const double searchBarPadding = 0.025; // 2.5% of screen height
  static const double sectionSpacing = 0.02; // 2% of screen height
  static const double contentSpacing = 0.025; // 2.5% of screen height
  static const double popupTopOffset = 0.1; // 10% of screen height
  static const double popupRightOffset = 0.025; // 2.5% of screen height
}
