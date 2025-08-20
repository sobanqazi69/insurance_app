class ApiEndpoints {
  // Base URLs
  static const String baseUrl = 'https://api.insurance-app.com/v1';
  
  // Authentication Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String resendVerification = '/auth/resend-verification';
  
  // User Profile Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String changePassword = '/user/change-password';
  static const String uploadAvatar = '/user/avatar/upload';
  static const String deleteAvatar = '/user/avatar/delete';
  
  // Insurance Policies Endpoints
  static const String policies = '/policies';
  static const String policyDetails = '/policies/{id}';
  static const String createPolicy = '/policies/create';
  static const String updatePolicy = '/policies/{id}/update';
  static const String cancelPolicy = '/policies/{id}/cancel';
  static const String renewPolicy = '/policies/{id}/renew';
  static const String policyDocuments = '/policies/{id}/documents';
  static const String downloadPolicy = '/policies/{id}/download';
  
  // Claims Endpoints
  static const String claims = '/claims';
  static const String claimDetails = '/claims/{id}';
  static const String createClaim = '/claims/create';
  static const String updateClaim = '/claims/{id}/update';
  static const String cancelClaim = '/claims/{id}/cancel';
  static const String claimDocuments = '/claims/{id}/documents';
  static const String uploadClaimDocument = '/claims/{id}/documents/upload';
  static const String claimStatus = '/claims/{id}/status';
  
  // Payments Endpoints
  static const String payments = '/payments';
  static const String paymentDetails = '/payments/{id}';
  static const String createPayment = '/payments/create';
  static const String paymentMethods = '/payments/methods';
  static const String addPaymentMethod = '/payments/methods/add';
  static const String removePaymentMethod = '/payments/methods/{id}/remove';
  static const String paymentHistory = '/payments/history';
  static const String upcomingPayments = '/payments/upcoming';
  
  // Insurance Types Endpoints
  static const String insuranceTypes = '/insurance-types';
  static const String insuranceTypeDetails = '/insurance-types/{id}';
  static const String insuranceQuotes = '/insurance-types/{id}/quotes';
  static const String calculatePremium = '/insurance-types/{id}/calculate-premium';
  
  // Notifications Endpoints
  static const String notifications = '/notifications';
  static const String notificationDetails = '/notifications/{id}';
  static const String markAsRead = '/notifications/{id}/read';
  static const String markAllAsRead = '/notifications/read-all';
  static const String deleteNotification = '/notifications/{id}/delete';
  static const String notificationSettings = '/notifications/settings';
  static const String updateNotificationSettings = '/notifications/settings/update';
  
  // Support Endpoints
  static const String supportTickets = '/support/tickets';
  static const String createTicket = '/support/tickets/create';
  static const String ticketDetails = '/support/tickets/{id}';
  static const String updateTicket = '/support/tickets/{id}/update';
  static const String closeTicket = '/support/tickets/{id}/close';
  static const String ticketMessages = '/support/tickets/{id}/messages';
  static const String sendMessage = '/support/tickets/{id}/messages/send';
  
  // Dashboard Endpoints
  static const String dashboard = '/dashboard';
  static const String dashboardStats = '/dashboard/stats';
  static const String recentActivities = '/dashboard/activities';
  static const String upcomingRenewals = '/dashboard/renewals';
  static const String expiringPolicies = '/dashboard/expiring';
  
  // Documents Endpoints
  static const String documents = '/documents';
  static const String documentDetails = '/documents/{id}';
  static const String uploadDocument = '/documents/upload';
  static const String downloadDocument = '/documents/{id}/download';
  static const String deleteDocument = '/documents/{id}/delete';
  
  // Reports Endpoints
  static const String reports = '/reports';
  static const String generateReport = '/reports/generate';
  static const String downloadReport = '/reports/{id}/download';
  static const String reportHistory = '/reports/history';
  
  // Utility Endpoints
  static const String healthCheck = '/health';
  static const String appVersion = '/version';
  static const String countries = '/countries';
  static const String states = '/countries/{countryId}/states';
  static const String cities = '/states/{stateId}/cities';
}
