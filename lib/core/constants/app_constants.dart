class AppConstants {
  // App Information
  static const String appName = 'Insurance App';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.insurance-app.com';
  static const String apiVersion = '/v1';
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Validation Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[\d\s-]{10,}$';
  static const String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';
  
  // File Upload Limits
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxDocumentSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'webp'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx'];
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Error Messages
  static const String networkErrorMessage = 'Please check your internet connection';
  static const String serverErrorMessage = 'Something went wrong. Please try again later';
  static const String unauthorizedMessage = 'Please login to continue';
  static const String forbiddenMessage = 'You don\'t have permission to perform this action';
  
  // Success Messages
  static const String loginSuccessMessage = 'Login successful';
  static const String logoutSuccessMessage = 'Logout successful';
  static const String profileUpdateMessage = 'Profile updated successfully';
  static const String passwordChangeMessage = 'Password changed successfully';
  
  // Insurance Specific Constants
  static const List<String> insuranceTypes = [
    'Auto Insurance',
    'Home Insurance',
    'Health Insurance',
    'Life Insurance',
    'Travel Insurance',
    'Business Insurance'
  ];
  
  static const List<String> claimStatuses = [
    'Pending',
    'Under Review',
    'Approved',
    'Rejected',
    'Paid'
  ];
  
  static const List<String> paymentMethods = [
    'Credit Card',
    'Debit Card',
    'Bank Transfer',
    'PayPal',
    'Apple Pay',
    'Google Pay'
  ];
}
